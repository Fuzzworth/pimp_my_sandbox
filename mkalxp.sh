#!/bin/bash

# Check if the directory name is provided as an argument
if [ $# -eq 0 ]; then
	echo "Please provide a directory name as an argument."
	exit 1
fi

# Extract the directory name from the argument
directory_name=$1

# Create the directory
mkdir "$directory_name"

# Create the README.md file inside the directory
readme_file="$directory_name/README.md"
echo "# $directory_name" > "$readme_file"
echo "" >> "$readme_file"
echo "## Description" >> "$readme_file"
echo "" >> "$readme_file"
echo "Add a description here." >> "$readme_file"
echo "" >> "$readme_file"
echo "## Getting Started" >> "$readme_file"
echo "" >> "$readme_file"
echo "Follow these instructions to get started." >> "$readme_file"
echo "" >> "$readme_file"
echo "## Usage" >> "$readme_file"
echo "" >> "$readme_file"
echo "Add usage information here." >> "$readme_file"
echo "" >> "$readme_file"
echo "## Contributing" >> "$readme_file"
echo "" >> "$readme_file"
echo "Contributions are welcome! Please follow the guidelines." >> "$readme_file"
echo "" >> "$readme_file"
echo "## License" >> "$readme_file"
echo "" >> "$readme_file"
echo "This project is licensed under the [License Name] - see the [LICENSE.md](LICENSE.md) file for details." >> "$readme_file"

# Create the .gitignore file
echo "# .gitignore" > .gitignore
echo "" >> .gitignore
echo "# Ignore compiled files or local configuration specific to your development environment" >> .gitignore
echo ".venv/" >> .gitignore
echo "*.pyc" >> .gitignore

echo "Directory '$directory_name', .gitignore and README.md file have been created successfully."
