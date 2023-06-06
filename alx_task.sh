#!/bin/bash

# Function to perform git add and git commit
perform_git_operations() {
	local file_name=$1
	local commit_msg=$2

	# Add file to git
	git add "$file_name"

	# Commit changes with the provided commit message
	if [ -n "$commit_msg" ]; then
		git commit -m "$commit_msg"
	else
		git commit
	fi
}

# Function to perform git add and git commit for all files
perform_git_operations_all_files() {
	local commit_msg=$1

	# Add all files to git
	git add .

	# Commit changes with the provided commit message
	if [ -n "$commit_msg" ]; then
		git commit -m "$commit_msg"
	else
		git commit
	fi
}

# Check if a file name is provided as a parameter
if [ $# -eq 0 ]; then
	echo "Please provide a file name as a parameter."
	exit 1
fi

# Assign the file name to a variable
file_name=$1

# Open the file in Vim
vim "$file_name"

# Check if the file exists
if [ -f "$file_name" ]; then
	# Prompt the user to perform syntax checks
	read -p "Perform syntax check on $file_name using betty/pycodestyle? (b/p/n): " perform_check

	if [ "$perform_check" = "b" ]; then
		if [[ "$file_name" == *.c ]] || [[ "$file_name" == *.h ]]; then
			# Perform betty syntax check on .c and .h files
			betty "$file_name"
		else
			echo "Betty checks can only be performed on .c and .h files."
		fi
	elif [ "$perform_check" = "p" ]; then
		if [[ "$file_name" == *.py ]]; then
			# Perform pycodestyle syntax check on .py files
			pycodestyle "$file_name"
		else
			echo "Pycodestyle checks can only be performed on .py files."
		fi
	fi
fi

# Prompt the user to perform additional checks
read -p "Perform syntax check on all .c and .h files (betty) or .py files (pycodestyle)? (b/p/n): " perform_additional_check

if [ "$perform_additional_check" = "b" ]; then
	find . -type f \( -name "*.c" -o -name "*.h" \) -exec betty {} +
elif [ "$perform_additional_check" = "p" ]; then
	find . -type f -name "*.py" -exec pycodestyle {} +
fi

# Process command line options
shift

while getopts ":m:ca" opt; do
	case $opt in
		m)
			commit_msg=$OPTARG
			perform_git_operations "$file_name" "$commit_msg"
			exit 0
			;;
		c)
			commit_msg=$OPTARG
			perform_git_operations_all_files "$commit_msg"
			exit 0
			;;
		\?)
			echo "Invalid option: -$OPTARG"
			exit 1
			;;
	esac
done

# Remove the processed options from the command line arguments
shift $((OPTIND - 1))
