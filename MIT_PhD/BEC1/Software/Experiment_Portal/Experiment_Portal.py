import tkinter as tk
from tkinter import *
from tkinter import ttk
from turtle import color
import re
import image_saver_script as saver
import datetime
import importlib.resources as pkg_resources
import json
import shutil
import sys 
import os 
import warnings
from threading import Thread


path_to_file = os.path.dirname(os.path.abspath(__file__))
path_to_satyendra = path_to_file + "/../../"

sys.path.insert(0, path_to_satyendra)

from satyendra.code.image_watchdog import ImageWatchdog

IMAGE_EXTENSION = ".fits"

SPECIAL_CHARACTERS = "!@#$%^&*()-+?_=,<>/"

class BEC1_Portal():
    def __init__(self, master):
        self.othello_frame = Frame(master)
        self.othello_frame.pack() 

        tabControl = ttk.Notebook(master)
        tab1 = ttk.Frame(tabControl)
        tab2 = ttk.Frame(tabControl)
        tab3 = ttk.Frame(tabControl)
  
        tabControl.add(tab1, text ='Image Saver Control')
        tabControl.add(tab2, text ='Imaging Resonance Processing')
        tabControl.add(tab3, text ='RF Spectroscopy')
        tabControl.pack(expand = 1, fill ="both")
  
        # first tab: for image_saver_script.py
        self.run_bttn = Button(tab1, text="RUN", relief="raised",  width=20, command= self.run_button)
        self.run_bttn.grid(column = 0, row = 0, padx=10, pady = 30)
        self.run_bttn["state"] = DISABLED

        self.dryrun_bttn = Button(tab1, text="Dry run", relief="raised", command= self.dryrun_toggle)
        self.dryrun_bttn.grid(column = 1, row = 0, padx=10, pady = 30)

        self.custom_bttn = Button(tab1, text="Custom ", relief="raised", command= self.custom_toggle)
        self.custom_bttn.grid(column = 2, row = 0, padx=10, pady = 30)

        self.is_dryrun = True
        self.dryrun_state_before = True
        self.custom_state_before = False
        self.folder_name_entry_state_before = False

        self.folder_name_entry = Entry(tab1)
        self.folder_name_entry.grid(column = 3, row = 0, padx=10, pady = 30)
        self.folder_name_entry["state"] = DISABLED
        self.folder_name = 'dryrun'
        self.acquisition_state = "STOPPED"

        self.image_saver_status = Entry(tab1, text="Status: ", width=25)
        self.image_saver_status.grid(column = 0, row = 1, padx=10, pady = 30)

        # second tab 
        ttk.Label(tab2, text ="BLAH").grid(column = 0, row = 0, padx = 30, pady = 30)

        # third tab
        ttk.Label(tab3, text ="BLAH").grid(column = 0, row = 0, padx = 30, pady = 30)

    
    def dryrun_toggle(self):
        if self.dryrun_bttn.config('relief')[-1] == 'sunken':
            self.dryrun_bttn.config(relief="raised")
            self.dryrun_bttn.config(fg='black')
            self.custom_bttn["state"] = NORMAL
            self.folder_name_entry["state"] = NORMAL
            self.run_bttn["state"] = DISABLED
        else:
            self.dryrun_bttn.config(relief="sunken")  
            self.dryrun_bttn.config(fg='red')
            self.custom_bttn["state"] = DISABLED
            self.folder_name_entry["state"] = DISABLED
            self.run_bttn["state"] = NORMAL
            self.is_dryrun = True

    def custom_toggle(self):
        if self.custom_bttn.config('relief')[-1] == 'sunken':
            self.custom_bttn.config(relief="raised")
            self.custom_bttn.config(fg='black')
            self.dryrun_bttn["state"] = NORMAL
            self.run_bttn["state"] = DISABLED
        else:
            self.custom_bttn.config(relief="sunken")   
            self.custom_bttn.config(fg='red')
            self.dryrun_bttn["state"] = DISABLED
            self.run_bttn["state"] = NORMAL
            self.is_dryrun = False
            self.folder_name_entry["state"] = NORMAL


    def run_button(self):
            if self.run_bttn.config('relief')[-1] == 'sunken': # if RUNNING: this initiates STOP
                self.run_bttn.config(text='RUN')
                self.run_bttn.config(relief="raised")
                self.run_bttn.config(fg='black')

                if self.is_dryrun:
                    self.dryrun_bttn["state"] = DISABLED
                    self.custom_bttn["state"] = NORMAL
                    self.folder_name_entry["state"] = NORMAL
                else:
                    self.dryrun_bttn["state"] = NORMAL
                    self.custom_bttn["state"] = DISABLED
                    self.folder_name_entry["state"] = DISABLED

                # returns button to original states
                self.dryrun_bttn["state"] = self.dryrun_state_before
                self.custom_bttn["state"] = self.custom_state_before
                self.folder_name_entry["state"] = self.folder_name_entry_state_before
                # reset status box:
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0,"Done")

                self.acquisition_state = "STOPPED"

            elif (self.dryrun_bttn["state"] == DISABLED and self.custom_bttn["state"] == NORMAL) or (self.dryrun_bttn["state"] == NORMAL and self.custom_bttn["state"] == DISABLED):

                # gathers button states before RUN:
                if self.dryrun_bttn["state"] == DISABLED:
                    # means that we're running in custom mode
                    self.dryrun_state_before = DISABLED 
                    self.custom_state_before = NORMAL 
                    self.folder_name_entry_state_before = NORMAL

                    self.folder_name = self.folder_name_entry.get()
                    # proceed if folder name is valid
                    if re.match(r'^\w+$', self.folder_name) and not(self.folder_name == ""):
                        print("Images being saved to: ")
                        print(self.folder_name)
                        print()

                        self.run_bttn.config(relief="sunken")  
                        self.run_bttn.config(text='STOP')
                        self.run_bttn.config(fg='red')
                        # once running, disable other buttons
                        self.dryrun_bttn["state"] = DISABLED
                        self.custom_bttn["state"] = DISABLED
                        self.folder_name_entry["state"] = DISABLED

                        self.image_saver_status.delete(0, 'end')
                        self.image_saver_status.insert(0,"Saving into custom folder")

                        # run acquisition: custom
                        # self.acquire()
                        self.acquisition_state = "RUNNING"
                        t = Thread (target = self.acquire)
                        t.start()

                    else:
                        print("Invalid folder name!")

                else:
                    # means that we're running in dryrun mode
                    self.dryrun_state_before = NORMAL 
                    self.custom_state_before = DISABLED 
                    self.folder_name_entry_state_before = DISABLED
                    

                    self.run_bttn.config(relief="sunken")  
                    self.run_bttn.config(text='STOP')
                    self.run_bttn.config(fg='red')
                    # once running, disable other buttons
                    self.dryrun_bttn["state"] = DISABLED
                    self.custom_bttn["state"] = DISABLED
                    self.folder_name_entry["state"] = DISABLED

                    self.image_saver_status.delete(0, 'end')
                    self.image_saver_status.insert(0,"Saving into dryrun")    
                    self.folder_name = 'dryrun'   

                    # run acquisition: dryrun
                    # self.acquire()
                    self.acquisition_state = "RUNNING"
                    t = Thread (target = self.acquire)
                    t.start()

                
    def acquire(self):
        camera_saving_folder_pathname, saving_location_root_pathname, image_specification_list = saver.load_config()
        user_entered_name = self.folder_name
        is_dryrun = user_entered_name == "dryrun"
        savefolder_pathname = saver.initialize_savefolder(saving_location_root_pathname, user_entered_name, is_dryrun)

        if is_dryrun:
            print("Running as a dry run. WARNING: All images will be deleted on termination.\n")
            print("Initializing watchdog...\n")
            #my_watchdog = ImageWatchdog(camera_saving_folder_pathname, savefolder_pathname, image_specification_list, image_extension = IMAGE_EXTENSION)
            print("Running!") 

        count = 0 
        while True:
            count += 1
            print(self.folder_name)
            # main while loop goes here
            # image_saved = my_watchdog.associate_images_with_run()
            # if(image_saved):
            #    print("Saved something at: ") 
            #    print(datetime.datetime.now().strftime("%H-%M-%S"))

            if self.acquisition_state == "STOPPED":   
                #if (is_dryrun):
                #    saver.nuke_savefolder(savefolder_pathname)
                break   #Break while loop when stop = 1


def main():
    root = Tk()
    root.title('BEC1 Image Saver Portal')
    root.geometry("700x300")
    BEC1_exp_portal = BEC1_Portal(root)
    root.mainloop()

    return 

if __name__ == "__main__":
	main()