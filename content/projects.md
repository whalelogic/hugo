+++
date = "2025-11-16T13:25:14-05:00"
draft = false
title = "Projects"
+++

## My Projects

<div class="projects-grid">
{{< github repo="whalelogic/Go-Programming" showThumbnail=true >}}
{{< github repo="whalelogic/hugo" showThumbnail=true >}}
{{< github repo="whalelogic/Arcade-Snake-Game" showThumbnail=true >}}
{{< github repo="whalelogic/Awesome-Vue-Frontend" showThumbnail=true >}}
{{< github repo="whalelogic/coderef" showThumbnail=true >}}
{{< github repo="whalelogic/terraincloudnito" showThumbnail=true >}}
{{< github repo="whalelogic/gotth" showThumbnail=true >}}
</div>



<!---->
<!-- <div id="github-projects" class="projects-grid">Loading projects...</div> -->
<!---->
<!-- <style> -->
<!-- body { -->
<!--     background-color: #0f172a; /* Dark background */ -->
<!--     color: #e2e8f0; -->
<!--     font-family: 'Inter', sans-serif; -->
<!-- } -->
<!---->
<!-- .projects-grid { -->
<!--     display: grid; -->
<!--     grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); -->
<!--     gap: 2rem; -->
<!--     margin-top: 2rem; -->
<!-- } -->
<!---->
<!-- /* Glassy gradient card style */ -->
<!-- .project-card { -->
<!--     background: linear-gradient(135deg, rgba(255,255,255,0.05), rgba(255,255,255,0.1)); -->
<!--     border-radius: 1rem; -->
<!--     padding: 1.5rem; -->
<!--     box-shadow: 0 8px 24px rgba(0,0,0,0.4); -->
<!--     backdrop-filter: blur(8px); -->
<!--     transition: transform 0.3s ease, box-shadow 0.3s ease; -->
<!--     display: flex; -->
<!--     flex-direction: column; -->
<!--     justify-content: space-between; -->
<!-- } -->
<!---->
<!-- .project-card:hover { -->
<!--     transform: translateY(-6px); -->
<!--     box-shadow: 0 16px 40px rgba(0,0,0,0.6); -->
<!-- } -->
<!---->
<!-- .project-card a { -->
<!--     font-size: 1.2rem; -->
<!--     font-weight: 700; -->
<!--     color: #38bdf8; -->
<!--     text-decoration: none; -->
<!--     margin-bottom: 0.5rem; -->
<!-- } -->
<!---->
<!-- .project-card a:hover { -->
<!--     color: #0ea5e9; -->
<!--     text-decoration: underline; -->
<!-- } -->
<!---->
<!-- .project-card p { -->
<!--     font-size: 0.95rem; -->
<!--     color: #cbd5e1; -->
<!--     margin-bottom: 1rem; -->
<!--     line-height: 1.5; -->
<!-- } -->
<!---->
<!-- .repo-stats { -->
<!--     display: flex; -->
<!--     gap: 1rem; -->
<!--     font-size: 0.85rem; -->
<!--     color: #94a3b8; -->
<!--     align-items: center; -->
<!-- } -->
<!---->
<!-- .repo-stats span { -->
<!--     display: flex; -->
<!--     align-items: center; -->
<!--     gap: 0.25rem; -->
<!-- } -->
<!---->
<!-- .repo-stats svg { -->
<!--     width: 16px; -->
<!--     height: 16px; -->
<!--     fill: #94a3b8; -->
<!-- } -->
<!-- </style> -->
<!---->
<!-- <script> -->
<!-- const starIcon = '<svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"><path d="M8 12.027L3.347 14l.644-4.356L0 6.773l4.383-.637L8 2l1.617 4.136L14 6.773l-3.991 2.871.644 4.356z"/></svg>'; -->
<!-- const forkIcon = '<svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg"><path d="M5 3.09a1.5 1.5 0 11-1 2.77v3.08a1.5 1.5 0 11-1 0V5.86a1.5 1.5 0 111-2.77zM11 3.09a1.5 1.5 0 11-1 2.77v3.08a1.5 1.5 0 11-1 0V5.86a1.5 1.5 0 111-2.77zM8 10.5a1.5 1.5 0 11-1 2.598v.902h2v-.902A1.5 1.5 0 118 10.5z"/></svg>'; -->
<!---->
<!-- async function fetchRepos() { -->
<!--     const response = await fetch('https://api.github.com/users/whalelogic/repos'); -->
<!--     const repos = await response.json(); -->
<!--     const container = document.getElementById('github-projects'); -->
<!--     container.innerHTML = ''; -->
<!---->
<!--     repos.forEach(repo => { -->
<!--         const card = document.createElement('div'); -->
<!--         card.className = 'project-card'; -->
<!---->
<!--         const stats = ` -->
<!--             <div class="repo-stats"> -->
<!--                 <span>${starIcon} ${repo.stargazers_count}</span> -->
<!--                 <span>${forkIcon} ${repo.forks_count}</span> -->
<!--                 <span>${repo.language || ''}</span> -->
<!--             </div> -->
<!--         `; -->
<!---->
<!--         card.innerHTML = ` -->
<!--             <a href="${repo.html_url}" target="_blank">${repo.name}</a> -->
<!--             <p>${repo.description || 'No description provided.'}</p> -->
<!--             ${stats} -->
<!--         `; -->
<!--         container.appendChild(card); -->
<!--     }); -->
<!-- } -->
<!---->
<!-- fetchRepos(); -->
<!-- </script> -->

