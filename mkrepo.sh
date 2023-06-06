#!/bin/bash

# Initialize variables
repository_name=""
access_token_file=""
private_flag="false"

# Parse command line arguments
while getopts "p" opt; do
	case $opt in
		p)
			private_flag="true"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
	esac
done

# Shift the command line arguments to access the repository name and access token file
shift $((OPTIND - 1))
if [ $# -lt 3 ]; then
	echo "Please provide the repository name, access token file, and username as arguments."
	exit 1
fi
repository_name=$1
access_token_file=$2
username=$3

# Determine the repository visibility
repository_visibility="public"
if [ "$private_flag" = "true" ]; then
	repository_visibility="private"
fi

# Create the remote repository using GitHub CLI
gh auth login --with-token < "$access_token_file"
gh repo create "$repository_name" --$repository_visibility -c
gh auth logout

# Clone the repository locally
cd "$repository_name"

# Create the README.md file
echo "# $repository_name" > README.md
echo "" >> README.md
echo "## Description" >> README.md
echo "" >> README.md
echo "Add a description here." >> README.md
echo "" >> README.md
echo "## Getting Started" >> README.md
echo "" >> README.md
echo "Follow these instructions to get started." >> README.md
echo "" >> README.md
echo "## Usage" >> README.md
echo "" >> README.md
echo "Add usage information here." >> README.md
echo "" >> README.md
echo "## Contributing" >> README.md
echo "" >> README.md
echo "Contributions are welcome! Please follow the guidelines." >> README.md
echo "" >> README.md
echo "## License" >> README.md
echo "" >> README.md
echo "This project is licensed under the [License Name] - see the [LICENSE.md](LICENSE.md) file for details." >> README.md

# Create the .gitignore file
echo "# .gitignore" > .gitignore
echo "" >> .gitignore
echo "# Ignore compiled files or local configuration specific to your development environment" >> .gitignore
echo ".venv/" >> .gitignore
echo "*.pyc" >> .gitignore

echo "Repository '$repository_name' created successfully and cloned locally."
