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
    # load config file
    camera_saving_folder_pathname, saving_location_root_pathname, arg_dir, pickle_dump_location = load_config()

    # open my_watchdog object stored in file_my_watchdog.obj
    file = open(pickle_dump_location,'rb')
    my_watchdog = pickle.load(file)
    file.close()

    image_saved = my_watchdog.label_images_with_run_ids()
    
    if (image_saved):
        print("Saved something at: ") 
        print(datetime.datetime.now().strftime("%H-%M-%S"))


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