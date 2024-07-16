import subprocess
import os
from datetime import datetime

fp = open('logs','a')

def list_files(directory):
    file_list = []
    with os.scandir(directory) as entries:
        for entry in entries:
            if entry.is_file():
                file_name = entry.name
                file_list.append(os.path.join(directory, file_name))
    return file_list

#function to run a bash script
def run_bash_script(script_path):
    try:
        #running a script
        result = subprocess.run(['/bin/bash', script_path],check=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running the script: {e}")
        print(f"Standard output: {e.stdout.decode()}")
        print(f"Standard error: {e.stderr.decode()}")
        fp.writelines(f"Error occurred while running the script: {e}")
        fp.writelines(f"Standard output: {e.stdout.decode()}")
        fp.writelines(f"Standard error: {e.stderr.decode()}")
    except FileNotFoundError:
        print(f"The script '{script_path}' was not found.")
        fp.writelines(f"The script '{script_path}' was not found.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        fp.writelines(f"An unexpected error occurred: {e}")
    return False


def install_general_apps():
    print("[+] installing general apps")
    fp.writelines("[+] installing general apps")
    #getting list of scripts
    file_list  = list_files('scripts')
    #running scripts one by one 
    for script_path in file_list:
        print(f"[+] installing {script_path[8:-3]}")
        fp.writelines(f"[+] installing {script_path[8:-3]}")
        #check if script run was succesfull
        if run_bash_script(script_path):
            print(f"[+] {script_path[8:-3]} installed succesfully")
            fp.writelines(f"[+] {script_path[8:-3]} installed succesfully")
    
    print("\n[+] general apps installation complete")
    fp.writelines("\n[+] general apps installation complete")


def create_backup():
    print("\n[+] creating backup")
    script_list = list_files('scripts/backup/')
    for script_path in script_list:
        print(f"[+] running {script_path}")
        fp.writelines(f"[+] running {script_path}")
        if run_bash_script(script_path):
            print(f"[+] script {script_path} ran successfully")
            fp.writelines(f"[+] script {script_path} ran successfully")

def restore_saved_data():
    
        

# if __name__ == '__main__':
#     fp.writelines(datetime.now())
#     while True:
#         print("[#] press 1 to install general apps")
#         print("[#] press 2 to create backup")
#         print("[#] press 3 to restore saved data")
#         print("[#] press 4 to exit")
#         i = int(input())
#         if i == 1:
#             install_general_apps()
#         elif i == 2:
#             create_backup()
#         elif i == 3:
#             restore_saved_data()
#         elif i == 4:
#             print("[+] bye")
#             fp.close()
#             exit()
#         else:    
#             print("[-] please enter correct input")
#         print('\n\n\n')
        