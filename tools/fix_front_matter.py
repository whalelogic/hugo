import os
import re
import yaml

def generate_tags_and_categories(title):
    tags = []
    categories = []
    title = title.lower()

    # Define keywords for categories and tags
    keyword_map = {
        'python': {'category': 'Programming', 'tags': ['python', 'programming']},
        'go': {'category': 'Programming', 'tags': ['go', 'golang', 'programming']},
        'rust': {'category': 'Programming', 'tags': ['rust', 'programming']},
        'javascript': {'category': 'Programming', 'tags': ['javascript', 'web-development']},
        'typescript': {'category': 'Programming', 'tags': ['typescript', 'web-development']},
        'ruby': {'category': 'Programming', 'tags': ['ruby', 'programming']},
        'docker': {'category': 'DevOps', 'tags': ['docker', 'devops']},
        'nginx': {'category': 'DevOps', 'tags': ['nginx', 'web-server']},
        'http': {'category': 'Web Development', 'tags': ['http', 'networking']},
        'api': {'category': 'Web Development', 'tags': ['api', 'web-services']},
        'data': {'category': 'Data Science', 'tags': ['data', 'data-analysis']},
        'machine learning': {'category': 'Data Science', 'tags': ['machine-learning', 'ai']},
        'ethics': {'category': 'Technology', 'tags': ['ethics', 'philosophy']},
        'finance': {'category': 'Technology', 'tags': ['finance', 'fintech']},
        'iot': {'category': 'Technology', 'tags': ['iot', 'sensors']},
        'security': {'category': 'Security', 'tags': ['security', 'cybersecurity']},
    }

    for keyword, mapping in keyword_map.items():
        if keyword in title:
            if mapping['category'] not in categories:
                categories.append(mapping['category'])
            for tag in mapping['tags']:
                if tag not in tags:
                    tags.append(tag)

    if not categories:
        categories.append('Technology')
    if not tags:
        tags.append('general')

    return tags, categories

def fix_front_matter(file_path):
    with open(file_path, 'r') as f:
        content = f.read()

    match = re.match(r'^---\n(.*?)\n---\n', content, re.DOTALL)
    if not match:
        body = content
        front_matter_dict = {}
        title_match = re.search(r'# (.*)', body)
        if title_match:
            title = title_match.group(1)
        else:
            title = os.path.basename(file_path).replace('.md', '').replace('_', ' ').title()
        
        front_matter_dict['title'] = title
        front_matter_dict['author'] = 'Keith Thomson'
        tags, categories = generate_tags_and_categories(title)
        front_matter_dict['tags'] = tags
        front_matter_dict['categories'] = categories
        
        new_front_matter = yaml.dump(front_matter_dict, default_flow_style=False)
        new_content = f'---\n{new_front_matter}---\n{body}'

    else:
        front_matter = match.group(1)
        body = content[match.end():]
        
        try:
            front_matter_dict = yaml.safe_load(front_matter)
            if not isinstance(front_matter_dict, dict):
                front_matter_dict = {}
        except yaml.YAMLError:
            front_matter_dict = {}

        if 'title' not in front_matter_dict:
            title_match = re.search(r'# (.*)', body)
            if title_match:
                title = title_match.group(1)
            else:
                title = os.path.basename(file_path).replace('.md', '').replace('_', ' ').title()
            front_matter_dict['title'] = title
        
        if 'author' not in front_matter_dict:
            front_matter_dict['author'] = 'Keith Thomson'

        tags, categories = generate_tags_and_categories(front_matter_dict.get('title', ''))
        
        if 'tags' not in front_matter_dict:
            front_matter_dict['tags'] = []
        
        if 'categories' not in front_matter_dict:
            front_matter_dict['categories'] = []

        for tag in tags:
            if tag not in front_matter_dict['tags']:
                front_matter_dict['tags'].append(tag)
        
        for category in categories:
            if category not in front_matter_dict['categories']:
                front_matter_dict['categories'].append(category)

        new_front_matter = yaml.dump(front_matter_dict, default_flow_style=False)
        new_content = f'---\n{new_front_matter}---\n{body}'

    with open(file_path, 'w') as f:
        f.write(new_content)
    print(f"Processed front matter in {file_path}")

if __name__ == '__main__':
    for root, dirs, files in os.walk('content'):
        for file in files:
            if file.endswith('.md'):
                fix_front_matter(os.path.join(root, file))
