import subprocess
import os
from datetime import datetime

# Open a log file for writing logs
fp = open('logs', 'w')

# Function to list files in a directory
def list_files(directory):
    file_list = []
    with os.scandir(directory) as entries:
        for entry in entries:
            if entry.is_file():
                file_name = entry.name
                file_list.append(os.path.join(directory, file_name))
    return file_list

# Custom print function to print messages and store logs in a file
def custom_print(x):
    print(x)
    fp.write('\n' + x)

# Function to run a bash script
def run_bash_script(script_path):
    try:
        # Running a bash script
        result = subprocess.run(['/bin/bash', script_path], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return True
    except subprocess.CalledProcessError as e:
        # Handling errors if the script fails
        custom_print(f"Error occurred while running the script: {e}")
        custom_print(f"Standard output: {e.stdout.decode()}")
        custom_print(f"Standard error: {e.stderr.decode()}")
    except FileNotFoundError:
        custom_print(f"The script '{script_path}' was not found.")
    except Exception as e:
        custom_print(f"An unexpected error occurred: {e}")
    return False

# Function to install general apps using scripts in 'scripts' directory
def install_general_apps():
    custom_print("[+] installing general apps")
    # Getting list of scripts in 'scripts' directory
    file_list = list_files('scripts')
    # Running each script one by one
    for script_path in file_list:
        custom_print(f"[+] installing {script_path[8:-3]}")
        # Checking if script ran successfully
        if run_bash_script(script_path):
            custom_print(f"[+] {script_path[8:-3]} installed successfully")

    custom_print("\n[+] general apps installation complete")

# Function to create backup using scripts in 'scripts/backup' directory
def create_backup():
    custom_print("\n[+] creating backup")
    # Getting list of scripts in 'scripts/backup' directory
    script_list = list_files('scripts/backup/')
    # Running each backup script one by one
    for script_path in script_list:
        custom_print(f"[+] running {script_path}")
        if run_bash_script(script_path):
            custom_print(f"[+] script {script_path} ran successfully")

# Function to restore saved data using scripts in 'scripts/restore' directory
def restore_saved_data():
    custom_print("\n[+] restoring saved data")
    # Getting list of scripts in 'scripts/restore' directory
    script_list = list_files('scripts/restore/')
    # Running each restore script one by one
    for script_path in script_list:
        custom_print(f"[+] running {script_path}")
        if run_bash_script(script_path):
            custom_print(f"[+] script {script_path} ran successfully")

if __name__ == '__main__':
    # Checking if the script is run as root
    if os.geteuid() != 0:
        custom_print("[-] Run the program as root user.")
        exit()
    
    # Clearing the screen
    os.system("clear")
    
    # Writing current date and time to log file
    fp.write(datetime.now().strftime("%d/%m/%Y %H:%M:%S"))
    
    # Main loop for user interaction
    while True:
        # Displaying options to the user
        custom_print("[#] press 1 to install general apps")
        custom_print("[#] press 2 to create backup")
        custom_print("[#] press 3 to restore saved data")
        custom_print("[#] press 4 to exit")
        
        try:
            # Taking user input for choice
            i = int(input("Enter your choice: "))
            
            # Handling user choices
            if i == 1:
                install_general_apps()
            elif i == 2:
                create_backup()
            elif i == 3:
                restore_saved_data()
            elif i == 4:
                custom_print("[+] bye")
                fp.close()  # Closing the log file
                exit()  # Exiting the program
            else:
                custom_print("[-] Please enter a correct input (1-4).")
        except ValueError:
            custom_print("[-] Invalid input. Please enter a number.")
        
        custom_print('\n\n\n')  # Adding blank lines for better readability
