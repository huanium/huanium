import datetime
import importlib.resources as pkg_resources
import json
import shutil
import sys 
import os 
import warnings
import time
import pickle
import math


path_to_file = os.path.dirname(os.path.abspath(__file__))
path_to_satyendra = path_to_file + "/../../"

sys.path.insert(0, path_to_satyendra)


from satyendra.code.image_watchdog import ImageWatchdog




def main():
    camera_saving_folder_pathname, saving_location_root_pathname, arg_dir, pickle_dump_location = load_config()
    savefolder_pathname = None 

    while not savefolder_pathname:
        #user_entered_name = prompt_for_savefolder_input() 
        # --- talk to MATLAB ---
        with open(arg_dir) as arguments:
            lines = arguments.readlines()
            user_entered_name = lines[0]
            user_entered_name = user_entered_name[0:-1]
        arguments.close()
        # --- talk to MATLAB ---
        savefolder_pathname = initialize_savefolder(saving_location_root_pathname, user_entered_name)

    shutil.rmtree(savefolder_pathname)


def initialize_savefolder(saving_location_root_pathname, user_save_label):
    current_datetime = datetime.datetime.now() 
    current_year = current_datetime.strftime("%Y")
    current_year_month = current_datetime.strftime("%Y-%m")
    current_year_month_day = current_datetime.strftime("%Y-%m-%d")
    savefolder_pathname = os.path.join(saving_location_root_pathname, current_year, current_year_month, current_year_month_day, user_save_label)
    return savefolder_pathname 


def load_config():
    import satyendra.configs as c
    with pkg_resources.path(c, "image_saver_config_local.json") as json_config_path:
        with open(json_config_path) as json_config_file:
            config_dict = json.load(json_config_file)
            camera_saving_folder_pathname = config_dict["camera_saving_folder_pathname"]
            saving_location_root_pathname = config_dict["saving_location_root_pathname"]
            arg_dir = config_dict["arg_dir"]
            pickle_dump_location = config_dict["pickle_dump_location"]

    return (camera_saving_folder_pathname, saving_location_root_pathname, arg_dir, pickle_dump_location)



if __name__ == "__main__":
    main() 