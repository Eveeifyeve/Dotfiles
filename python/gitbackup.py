import os
import subprocess

def is_git_repo(path):
    return os.path.exists(os.path.join(path, '.git'))

def backup_and_push(path):
    if is_git_repo(path):
        print(f"Backing up {path}...")
        subprocess.run(['git', '-C', path, 'add', '.'])
        subprocess.run(['git', '-C', path, 'commit', '-m', '"feat: git backup"'])
        subprocess.run(['git', '-C', path, 'push'])
    else:
        print(f"{path} is not a Git repository.")

current_dir = os.getcwd()
for root, dirs, _ in os.walk(current_dir):
    for d in dirs:
        backup_and_push(os.path.join(root, d))