import tkinter as tk
from tkinter import *
from tkinter import ttk
from turtle import color
import re


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
        self.dryrun_state_before = False

        self.folder_name_entry = Entry(tab1)
        self.folder_name_entry.grid(column = 3, row = 0, padx=10, pady = 30)
        self.folder_name_entry["state"] = DISABLED

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
            self.run_bttn["state"] = DISABLED
        else:
            self.dryrun_bttn.config(relief="sunken")  
            self.dryrun_bttn.config(fg='red')
            self.custom_bttn["state"] = DISABLED
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
            if self.run_bttn.config('relief')[-1] == 'sunken':
                self.run_bttn.config(text='RUN')
                self.run_bttn.config(relief="raised")
                self.run_bttn.config(fg='black')

                if self.is_dryrun:
                    self.dryrun_bttn["state"] = DISABLED
                    self.custom_bttn["state"] = NORMAL
                else:
                    self.dryrun_bttn["state"] = NORMAL
                    self.custom_bttn["state"] = DISABLED

                # returns button to original states
                self.dryrun_bttn["state"] = self.dryrun_state_before
                self.custom_bttn["state"] = self.custom_state_before
                # reset status box:
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0,"Done")

            elif (self.dryrun_bttn["state"] == DISABLED and self.custom_bttn["state"] == NORMAL) or (self.dryrun_bttn["state"] == NORMAL and self.custom_bttn["state"] == DISABLED):

                # gathers button states before RUN:
                if self.dryrun_bttn["state"] == DISABLED:
                    # means that we're running in custom mode
                    self.dryrun_state_before = DISABLED 
                    self.custom_state_before = NORMAL 

                    folder_name = self.folder_name_entry.get()
                    # proceed if folder name is valid
                    if re.match(r'^\w+$', folder_name) and not(folder_name == ""):
                        print("Images being saved to: ")
                        print(folder_name)
                        print()

                        self.run_bttn.config(relief="sunken")  
                        self.run_bttn.config(text='STOP')
                        self.run_bttn.config(fg='red')
                        # once running, disable other buttons
                        self.dryrun_bttn["state"] = DISABLED
                        self.custom_bttn["state"] = DISABLED

                        self.image_saver_status.delete(0, 'end')
                        self.image_saver_status.insert(0,"Saving into custom folder")
                    else:
                        print("Invalid folder name!")

                else:
                    # means that we're running in dryrun mode
                    self.dryrun_state_before = NORMAL 
                    self.custom_state_before = DISABLED 

                    self.run_bttn.config(relief="sunken")  
                    self.run_bttn.config(text='STOP')
                    self.run_bttn.config(fg='red')
                    # once running, disable other buttons
                    self.dryrun_bttn["state"] = DISABLED
                    self.custom_bttn["state"] = DISABLED

                    self.image_saver_status.delete(0, 'end')
                    self.image_saver_status.insert(0,"Saving into dryrun")

def main():
    root = Tk()
    root.title('BEC1 Image Saver Portal')
    root.geometry("500x200")
    othello = BEC1_Portal(root)
    root.mainloop()

    return 

if __name__ == "__main__":
	main()