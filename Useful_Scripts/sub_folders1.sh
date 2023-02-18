#!/bin/bash
rm -rf ../new_directory

# Create new directory
mkdir ../new_directory

# Loop through each subdirectory in the current directory
for dir in */; do
  # Get the name of the subdirectory
dir=${dir%*/}

  # Create a new subdirectory in the new directory
  mkdir ../new_directory/"$dir"
  # Copy the file with name starting with "ch4" to the new subdirectory
  cp "$dir"/ch4* ../new_directory/"$dir"/input.inp
done
