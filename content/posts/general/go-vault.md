---
date: "2025-11-27T12:00:00-05:00"
author: "Keith Thomson"
categories:
  - "Programming"
  - "Guides"
  - "Go"
  - "Systems Design"
description: "Designing a secure password manager is a great project to master Go. This comprehensive design document covers CLI structure, file I/O, serialization, and cryptography for building GoVault."
tags:
  - "go"
  - "cli"
  - "cryptography"
  - "guide"
  - "systems design"
title: "🏫 Password Management CLI tool - Your Guide"
---

## Password Management Application

### Go is the perfect tool for CLI applications

Designing a secure password manager is a great project to master Go. It touches on CLI structure, file I/O, serialization, and most importantly, cryptography.

This is a comprehensive design document for **"GoVault"**, the CLI password manager we'll build.

---

### 1. High-Level Architecture

We will use a modular "Clean Architecture" approach to separate user interaction, business logic, and storage.

```text
[ User ]
   │
   ▼
[ CLI Layer (cmd) ] ───> Uses Cobra/Viper
   │
   ▼
[ Service Layer ] ──────> Business Logic (Add, Retrieve, Generate)
   │
   ├─> [ Crypto Layer ] ─> Argon2 (KDF) + AES-GCM (Encryption)
   │
   ▼
[ Storage Layer ] ──────> JSON/Gob File (Persisted on disk)
```

### 2. Recommended Tech Stack
Don't reinvent the wheel. Go has an amazing ecosystem for this.

*   **CLI Framework:** `github.com/spf13/cobra` (Industry standard for subcommands).
*   **Configuration:** `github.com/spf13/viper` (Handle config files and flags).
*   **Prompts:** `github.com/manifoldco/promptui` (Interactive selection and hidden password inputs).
*   **Clipboard:** `github.com/atotto/clipboard` (To copy passwords without displaying them).
*   **Table Output:** `github.com/olekukonko/tablewriter` (Pretty print lists).
*   **Cryptography:**
    *   `golang.org/x/crypto/argon2` (For deriving the encryption key from the master password).
    *   `crypto/aes` & `crypto/cipher` (Standard library for encryption).

---

### 3. Security Design

You should implement a **Zero-Knowledge** architecture. The application never stores the "Master Password" in plain text.

1.  **Key Derivation Function (KDF):**
    *   When the user types their Master Password, use **Argon2id**.
    *   *Input:* Master Password + Random Salt (32 bytes, stored in the file header).
    *   *Output:* A 32-byte Encryption Key.
2.  **Encryption:**
    *   Algorithm: **AES-256-GCM** (Galois/Counter Mode).
    *   Why GCM? It provides both confidentiality (encryption) and integrity (authentication). If the file is tampered with, decryption will fail.
    *   A unique **Nonce** (number used once) must be generated for every save operation and stored alongside the ciphertext.

### 4. Data Model

We can store the vault as a single file (e.g., `~/.govault.json` or a binary format).

**The Go Structs:**

```go
package model

import "time"

// The overarching file structure
type VaultFile struct {
    Salt       []byte `json:"salt"`       // 32 bytes, public
    Nonce      []byte `json:"nonce"`      // 12 bytes, public (for GCM)
    Data       []byte `json:"data"`       // The encrypted blob of the Vault struct below
}

// The decrypted data structure
type Vault struct {
    Entries []Entry `json:"entries"`
    Updated time.Time `json:"updated"`
}

type Entry struct {
    ID        string    `json:"id"`
    Service   string    `json:"service"`  // e.g. "github.com"
    Username  string    `json:"username"`
    Password  string    `json:"password"`
    Notes     string    `json:"notes"`
    CreatedAt time.Time `json:"created_at"`
}
```

---

### 5. CLI Command Structure

The user experience should be intuitive. The user should be able to guess commands in some instances, such as when it only makes sense to use a spefic word like **add** or **delete. 😊** 

| Command | Usage | Description |
| :--- | :--- | :--- |
| `govault init` | `govault init` | Initialize a new vault. Asks to set a Master Password. |
| `govault add` | `govault add <service>` | Interactive prompt to add user/pass for a service. |
| `govault get` | `govault get <service>` | Decrypts and copies the password to the clipboard. Auto-clears clip after 15s. |
| `govault list` | `govault list` | Lists all services (names/usernames only). |
| `govault gen` | `govault gen -l 20` | Generates a random secure password. |
| `govault delete`| `govault delete <service>` | Removes an entry. |

---

### 6. Project Directory Structure

```text
govault/
├── cmd/
│   └── root.go          # Entry point, initializes Cobra
│   └── init.go          # 'init' command
│   └── add.go           # 'add' command
│   └── get.go           # 'get' command
├── internal/
│   ├── crypto/
│   │   ├── argon.go     # Key derivation logic
│   │   └── aes.go       # Encrypt/Decrypt logic
│   ├── storage/
│   │   └── file.go      # Read/Write JSON to disk
│   └── utils/
│       └── prompt.go    # UI helper functions
├── main.go
└── go.mod
```

---

### 7. Core Implementation Snippets

Here is how the **Crypto Layer** (the hardest part) should look to be secure.

**`internal/crypto/crypto.go`**

```go
package crypto

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"errors"
	"io"

	"golang.org/x/crypto/argon2"
)

// DeriveKey converts a human password into a 32-byte AES key using a salt
func DeriveKey(password string, salt []byte) []byte {
	// Argon2id parameters: time=1, memory=64MB, threads=4, keyLen=32
	return argon2.IDKey([]byte(password), salt, 1, 64*1024, 4, 32)
}

// GenerateRandomBytes creates a salt or nonce
func GenerateRandomBytes(n int) ([]byte, error) {
	b := make([]byte, n)
	_, err := rand.Read(b)
	if err != nil {
		return nil, err
	}
	return b, nil
}

// Encrypt encrypts data using AES-256-GCM
func Encrypt(plainText []byte, key []byte) ([]byte, []byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, nil, err
	}

	// GCM handles authentication (checks if data was tampered)
	aesGCM, err := cipher.NewGCM(block)
	if err != nil {
		return nil, nil, err
	}

	// Create a unique nonce for this encryption
	nonce, err := GenerateRandomBytes(aesGCM.NonceSize())
	if err != nil {
		return nil, nil, err
	}

	// Encrypt and append authentication tag
	cipherText := aesGCM.Seal(nil, nonce, plainText, nil)
	return cipherText, nonce, nil
}

// Decrypt decrypts data
func Decrypt(cipherText []byte, key []byte, nonce []byte) ([]byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	aesGCM, err := cipher.NewGCM(block)
	if err != nil {
		return nil, err
	}

	plainText, err := aesGCM.Open(nil, nonce, cipherText, nil)
	if err != nil {
		return nil, errors.New("decryption failed: invalid password or corrupted data")
	}

	return plainText, nil
}
```

### 8. Implementation Roadmap

1.  **Setup Phase:** Initialize `go mod` and install Cobra (`cobra-cli init`).
2.  **Storage Logic:** Create the structs for `VaultFile` and `Vault`. Write functions to save structs to JSON files and read them back.
3.  **Crypto Phase:** Implement the Argon2 + AES logic. Write a unit test to ensure `Decrypt(Encrypt(data))` works.
4.  **Init Command:** Wire up `govault init`. It should generate a random salt, ask for a master password, encrypt an empty vault, and save the file.
5.  **Add Command:** Read file -> Ask Master Password -> Derive Key -> Decrypt -> Append new entry -> Encrypt -> Save file.
6.  **Get Command:** Read file -> Decrypt -> Find entry -> `clipboard.WriteAll(pass)`.

### 9. Future Enhancements (Version 2.0)

*   **Memory Safety:** Use libraries like `memguard` to wipe the master password from RAM immediately after use so it cannot be dumped from memory.
*   **Sync:** Add support for storing the encrypted JSON file on S3 or Google Drive.
*   **Auto-lock:** Cache the key in a system keyring (like OS X Keychain) for 5 minutes so the user doesn't have to type the password every single time.
