import subprocess
import os

def run_scripts(scripts):
    for script in scripts:
        print(f"Running script: {script}")
        try:
            subprocess.run(["python", script], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error running script {script}: {e}")
            continue
        print(f"Script {script} ended")

# Example usage:
scripts = [os.path.join('scripts', f) for f in os.listdir('scripts')]

run_scripts(scripts)



