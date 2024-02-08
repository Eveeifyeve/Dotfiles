import subprocess
from concurrent.futures import ThreadPoolExecutor

# Function to read apps from a text file
def read_apps_from_file(filename):
    with open(filename, 'r') as file:
        apps = [line.strip() for line in file]
    return apps

# Read the list of applications from a text file
apps = read_apps_from_file('apps.txt')

# Function to install apps using Homebrew
def install_app(formula_name):
    try:
        # Update Homebrew
        subprocess.check_call(['brew', 'update'])
        
        # Attempt to install the app
        result = subprocess.run(['brew', 'install', formula_name], capture_output=True, text=True)
        
        # Check if the app is already installed
        if "already installed" in result.stdout:
            # print(f"{formula_name} is already installed.")
            return True
        else:
            # print(f"{formula_name} has been installed.")
            return True
    except subprocess.CalledProcessError as e:
        # print(f"Failed to install {formula_name}: {str(e)}")
        return False

# Function to check if an app is a cask
def is_cask(formula_name):
    try:
        # List all casks
        casks = subprocess.check_output(['brew', 'list', '--casks'], text=True).splitlines()
        return formula_name in casks
    except subprocess.CalledProcessError:
        return False

# Loop through the apps and install them
for formula_name in apps:
    if install_app(formula_name):
        # Skip casting if the app is a cask
        if not is_cask(formula_name):
            # print(f"\033[31mCasting is not supported for {formula_name}.\033[0m")
            continue