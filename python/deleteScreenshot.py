import os

# Set the target directory
target_directory = os.path.expanduser('~/documents/screenshots')

# Loop through all files in the target directory
for filename in os.listdir(target_directory):
    # Check if the file ends with the extensions we want to delete
    if filename.endswith('.png') or filename.endswith('.jpg') or filename.endswith('.jpeg'):
        # Construct full file path
        file_path = os.path.join(target_directory, filename)
        # Remove the file
        try:
            os.remove(file_path)
            print(f"Removed {filename}")
        except OSError as e:
            print(f"Error: {e.strerror}")