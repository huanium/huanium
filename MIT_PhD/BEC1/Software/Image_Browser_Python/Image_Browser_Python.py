import tkinter as tk
from tkinter import *
from tkinter import ttk
from turtle import color
import re
from tkinter import filedialog
import datetime
import importlib.resources as pkg_resources
import json
import shutil
import sys 
import os 
import warnings
import glob
from xml.etree.ElementTree import tostring

import matplotlib
matplotlib.use("TkAgg")

from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure
from astropy.io import fits
import numpy as np


path_to_file = os.path.dirname(os.path.abspath(__file__))
path_to_satyendra = path_to_file + "/../../"

sys.path.insert(0, path_to_satyendra)


IMAGE_EXTENSION = ".fits"
ABSORPTION_LIMIT = 2.0
SPECIAL_CHARACTERS = "!@#$%^&*()-+?_=,<>/"


class BEC1_Portal():
    def __init__(self, master):
        self.master = master
        self.image_browser_frame = Frame(master)
        self.image_browser_frame.pack() 

        tabControl = ttk.Notebook(master)
        self.tab1 = ttk.Frame(tabControl)
        self.tab2 = ttk.Frame(tabControl)
        self.tab3 = ttk.Frame(tabControl)
  
        tabControl.add(self.tab1, text ='Image Browser')
        tabControl.add(self.tab2, text ='Metadata')
        tabControl.add(self.tab3, text ='BLEH')
        tabControl.pack(expand = 1, fill ="both")
  
        # FIRST TAB

        # browse button
        self.browse_bttn = Button(self.tab1, text="Browse", relief="raised",  width=8, command= self.browse)
        self.browse_bttn.place(x=20,y=20)

        # refresh button
        self.refresh_bttn = Button(self.tab1, text="Refresh", relief="raised",  width=8, command= self.refresh)
        self.refresh_bttn.place(x=100,y=20)

        # scan button
        self.scan_bttn = Button(self.tab1, text="Scan", relief="raised",  width=5, command= self.scan)
        self.scan_bttn.place(x=180,y=20)

        # show new button
        self.show_new_bttn = Button(self.tab1, text="Show new", relief="raised",  width=8, command= self.show_new)
        self.show_new_bttn.place(x=240,y=20)

        # delete button
        self.delete_bttn = Button(self.tab1, text="Del", relief="raised",  width=4, command= self.delete)
        self.delete_bttn.place(x=320,y=20)

        # selected image:
        self.selected_image_label = Label(self.tab1, text="Selected image: ").place(x=20, y = 335)
        self.selected_image_entry = Entry(self.tab1, text="", width=56)
        self.selected_image_entry.place(x = 20, y = 360)

        # Frame type:
        self.frame_type_label = Label(self.tab1, text="Frame type: ").place(x=20, y = 390)
        self.frame_type = 'OD' # OD is the default

        self.OD_bttn = Button(self.tab1, text="OD", relief="raised",  width=7, command= self.OD_select)
        self.OD_bttn.place(x=20,y=420)

        self.with_atoms_bttn = Button(self.tab1, text="WA", relief="raised",  width=7, command= self.with_atoms_select)
        self.with_atoms_bttn.place(x=90,y=420)

        self.without_atoms_bttn = Button(self.tab1, text="WOA", relief="raised",  width=7, command= self.without_atoms_select)
        self.without_atoms_bttn.place(x=160,y=420)

        self.dark_bttn = Button(self.tab1, text="Dark", relief="raised",  width=7, command= self.dark_select)
        self.dark_bttn.place(x=230,y=420)

        self.FakeOD_bttn = Button(self.tab1, text="FakeOD", relief="raised",  width=7, command= self.FakeOD_select)
        self.FakeOD_bttn.place(x=300,y=420)

        # light 
        self.min_label = Label(self.tab1, text="Min: ").place(x=20, y = 460)
        self.min_entry = Entry(self.tab1, text="0", width=5)
        self.min_entry.place(x=60, y = 460)
        self.min_entry.delete(0,'end')
        self.min_entry.insert(0, "0")
        self.min_scale = float(self.min_entry.get())

        self.max_label = Label(self.tab1, text="Max: ").place(x=110, y = 460)
        self.max_entry = Entry(self.tab1, text="1.3", width=5)
        self.max_entry.place(x=150, y=460)
        self.max_entry.delete(0,'end')
        self.max_entry.insert(0, "1.3")
        self.max_scale = float(self.max_entry.get())

        # brightness:
        self.brightness_label = Label(self.tab1, text="Brightness: ").place(x=200, y = 460)
        self.brightness_entry = Entry(self.tab1, text="14", width=5)
        self.brightness_entry.place(x=275, y=460)  
        self.brightness_entry.delete(0,'end')   
        self.brightness_entry.insert(0, "14") 
        self.brightness = int(self.brightness_entry.get())  

        # light OK button
        self.light_OK_bttn = Button(self.tab1, text="OK", relief="raised",  width=4, command= self.light_OK)
        self.light_OK_bttn.place(x=320,y=457)

        # folder path
        self.folder_entry = Entry(self.tab1, text="folder name", width=56)
        self.folder_entry.place(x = 20, y = 60)

        # current folder name:
        self.folder_path = ''
        # list of fullpaths:
        self.files_fullpath = []
        # current file name:
        self.current_file_name = ''
        self.current_file_fullpath = ''
        self.file_names = []

        # code the table with file names:
        # 1/ to make table with scrollbar, need frame:
        table_frame = ttk.Frame(self.tab1, width=200)
        table_frame.place(x = 20, y = 95)
        # 2/ vertical scrollbar
        self.table_scrollbar = ttk.Scrollbar(table_frame)
        self.table_scrollbar.pack(side=RIGHT, fill=Y)
        # 3/ code for the file table:
        self.file_table = ttk.Treeview(table_frame, columns=("file_names"), yscrollcommand=self.table_scrollbar.set)
        self.file_table.pack()
        self.file_table.heading('#0', text='No.')
        self.file_table.heading('file_names', text='FITS images')
        self.file_table.column("#0", width=40)
        self.file_table.column("file_names", width = 285)
        # 4/ bind to get cell selection
        self.file_table.bind('<ButtonRelease-1>', self.selectItem)
        # 5/ configure scrollbar:
        self.table_scrollbar.config(command=self.file_table.yview)
        # 6/ configure table:
        style = ttk.Style()
        style.configure("Treeview", background='white',foreground="black",fieldbackground="black")
        style.map('Treeview', background=[('selected','#7ABBFF')])

        # code for the figure
        self.fig = Figure(figsize=(9.5,9.5))
        self.canvas = FigureCanvasTkAgg(self.fig, master=self.tab1)
        self.canvas.get_tk_widget().place(x = 400, y = 5)

        # code for params table:
        self.params_table = ttk.Treeview(self.tab1, columns=("param_names"))
        self.params_table.place(x=20, y = 500)
        self.params_table.heading('#0', text='Params')
        self.params_table.heading('param_names', text='Value')
        self.params_table.column("#0", width=150)
        self.params_table.column("param_names", width = 175)

        # metadata variables:
        self.metadata_variables = ["id", "TOF", "ImagFreq0", "ImagFreq1", "ImagFreq2", "SideGreenEvap", "RF12_Time",
        "LFImgFreq","ShakingCycles","BoxShakeFreq", "BoxShakeAmp", "Evap2 End"]
        self.metadata_values = [None]*len(self.metadata_variables)
        self.params_for_selected_file = dict()

        # add params to table:
        self.param_label = Label(self.tab1, text="Add parameter: ")
        self.param_label.place(x=20, y=738)
        self.param_entry = Entry(self.tab1, text="new param", width=28)
        self.param_entry.place(x=120, y=740)  
        self.param_entry.delete(0,'end')   
        self.param_entry.insert(0, "") 
        self.param = int(self.brightness_entry.get()) 

        # add param button:
        self.param_add_bttn = Button(self.tab1, text="Add", relief="raised",  width=4, command= self.add_param)
        self.param_add_bttn.place(x=308,y=736)

        # Na BEC quick atom counting:
        self.Na_BEC_atom_count_label = Label(self.tab1, text="Na BEC atom counting: ", font=('TkDefaultFont', 10, 'bold'))
        self.Na_BEC_atom_count_label.place(x=1360, y = 10)

        self.BEC_diameter_label = Label(self.tab1, text="BEC diameter (px): ")
        self.BEC_diameter_label.place(x=1360, y = 40)
        self.BEC_diameter_entry = Entry(self.tab1, text="BEC diam", width=4)
        self.BEC_diameter_entry.place(x=1480, y=40)  
        self.BEC_diameter_entry.delete(0,'end')   
        self.BEC_diameter_entry.insert(0, "70")
        self.BEC_diameter = float(self.BEC_diameter_entry.get())

        self.BEC_TOF_label = Label(self.tab1, text="TOF (ms): ")
        self.BEC_TOF_label.place(x=1550, y = 40)
        self.BEC_TOF_entry = Entry(self.tab1, text="TOF", width=4)
        self.BEC_TOF_entry.place(x=1620, y=40) 
        self.BEC_TOF_entry.delete(0,'end')   
        self.BEC_TOF_entry.insert(0, "18")
        self.BEC_TOF = float(self.BEC_TOF_entry.get())

        self.ax_trap_freq_label = Label(self.tab1, text="Ax. trap freq (Hz): ")
        self.ax_trap_freq_label.place(x=1360, y = 70)
        self.ax_trap_freq_entry = Entry(self.tab1, text="ax trap", width=4)
        self.ax_trap_freq_entry.place(x=1465, y = 70)
        self.ax_trap_freq_entry.delete(0,'end')   
        self.ax_trap_freq_entry.insert(0, "12")
        self.ax_trap_freq = float(self.ax_trap_freq_entry.get())

        self.rad_trap_freq_label = Label(self.tab1, text="Rad. trap freq (Hz): ")
        self.rad_trap_freq_label.place(x=1500, y = 70)
        self.rad_trap_freq_entry = Entry(self.tab1, text='rad trap', width=4)
        self.rad_trap_freq_entry.place(x=1610, y = 70)
        self.rad_trap_freq_entry.delete(0,'end')   
        self.rad_trap_freq_entry.insert(0, "95")
        self.rad_trap_freq = float(self.rad_trap_freq_entry.get())

        self.um_per_px_label = Label(self.tab1, text="um per pix: ")
        self.um_per_px_label.place(x=1650, y = 70)
        self.um_per_px_entry = Entry(self.tab1, text='um per pix', width=4)
        self.um_per_px_entry.place(x=1725, y = 70)
        self.um_per_px_entry.delete(0,'end')   
        self.um_per_px_entry.insert(0, "5")
        self.um_per_px = float(self.um_per_px_entry.get())

        self.BEC_count_label = Label(self.tab1, text="BEC count: ")
        self.BEC_count_label.place(x=1360, y = 100)
        self.BEC_count_entry = Entry(self.tab1, text='BEC count', width=14)
        self.BEC_count_entry.place(x=1430, y = 100)
        self.BEC_count_entry.delete(0,'end')   
        self.BEC_count_entry.insert(0, "0")
        self.BEC_count = float(self.BEC_count_entry.get())

        self.BEC_DoIt_bttn = Button(self.tab1, text="Do it", relief="raised",  width=4, command= self.BEC_DoIt)
        self.BEC_DoIt_bttn.place(x=1550,y=97)

        self.line1 = Label(self.tab1, text='---------------------------------------------------------------------------------')
        self.line1.place(x=1360, y = 125)

        # Na Catch 
        self.Na_Catch_pixel_count_label = Label(self.tab1, text="Na Catch pixel counting: ", font=('TkDefaultFont', 10, 'bold'))
        self.Na_Catch_pixel_count_label.place(x=1360, y = 150)

        self.Na_Catch_background_label = Label(self.tab1, text="Background ROI ")
        self.Na_Catch_background_label.place(x=1360, y = 180)

        self.Na_Catch_background_X_range_label = Label(self.tab1, text="X range: ")
        self.Na_Catch_background_X_range_label.place(x=1480, y = 180)
        self.Na_Catch_background_X_min_entry = Entry(self.tab1, text="Na Catch X Min", width=5)
        self.Na_Catch_background_X_min_entry.place(x=1535, y=180)  
        self.Na_Catch_background_X_min_entry.delete(0,'end')   
        self.Na_Catch_background_X_min_entry.insert(0, "1")
        self.Na_Catch_background_X_min = float(self.Na_Catch_background_X_min_entry.get())
        self.Na_Catch_background_X_max_entry = Entry(self.tab1, text="Na Catch X max", width=5)
        self.Na_Catch_background_X_max_entry.place(x=1580, y=180)  
        self.Na_Catch_background_X_max_entry.delete(0,'end')   
        self.Na_Catch_background_X_max_entry.insert(0, "512")
        self.Na_Catch_background_X_max = float(self.Na_Catch_background_X_max_entry.get())

        self.Na_Catch_background_Y_range_label = Label(self.tab1, text="Y range: ")
        self.Na_Catch_background_Y_range_label.place(x=1630, y = 180)
        self.Na_Catch_background_Y_min_entry = Entry(self.tab1, text="Na Catch Y Min", width=5)
        self.Na_Catch_background_Y_min_entry.place(x=1535+150, y=180)  
        self.Na_Catch_background_Y_min_entry.delete(0,'end')   
        self.Na_Catch_background_Y_min_entry.insert(0, "1")
        self.Na_Catch_background_Y_min = float(self.Na_Catch_background_Y_min_entry.get())
        self.Na_Catch_background_Y_max_entry = Entry(self.tab1, text="Na Catch Y max", width=5)
        self.Na_Catch_background_Y_max_entry.place(x=1580+150, y=180)  
        self.Na_Catch_background_Y_max_entry.delete(0,'end')   
        self.Na_Catch_background_Y_max_entry.insert(0, "512")
        self.Na_Catch_background_Y_max = float(self.Na_Catch_background_Y_max_entry.get())

        self.Na_Catch_ROI_label = Label(self.tab1, text="Catch ROI ")
        self.Na_Catch_ROI_label.place(x=1360, y = 210)

        self.Na_Catch_ROI_X_range_label = Label(self.tab1, text="X range: ")
        self.Na_Catch_ROI_X_range_label.place(x=1480, y = 210)
        self.Na_Catch_ROI_X_min_entry = Entry(self.tab1, text="Na Catch X Min", width=5)
        self.Na_Catch_ROI_X_min_entry.place(x=1535, y=210)  
        self.Na_Catch_ROI_X_min_entry.delete(0,'end')   
        self.Na_Catch_ROI_X_min_entry.insert(0, "1")
        self.Na_Catch_ROI_X_min = float(self.Na_Catch_ROI_X_min_entry.get())
        self.Na_Catch_ROI_X_max_entry = Entry(self.tab1, text="Na Catch X max", width=5)
        self.Na_Catch_ROI_X_max_entry.place(x=1580, y=210)  
        self.Na_Catch_ROI_X_max_entry.delete(0,'end')   
        self.Na_Catch_ROI_X_max_entry.insert(0, "512")
        self.Na_Catch_ROI_X_max = float(self.Na_Catch_ROI_X_max_entry.get())

        self.Na_Catch_ROI_Y_range_label = Label(self.tab1, text="Y range: ")
        self.Na_Catch_ROI_Y_range_label.place(x=1630, y = 210)
        self.Na_Catch_ROI_Y_min_entry = Entry(self.tab1, text="Na Catch Y Min", width=5)
        self.Na_Catch_ROI_Y_min_entry.place(x=1535+150, y=210)  
        self.Na_Catch_ROI_Y_min_entry.delete(0,'end')   
        self.Na_Catch_ROI_Y_min_entry.insert(0, "1")
        self.Na_Catch_ROI_Y_min = float(self.Na_Catch_background_Y_min_entry.get())
        self.Na_Catch_ROI_Y_max_entry = Entry(self.tab1, text="Na Catch Y max", width=5)
        self.Na_Catch_ROI_Y_max_entry.place(x=1580+150, y=210)  
        self.Na_Catch_ROI_Y_max_entry.delete(0,'end')   
        self.Na_Catch_ROI_Y_max_entry.insert(0, "512")
        self.Na_Catch_ROI_Y_max = float(self.Na_Catch_ROI_Y_max_entry.get())

        self.Na_Catch_score_label = Label(self.tab1, text="Catch score:")
        self.Na_Catch_score_label.place(x=1360, y = 240)
        self.Na_Catch_score_entry = Entry(self.tab1, text="Na Catch score", width=14)
        self.Na_Catch_score_entry.place(x=1440, y=240)  
        self.Na_Catch_score_entry.delete(0,'end')   
        self.Na_Catch_score_entry.insert(0, "0")
        self.Na_Catch_score = float(self.Na_Catch_score_entry.get())

        self.Na_Catch_DoIt_bttn = Button(self.tab1, text="Do it", relief="raised",  width=4, command= self.Na_Catch_DoIt)
        self.Na_Catch_DoIt_bttn.place(x=1550,y=237)

        self.BackgroundROI_Crop_bttn = Button(self.tab1, text="Background ROI Crop", relief="raised", width=18, command = self.Na_Catch_BackgroundROI_Crop)
        self.BackgroundROI_Crop_bttn.place(x=1525, y=147)

        self.CatchROI_Crop_bttn = Button(self.tab1, text="Catch ROI Crop", relief="raised", width=12, command = self.Na_Catch_ROI_Crop)
        self.CatchROI_Crop_bttn.place(x=1670, y=147)

        self.line2 = Label(self.tab1, text='---------------------------------------------------------------------------------')
        self.line2.place(x=1360, y = 265)

        # SECOND TAB
        # ...


        # THIRD TAB
        # ...
       
 
    def browse(self):
        self.folder_path = filedialog.askdirectory()
        self.refresh()

    def refresh(self):
        # pretty much like browse
        if self.folder_path: # if path is not empty
            self.folder_entry.delete(0,'end')
            self.folder_entry.insert(0, self.folder_path)
            # list all files with .fits extension:
            self.file_names = []
            self.files_fullpath = glob.glob(self.folder_path + '/*.fits')
            for f in self.files_fullpath:
                name = f.split(self.folder_path)
                self.file_names.append(str(name[1]).replace('\\',"")) # make list of file names
            # first clear table:
            self.file_table.delete(*self.file_table.get_children())
            # then repopulate:
            for i in range(len(self.file_names)):
                id = str(len(self.file_names)-i)               
                # then repopulate
                self.file_table.insert("","end",text = id, values = str(self.file_names[len(self.file_names)-i-1]))

    def scan(self):
        if self.scan_bttn.config('relief')[-1] == 'sunken':
            self.scan_bttn.config(text='Scan')
            self.scan_bttn.config(relief="raised")
            self.scan_bttn.config(fg='black') 
        else:
            self.scan_bttn.config(relief="sunken")  
            self.scan_bttn.config(text='Scan')
            self.scan_bttn.config(fg='silver')

    def show_new(self):
        if self.show_new_bttn.config('relief')[-1] == 'sunken':
            self.show_new_bttn.config(text='Show new')
            self.show_new_bttn.config(relief="raised")
            self.show_new_bttn.config(fg='black') 
        else:
            self.show_new_bttn.config(relief="sunken")  
            self.show_new_bttn.config(text='Show new')
            self.show_new_bttn.config(fg='silver')

    def delete(self):
        if self.current_file_name: # if there's a currently a file being selected then do something
            #print(self.current_file_fullpath)
            os.remove(self.current_file_fullpath)
            self.refresh()

    def OD_select(self):
        self.frame_type = 'OD'
        if self.current_file_fullpath:
            self.display_image()
    def with_atoms_select(self):
        self.frame_type = 'With atoms'
        if self.current_file_fullpath:
            self.display_image()
    def without_atoms_select(self):
        self.frame_type = 'Without atoms'
        if self.current_file_fullpath:
            self.display_image()
    def dark_select(self):
        self.frame_type = 'Dark'
        if self.current_file_fullpath:
            self.display_image()
    def FakeOD_select(self):
        self.frame_type = 'FakeOD'
        if self.current_file_fullpath:
            self.display_image()
    def selectItem(self, event):
        curItem = self.file_table.focus()
        curItem = self.file_table.item(curItem)
        self.current_file_name = curItem['values'][0]
        # make fullpath of selected file
        self.current_file_fullpath = self.folder_path + '/' + self.current_file_name
        # update selected image textbox:
        self.selected_image_entry.delete(0,'end')
        self.selected_image_entry.insert(0,self.current_file_name)
        # now display image:
        self.display_image()
        # next, show metadata:
        # acquire run id
        run_id = self.current_file_name.split('_')[0] 
        # load run params from json file
        run_parameters_path = self.folder_path + "/run_params_dump.json"
        with open(run_parameters_path, 'r') as json_file:
            run_parameters_dict = json.load(json_file)   
        self.params_for_selected_file = run_parameters_dict[run_id] # all params

        for i in range(len(self.metadata_variables)):
            self.metadata_values[i] = str(self.params_for_selected_file[self.metadata_variables[i]])
        # first clear metadata table:
        self.params_table.delete(*self.params_table.get_children())
        # then repopulate it
        for i in range(len(self.metadata_variables)):
            param = str(self.metadata_variables[i])
            value = str(self.metadata_values[i])    
            # then repopulate
            self.params_table.insert("","end",text = param, values = value)

    def light_OK(self):
        self.min_scale = float(self.min_entry.get())
        self.max_scale = float(self.max_entry.get())
        self.brightness = int(self.brightness_entry.get())
        
        if self.current_file_fullpath:
            self.display_image()

    def add_param(self):
        new_param = str(self.param_entry.get())
        # check if exists in data structure for selected file and not in metadata_variables already
        if (new_param in self.params_for_selected_file) and not(new_param in self.metadata_variables):
            self.metadata_variables.append(new_param)

        # update table:
        self.metadata_values.append(str(self.params_for_selected_file[self.metadata_variables[-1]]))
        # first clear metadata table:
        self.params_table.delete(*self.params_table.get_children())
        # then repopulate it
        for i in range(len(self.metadata_variables)):
            param = str(self.metadata_variables[i])
            value = str(self.metadata_values[i])    
            # then repopulate
            self.params_table.insert("","end",text = param, values = value)

    def BEC_DoIt(self):
        # get parameters first:
        self.BEC_diameter = float(self.BEC_diameter_entry.get())
        self.BEC_TOF = float(self.BEC_TOF_entry.get())
        self.ax_trap_freq = float(self.ax_trap_freq_entry.get())
        self.rad_trap_freq = float(self.rad_trap_freq_entry.get())
        self.um_per_px = float(self.um_per_px_entry.get())
        r = self.BEC_diameter/2.0
        tof = self.BEC_TOF/1000.0 # units in seconds
        ax = self.ax_trap_freq
        rad = self.rad_trap_freq
        umpx = self.um_per_px
        hbar = 1.054e-34
        m = 23*(1.67e-27)
        omega = (2*np.pi*rad*2*np.pi*rad*2*np.pi*ax)**(1/3)
        a = 85*(0.529e-10)
        # calculate BEc atom count:
        self.BEC_count = ((m/2*(2*np.pi*rad)**2/(1 + (2*np.pi*rad*tof)**2))*(umpx*10**(-6)*r)**2)**(5/2)/(15*hbar**2*m**(1/2)*omega**3*a/2**(5/2))
        # display this on BEC count entry:
        self.BEC_count_entry.delete(0,'end')   
        self.BEC_count_entry.insert(0, str('{:.2e}'.format(self.BEC_count)))

    def Na_Catch_DoIt(self):
        return 0

    def Na_Catch_BackgroundROI_Crop(self):
        return 0

    def Na_Catch_ROI_Crop(self):
        return 0


    def display_image(self):
        fits_image = fits.open(self.current_file_fullpath)
        # fits_image.info() # display fits image info
        img = fits_image[0].data
        fits_image.close()

        # now show image:
        frame_type = self.frame_type
        if frame_type == 'OD':
            frame = np.real(-np.log((img[0,:,:]-img[2,:,:])/(img[1,:,:]-img[2,:,:])))
            # clean image: using nan_to_num
            frame = np.nan_to_num(frame)
            # fix clipping
            frame = np.clip(frame, 0, ABSORPTION_LIMIT)

            self.fig.clear()
            h = self.fig.add_subplot(111)
            h.imshow(frame, cmap='gray', vmin=0, vmax=2**15).set_clim(self.min_scale, self.max_scale)
            h.invert_yaxis()
            self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.96, top=0.96, wspace=0, hspace=0)
            self.canvas.draw_idle()
        else:
            if frame_type == 'FakeOD':
                frame = np.real((img[0,:,:]-img[2,:,:])/(img[1,:,:]-img[2,:,:]))
                # clean image: using nan_to_num
                frame = np.nan_to_num(frame)
                # fix clipping
                frame = np.clip(frame, 0, ABSORPTION_LIMIT)

                self.fig.clear()
                h = self.fig.add_subplot(111)
                h.imshow(frame, cmap='gray', vmin=0, vmax=2**15).set_clim(self.min_scale, self.max_scale)
                h.invert_yaxis()
                self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                self.canvas.draw_idle()
            else:
                if frame_type == 'With atoms':
                    frame = img[0,:,:]
                    # clean image: using nan_to_num
                    frame = np.nan_to_num(frame)
                    
                    self.fig.clear()
                    h = self.fig.add_subplot(111)
                    h.imshow(frame, cmap='gray', vmin=0, vmax=2**self.brightness)  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                    h.invert_yaxis()
                    self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                    self.canvas.draw_idle()
                elif frame_type == 'Without atoms':
                    frame = img[1,:,:]
                    # clean image: using nan_to_num
                    frame = np.nan_to_num(frame)
                    self.fig.clear()
                    h = self.fig.add_subplot(111)
                    h.imshow(frame, cmap='gray', vmin=0, vmax=2**self.brightness)  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                    h.invert_yaxis()
                    self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                    self.canvas.draw_idle()
                elif frame_type == 'Dark':
                    frame = img[2,:,:]
                    # clean image: using nan_to_num
                    frame = np.nan_to_num(frame)
                    self.fig.clear()
                    h = self.fig.add_subplot(111)
                    h.imshow(frame, cmap='gray', vmin=0, vmax=2**self.brightness)  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                    h.invert_yaxis()
                    self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                    self.canvas.draw_idle()
                else:
                    frame = np.real(-np.log((img[0,:,:]-img[2,:,:])/(img[1,:,:]-img[2,:,:])))
                    # clean image: using nan_to_num
                    frame = np.nan_to_num(frame)
                    self.fig.clear()
                    h = self.fig.add_subplot(111)
                    h.imshow(frame, cmap='gray', vmin=0, vmax=2**15).set_clim(self.min_scale, self.max_scale)
                    h.invert_yaxis()
                    self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                    self.canvas.draw_idle()

def main():
    root = Tk()
    root.title('BEC1 Image Browser')
    root.geometry("1800x1000")
    BEC1_exp_portal = BEC1_Portal(root)
    root.mainloop()

    return 

if __name__ == "__main__":
	main()