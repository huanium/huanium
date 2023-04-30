# Huan Q Bui
# BEC1@MIT
# First updated: Dec 2022
# Last updated: Jan 07, 2023 @ 00:31 am

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
from matplotlib.widgets import RectangleSelector
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg, NavigationToolbar2Tk)
from matplotlib.figure import Figure
import matplotlib.pyplot as plt
from astropy.io import fits
import numpy as np
from threading import Thread
import time
import logging
import pickle

logger = logging.getLogger(__name__)

path_to_file = os.path.dirname(os.path.abspath(__file__))
path_to_satyendra = path_to_file + "/../../"

sys.path.insert(0, path_to_satyendra)

# import image_saver_script as saver
# from satyendra.code.image_watchdog import ImageWatchdog
#from BEC1_Analysis.scripts import imaging_resonance_processing, rf_spect_processing, hybrid_top_processing

IMAGE_EXTENSION = ".fits"
ABSORPTION_LIMIT = 5.0
SPECIAL_CHARACTERS = "!@#$%^&*()-+?_=,<>/"

ALLOWED_RESONANCE_TYPES = ["12_AB", "12_BA",  "21_AB", "21_BA", 
                         "13_AB", "13_BA", "31_AB", "31_BA", 
                         "23_AB", "23_BA", "32_AB", "32_BA"]

RF_DIRECTIONS = [
    "1 to 2, Imaging 1 then 2",
    "1 to 2, Imaging 2 then 1",
    "2 to 1, Imaging 1 then 2",
    "2 to 1, Imaging 2 then 1",
    "1 to 3, Imaging 1 then 3",
    "1 to 3, Imaging 3 then 1",
    "3 to 1, Imaging 1 then 3",
    "3 to 1, Imaging 3 then 1",
    "2 to 3, Imaging 2 then 3",
    "2 to 3, Imaging 3 then 2",
    "3 to 2, Imaging 2 then 3",
    "3 to 2, Imaging 3 then 2"
]

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
        self.frame_type = 'FakeOD' # FakeOD is the default
        self.frame_type_entry = Entry(self.tab1, text="frame type entry", width=16)
        self.frame_type_entry.delete(0,'end')
        self.frame_type_entry.insert(1,self.frame_type)
        self.frame_type_entry.place(x=100, y = 390)

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
        self.folder_path_old = self.folder_path
        # list of fullpaths:
        self.files_fullpath = []
        # current file name:
        self.current_file_name = ''
        self.current_file_fullpath = ''
        self.file_names = []
        self.file_names_old = []

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
        self.fig = Figure(figsize=(9.5,10))
        self.canvas = FigureCanvasTkAgg(self.fig, master=self.tab1)
        self.canvas.get_tk_widget().place(x = 400, y = 5)
        self.ax = self.fig.add_subplot(111)
        [self.XMIN, self.XMAX] = self.ax.get_xlim()
        [self.YMIN, self.YMAX] = self.ax.get_ylim()
        self.oldSizeX = 0
        self.oldSizeY = 0
        self.toolbar = NavigationToolbar2Tk(self.canvas, self.tab1, pack_toolbar=False)
        self.toolbar.update()
        self.toolbar.place(x = 400, y = 5)
        # reset view button:
        self.reset_view_bttn = Button(self.tab1, text="Reset view", relief="raised",  width=8, command= self.reset_view_button)
        self.reset_view_bttn.place(x=760,y=12)

        # ROI poly button
        self.ROI_poly_bttn = Button(self.tab1, text="ROI Poly", relief="raised",  width=8, command= self.ROI_poly_button)
        self.ROI_poly_bttn.place(x=840,y=12)
        self.roi = None
        self.roi_xs = None
        self.roi_ys = None
        # clear ROI poly
        self.clear_ROI_poly_bttn = Button(self.tab1, text="Clear", relief="raised",  width=5, command= self.clear_ROI_poly_button)
        self.clear_ROI_poly_bttn.place(x=920,y=12)
        # load ROI poly
        self.load_ROI_poly_bttn = Button(self.tab1, text="Load ROI", relief="raised",  width=8, command= self.load_ROI_poly_button)
        self.load_ROI_poly_bttn.place(x=1000,y=12)
        self.load_ROI_poly_entry = Entry(self.tab1, text='load roi entry', width=12, bg='lightgray')
        self.load_ROI_poly_entry.place(x=1000+72,y=16)
        # save ROI poly
        self.save_ROI_poly_bttn = Button(self.tab1, text="Save ROI as", relief="raised",  width=10, command= self.save_ROI_poly_button)
        self.save_ROI_poly_bttn.place(x=1170,y=12)
        self.save_ROI_poly_entry = Entry(self.tab1, text='save roi entry', width=12, bg = 'lightgray')
        self.save_ROI_poly_entry.place(x=1170+85,y=16)
        self.save_ROI_poly_entry.delete(0,'end')
        self.save_ROI_poly_entry.insert(1,'roi_drawn')

        # self.toolbar.pack(side=tk.TOP, fill=tk.X)

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

        # image saver:
        
        self.line4 = Label(self.tab1, text='-----------------------------------------------------------------')
        self.line4.place(x=20, y = 738+25)

        # ---------------------------------

        # image saver functions
        self.image_saver_label = Label(self.tab1, text="Image Saver: ", font=('TkDefaultFont', 10, 'bold'))
        self.image_saver_label.place(x=20, y = 780)

        self.run_bttn = Button(self.tab1, text="Do it", relief="raised",  width=20, command= self.run_button)
        self.run_bttn.place(x=20,y=790+20)
        self.run_bttn["state"] = DISABLED

        self.dryrun_bttn = Button(self.tab1, text="Dry run", relief="raised", command= self.dryrun_toggle)
        self.dryrun_bttn.place(x=205, y=790+20)
        
        self.custom_bttn = Button(self.tab1, text="Custom ", relief="raised", command= self.custom_toggle)
        self.custom_bttn.place(x=215+70, y=790+20)

        self.is_dryrun = True
        self.dryrun_state_before = NORMAL
        self.custom_state_before = DISABLED
        self.folder_name_entry_state_before = DISABLED
        self.confirm_button_state_before = DISABLED

        self.folder_name_label = Label(self.tab1, text="Folder name:" )
        self.folder_name_label.place(x=20, y=830+20)
        self.folder_name_entry = Entry(self.tab1, width=38)
        self.folder_name_entry.place(x=110, y=830+20)

        self.folder_name_entry["state"] = DISABLED
        self.folder_name = 'dryrun'
        self.acquisition_state = "STOPPED"

        self.confirm_bttn = Button(self.tab1, text="Confirm", command=self.confirm_button)
        self.confirm_bttn.place(x=240,y=860+20)
        self.confirm_bttn["state"] = DISABLED

        self.add_bttn = Button(self.tab1, text="Add", command=self.add_button)
        self.add_bttn.place(x=310,y=860+20)
        self.add_bttn["state"] = DISABLED
        
        self.image_saver_status = Entry(self.tab1, text="Status: ", width=25)
        self.image_saver_status.place(x = 70, y = 863+20)
        self.status_bar = Label(self.tab1, text="Status: ").place(x=20, y = 863+20)


        # ---------------------------------

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
        self.Na_Catch_background_X_min_entry = Entry(self.tab1, text="Na Catch X Min bkg", width=5)
        self.Na_Catch_background_X_min_entry.place(x=1535, y=180)  
        self.Na_Catch_background_X_min_entry.delete(0,'end')   
        self.Na_Catch_background_X_min_entry.insert(0, "1")
        self.Na_Catch_background_X_min = float(self.Na_Catch_background_X_min_entry.get())
        self.Na_Catch_background_X_max_entry = Entry(self.tab1, text="Na Catch X max bkg", width=5)
        self.Na_Catch_background_X_max_entry.place(x=1580, y=180)  
        self.Na_Catch_background_X_max_entry.delete(0,'end')   
        self.Na_Catch_background_X_max_entry.insert(0, "512")
        self.Na_Catch_background_X_max = float(self.Na_Catch_background_X_max_entry.get())

        self.Na_Catch_background_Y_range_label = Label(self.tab1, text="Y range: ")
        self.Na_Catch_background_Y_range_label.place(x=1630, y = 180)
        self.Na_Catch_background_Y_min_entry = Entry(self.tab1, text="Na Catch Y Min bkg", width=5)
        self.Na_Catch_background_Y_min_entry.place(x=1535+150, y=180)  
        self.Na_Catch_background_Y_min_entry.delete(0,'end')   
        self.Na_Catch_background_Y_min_entry.insert(0, "1")
        self.Na_Catch_background_Y_min = float(self.Na_Catch_background_Y_min_entry.get())
        self.Na_Catch_background_Y_max_entry = Entry(self.tab1, text="Na Catch Y max bkg", width=5)
        self.Na_Catch_background_Y_max_entry.place(x=1580+150, y=180)  
        self.Na_Catch_background_Y_max_entry.delete(0,'end')   
        self.Na_Catch_background_Y_max_entry.insert(0, "512")
        self.Na_Catch_background_Y_max = float(self.Na_Catch_background_Y_max_entry.get())

        self.Na_Catch_ROI_label = Label(self.tab1, text="Catch ROI ")
        self.Na_Catch_ROI_label.place(x=1360, y = 210)

        self.Na_Catch_ROI_X_range_label = Label(self.tab1, text="X range: ")
        self.Na_Catch_ROI_X_range_label.place(x=1480, y = 210)
        self.Na_Catch_ROI_X_min_entry = Entry(self.tab1, text="Na Catch X Min roi", width=5)
        self.Na_Catch_ROI_X_min_entry.place(x=1535, y=210)  
        self.Na_Catch_ROI_X_min_entry.delete(0,'end')   
        self.Na_Catch_ROI_X_min_entry.insert(0, "1")
        self.Na_Catch_ROI_X_min = float(self.Na_Catch_ROI_X_min_entry.get())
        self.Na_Catch_ROI_X_max_entry = Entry(self.tab1, text="Na Catch X max roi", width=5)
        self.Na_Catch_ROI_X_max_entry.place(x=1580, y=210)  
        self.Na_Catch_ROI_X_max_entry.delete(0,'end')   
        self.Na_Catch_ROI_X_max_entry.insert(0, "512")
        self.Na_Catch_ROI_X_max = float(self.Na_Catch_ROI_X_max_entry.get())

        self.Na_Catch_ROI_Y_range_label = Label(self.tab1, text="Y range: ")
        self.Na_Catch_ROI_Y_range_label.place(x=1630, y = 210)
        self.Na_Catch_ROI_Y_min_entry = Entry(self.tab1, text="Na Catch Y Min roi", width=5)
        self.Na_Catch_ROI_Y_min_entry.place(x=1535+150, y=210)  
        self.Na_Catch_ROI_Y_min_entry.delete(0,'end')   
        self.Na_Catch_ROI_Y_min_entry.insert(0, "1")
        self.Na_Catch_ROI_Y_min = float(self.Na_Catch_ROI_Y_min_entry.get())
        self.Na_Catch_ROI_Y_max_entry = Entry(self.tab1, text="Na Catch Y max roi", width=5)
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

        # Li MT LF atom counting
        self.Li_LF_atom_count_label = Label(self.tab1, text="Li LF atom counting: ", font=('TkDefaultFont', 10, 'bold'))
        self.Li_LF_atom_count_label.place(x=1360, y = 290)

        self.LiLF_ROI_Crop_bttn = Button(self.tab1, text="Li LF ROI Crop", relief="raised", width=16, command = self.LiLF_Crop)
        self.LiLF_ROI_Crop_bttn.place(x=1525, y=287)

        self.LiLF_ROI_label = Label(self.tab1, text="Li LF ROI ")
        self.LiLF_ROI_label.place(x=1360, y = 320)

        self.LiLF_X_range_label = Label(self.tab1, text="X range: ")
        self.LiLF_X_range_label.place(x=1480, y = 320)
        self.LiLF_X_min_entry = Entry(self.tab1, text="Li LF X Min", width=5)
        self.LiLF_X_min_entry.place(x=1535, y=320)  
        self.LiLF_X_min_entry.delete(0,'end')   
        self.LiLF_X_min_entry.insert(0, "1")
        self.LiLF_X_min = float(self.LiLF_X_min_entry.get())
        self.LiLF_X_max_entry = Entry(self.tab1, text="Li LF X max", width=5)
        self.LiLF_X_max_entry.place(x=1580, y=320)  
        self.LiLF_X_max_entry.delete(0,'end')   
        self.LiLF_X_max_entry.insert(0, "512")
        self.LiLF_X_max = float(self.LiLF_X_max_entry.get())

        self.LiLF_Y_range_label = Label(self.tab1, text="Y range: ")
        self.LiLF_Y_range_label.place(x=1630, y = 320)
        self.LiLF_Y_min_entry = Entry(self.tab1, text="Li LF Y Min", width=5)
        self.LiLF_Y_min_entry.place(x=1535+150, y=320)  
        self.LiLF_Y_min_entry.delete(0,'end')   
        self.LiLF_Y_min_entry.insert(0, "1")
        self.LiLF_Y_min = float(self.LiLF_Y_min_entry.get())
        self.LiLF_Y_max_entry = Entry(self.tab1, text="Li LF Y max", width=5)
        self.LiLF_Y_max_entry.place(x=1580+150, y=320)  
        self.LiLF_Y_max_entry.delete(0,'end')   
        self.LiLF_Y_max_entry.insert(0, "512")
        self.LiLF_Y_max = float(self.LiLF_Y_max_entry.get())

        self.LiLF_pixel_size_label = Label(self.tab1, text="Pixel size (um^2): ")
        self.LiLF_pixel_size_label.place(x=1360, y = 350)

        self.LiLF_pixel_size_entry = Entry(self.tab1, text="LiLF pixel size (um^2)", width=6)
        self.LiLF_pixel_size_entry.place(x=1470, y = 350)
        self.LiLF_pixel_size_entry.delete(0,'end')   
        self.LiLF_pixel_size_entry.insert(0, "27.52")

        self.LiLF_cross_section_label = Label(self.tab1, text="Cross section (um^2): ")
        self.LiLF_cross_section_label.place(x=1535, y = 350)

        self.LiLF_cross_section_entry = Entry(self.tab1, text="Cross section (um^2)", width=6)
        self.LiLF_cross_section_entry.place(x=1535+150, y = 350)
        self.LiLF_cross_section_entry.delete(0,'end')   
        self.LiLF_cross_section_entry.insert(0, "0.215")

        self.LiLF_sat_count_label = Label(self.tab1, text="Saturation Counts: ")
        self.LiLF_sat_count_label.place(x=1360, y = 380)

        self.LiLF_sat_count_entry = Entry(self.tab1, text="Saturation Counts", width=9)
        self.LiLF_sat_count_entry.place(x=1470, y = 380)
        self.LiLF_sat_count_entry.delete(0,'end')   
        self.LiLF_sat_count_entry.insert(0, "1.336e5")

        self.LiLF_atom_number_label = Label(self.tab1, text="Atom number: ")
        self.LiLF_atom_number_label.place(x=1535, y = 380)

        self.LiLF_atom_number_entry = Entry(self.tab1, text="Atom number", width=10)
        self.LiLF_atom_number_entry.place(x=1535+100, y = 380)
        self.LiLF_atom_number_entry.delete(0,'end')   
        self.LiLF_atom_number_entry.insert(0, "0")

        self.LiLF_DoIt_bttn = Button(self.tab1, text="Do it", relief="raised",  width=4, command= self.LiLF_DoIt)
        self.LiLF_DoIt_bttn.place(x=1535+180, y=377)

        self.line3 = Label(self.tab1, text='---------------------------------------------------------------------------------')
        self.line3.place(x=1360, y = 405)

        # imaging resonance processing
        self.imaging_resonance_processing_label = Label(self.tab1, text="Imaging resonance processing: ", font=('TkDefaultFont', 10, 'bold'))
        self.imaging_resonance_processing_label.place(x=1360, y = 430)

        self.browse_res_bttn = Button(self.tab1, text="Browse", relief="raised",  width=8, command= self.browse_res_button)
        self.browse_res_bttn.place(x=1360,y=460)
        self.image_processing_folder_path = ''

        self.res_image_folder_entry = Entry(self.tab1, text="Resonance imaging folder name", width=53)
        self.res_image_folder_entry.place(x = 1445, y = 463)

        self.resonance_imaging_mode = 'TopAB' # set to this by default

        self.side_lf_bttn = Button(self.tab1, text="Side LF", relief="raised",  width=7, command= self.side_lf)
        self.side_lf_bttn.place(x=1360,y=495)
        self.side_lf_bttn["state"] = DISABLED

        self.side_hf_bttn = Button(self.tab1, text="Side HF", relief="raised",  width=7, command= self.side_hf)
        self.side_hf_bttn.place(x=275+1160-5,y=495)
        self.side_hf_bttn["state"] = DISABLED

        self.TopA_bttn = Button(self.tab1, text="Top A", relief="raised",  width=7, command= self.TopA)
        self.TopA_bttn.place(x=350+1160-10,y=495)
        self.TopA_bttn["state"] = DISABLED

        self.TopB_bttn = Button(self.tab1, text="Top B", relief="raised",  width=7, command= self.TopB)
        self.TopB_bttn.place(x=425+1160-15,y=495)
        self.TopB_bttn["state"] = DISABLED

        self.TopAB_bttn = Button(self.tab1, text="Top AB", relief="raised",  width=7, command= self.TopAB)
        self.TopAB_bttn.place(x=500+1160-20,y=495)
        self.TopAB_bttn["state"] = DISABLED

        self.analyze_bttn = Button(self.tab1, text="Do It", relief="raised",  width=7, command= self.analyze_button)
        self.analyze_bttn.place(x=575+1160-25,y=495)
        self.analyze_bttn["state"] = DISABLED

        self.line5 = Label(self.tab1, text='---------------------------------------------------------------------------------')
        self.line5.place(x=1360, y = 495+25)

        # rf spectroscopy
        self.rf_resonance_processing_label = Label(self.tab1, text="RF resonance processing: ", font=('TkDefaultFont', 10, 'bold'))
        self.rf_resonance_processing_label.place(x=1360, y = 540)

        self.browse_rf_bttn = Button(self.tab1, text="Browse", relief="raised",  width=8, command= self.browse_rf_button)
        self.browse_rf_bttn.place(x=1360,y=570)
        self.rf_processing_folder_path = ''

        self.rf_spect_folder_entry = Entry(self.tab1, text="RF spectroscopy folder name", width=53)
        self.rf_spect_folder_entry.place(x = 1445, y = 573)

        self.RF_direction_label = Label(self.tab1, text="RF transfer: ").place(x=1360, y=607)
        self.RF_direction = StringVar()
        self.RF_direction.set( "1 to 2, Imaging 1 then 2")
        self.RF_directions_menu = OptionMenu(self.tab1, self.RF_direction, *RF_DIRECTIONS, command = self.RF_imaging_options)
        self.RF_directions_menu.place(x = 1445, y = 600)
        self.rf_resonance_key = self.RF_direction.get()     

        self.Rabi_guess_var = StringVar()
        self.RF_center_guess_var = StringVar()
        self.Rabi_guess_label = Label(self.tab1, text= "Rabi frequency guess (kHz): ").place(x=1360, y=640)
        self.RF_center_guess_label = Label(self.tab1, text= "RF center guess (MHz): ").place(x=1360, y=670)
        self.Rabi_guess = Entry(self.tab1, textvariable = self.Rabi_guess_var, width=20).place(x=1550,y=642)
        self.RF_center_guess = Entry(self.tab1, textvariable = self.RF_center_guess_var, width=20).place(x=1550,y=672)

        self.rf_analyze_bttn = Button(self.tab1, text="Analyze", relief="raised",  width=15, command= self.rf_analyze_button)
        self.rf_analyze_bttn.place(x=1430, y=700)
        self.rf_analyze_bttn["state"] = DISABLED   

        self.rf_analyze_with_guess_bttn = Button(self.tab1, text="Analyze with guess", relief="raised",  width=15, command= self.rf_analyze_with_guess_button)
        self.rf_analyze_with_guess_bttn.place(x=1600,y=700)
        self.rf_analyze_with_guess_bttn["state"] = DISABLED

        self.line6 = Label(self.tab1, text='---------------------------------------------------------------------------------')
        self.line6.place(x=1360, y = 700+25)

        # hybrid top analysis:
        self.hybrid_top_analysis_label = Label(self.tab1, text="Hybrid Top Analysis: ", font=('TkDefaultFont', 10, 'bold'))
        self.hybrid_top_analysis_label.place(x=1360, y = 750)

        self.browse_hybrid_bttn = Button(self.tab1, text="Browse", relief="raised",  width=8, command= self.browse_hybrid_button)
        self.browse_hybrid_bttn.place(x=1360,y=750+30)
        self.hybrid_processing_folder_path = ''

        self.hybrid_folder_entry = Entry(self.tab1, text="Hybrid data folder name", width=53)
        self.hybrid_folder_entry.place(x = 1445, y = 750+30+3)

        self.hybrid_imaging_mode = 'abs' # set to this by default other option is 'polrot'

        self.abs_img_bttn = Button(self.tab1, text="Absorption", relief="raised",  width=10, command= self.abs_img)
        self.abs_img_bttn.place(x=1360,y=815)
        self.abs_img_bttn["state"] = DISABLED

        self.polrot_img_bttn = Button(self.tab1, text="Pol. rot.", relief="raised",  width=10, command= self.polrot_img)
        self.polrot_img_bttn.place(x=1470,y=815)
        self.polrot_img_bttn["state"] = DISABLED

        self.hybrid_analyze_bttn = Button(self.tab1, text="Analyze", relief="raised",  width=15, command= self.hybrid_analyze_button)
        self.hybrid_analyze_bttn.place(x=1600,y=815)
        self.hybrid_analyze_bttn["state"] = DISABLED

        # SECOND TAB
        # ...


        # THIRD TAB
        # ...
       
 
    def browse(self):
        self.folder_path = filedialog.askdirectory()
        self.refresh()

        if self.folder_path:
            if self.scan_bttn.config('relief')[-1] == 'sunken':
                t = Thread (target = self.scan_act)
                t.start()

    def refresh(self):
        if self.folder_path: # if path is not empty
            self.folder_entry.delete(0,'end')
            self.folder_entry.insert(0, self.folder_path)
            # list all files with .fits extension:
            self.file_names = []
            self.files_fullpath = glob.glob(self.folder_path + '/*.fits')
            for f in self.files_fullpath:
                name = f.split(self.folder_path)
                self.file_names.append(str(name[1]).replace('\\',"")) # make list of file names
            if self.file_names != self.file_names_old: # only act if file_names has changed
                # first clear table:
                self.file_table.delete(*self.file_table.get_children())
                # then repopulate:
                for i in range(len(self.file_names)):
                    id = str(len(self.file_names)-i)               
                    # then repopulate
                    self.file_table.insert("","end",text = id, values = str(self.file_names[len(self.file_names)-i-1]))
                self.file_names_old = self.file_names
            # udpate backup folder path
            self.folder_path_old = self.folder_path
        else:
            # if folder path is empty then revert to old folder path
            self.folder_path = self.folder_path_old

    def scan(self):
        if self.folder_path:
            if self.scan_bttn.config('relief')[-1] == 'sunken':
                self.scan_bttn.config(text='Scan')
                self.scan_bttn.config(relief="raised")
                self.scan_bttn.config(fg='black') 
                # if sunken then raise button and stop scan:
            else:
                self.scan_bttn.config(relief="sunken")  
                self.scan_bttn.config(text='Scan')
                self.scan_bttn.config(fg='silver')
                # if raised then sunken and start scan:
                t = Thread (target = self.scan_act)
                t.start()

    def scan_act(self):
            while True:
                if self.scan_bttn.config('relief')[-1] == 'sunken':
                    # if show new button is pressed then show new image:
                    if self.show_new_bttn.config('relief')[-1] == 'sunken':
                        print('Scanning and showing new...')
                        # take last element of new file list
                        # compare file name
                        # if different then display, else do nothing
                        if self.folder_path: # if path is not empty
                            self.folder_entry.delete(0,'end')
                            self.folder_entry.insert(0, self.folder_path)
                            # list all files with .fits extension:
                            self.file_names_new = []
                            self.files_fullpath_new = glob.glob(self.folder_path + '/*.fits')

                            if len(self.files_fullpath_new) > 0:
                                for f in self.files_fullpath_new:
                                    name = f.split(self.folder_path)
                                    self.file_names_new.append(str(name[1]).replace('\\',"")) # make list of file names
                                if self.file_names_new != self.file_names: # if file_names has changed:
                                    # first clear table:
                                    self.file_table.delete(*self.file_table.get_children())
                                    # then repopulate:
                                    for i in range(len(self.file_names_new)):
                                        id = str(len(self.file_names_new)-i)               
                                        # then repopulate
                                        self.file_table.insert("","end",text = id, values = str(self.file_names_new[len(self.file_names_new)-i-1]))

                                    if len(self.file_names) > 0:
                                        if self.file_names_new[-1] != self.file_names[-1]: # display last image if last image different from previous last image
                                            # show new image:
                                            self.current_file_name = self.file_names_new[-1]
                                            # make fullpath of selected file
                                            self.current_file_fullpath = self.folder_path + '/' + self.current_file_name
                                            # update selected image textbox:
                                            self.selected_image_entry.delete(0,'end')
                                            self.selected_image_entry.insert(0,self.current_file_name)
                                            # now display image:
                                            self.display_image()
                                            print(self.current_file_name)
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
                                    else: # if there is no file_names yet, then just display the last of file_names_new
                                        # show new image:
                                        self.current_file_name = self.file_names_new[-1]
                                        # make fullpath of selected file
                                        self.current_file_fullpath = self.folder_path + '/' + self.current_file_name
                                        # update selected image textbox:
                                        self.selected_image_entry.delete(0,'end')
                                        self.selected_image_entry.insert(0,self.current_file_name)
                                        # now display image:
                                        self.display_image()
                                        print(self.current_file_name)
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
                                        
                                self.file_names = self.file_names_new
                                self.files_fullpath = self.files_fullpath_new                 

                    else:
                        print('Scanning but not showing new...')
                        self.refresh()
                    time.sleep(1) # 1 second rep rate should be good since sequences are much longer
                else:
                    break 
        
    def show_new(self):
        if self.folder_path:
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

        self.frame_type_entry.delete(0,'end')
        self.frame_type_entry.insert(1,self.frame_type)
        self.frame_type_entry.place(x=100, y = 390)
        
    def with_atoms_select(self):
        self.frame_type = 'With atoms'
        if self.current_file_fullpath:
            self.display_image()
        
        self.frame_type_entry.delete(0,'end')
        self.frame_type_entry.insert(1,self.frame_type)
        self.frame_type_entry.place(x=100, y = 390)

    def without_atoms_select(self):
        self.frame_type = 'Without atoms'
        if self.current_file_fullpath:
            self.display_image()
        
        self.frame_type_entry.delete(0,'end')
        self.frame_type_entry.insert(1,self.frame_type)
        self.frame_type_entry.place(x=100, y = 390)

    def dark_select(self):
        self.frame_type = 'Dark'
        if self.current_file_fullpath:
            self.display_image()
        
        self.frame_type_entry.delete(0,'end')
        self.frame_type_entry.insert(1,self.frame_type)
        self.frame_type_entry.place(x=100, y = 390)

    def FakeOD_select(self):
        self.frame_type = 'FakeOD'
        if self.current_file_fullpath:
            self.display_image()
        
        self.frame_type_entry.delete(0,'end')
        self.frame_type_entry.insert(1,self.frame_type)
        self.frame_type_entry.place(x=100, y = 390)

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
        # calculate BEC atom count:
        self.BEC_count = ((m/2*(2*np.pi*rad)**2/(1 + (2*np.pi*rad*tof)**2))*(umpx*10**(-6)*r)**2)**(5/2)/(15*hbar**2*m**(1/2)*omega**3*a/2**(5/2))
        # display this on BEC count entry:
        self.BEC_count_entry.delete(0,'end')   
        self.BEC_count_entry.insert(0, str('{:.2e}'.format(self.BEC_count)))

    def Na_Catch_DoIt(self):
        
        # acquire lims for background
        x_min_bg = self.Na_Catch_background_X_min
        x_max_bg = self.Na_Catch_background_X_max
        y_min_bg = self.Na_Catch_background_Y_min
        y_max_bg = self.Na_Catch_background_Y_max

        # acquire lims for roi
        x_min_roi = self.Na_Catch_ROI_X_min
        x_max_roi = self.Na_Catch_ROI_X_max
        y_min_roi = self.Na_Catch_ROI_Y_min
        y_max_roi = self.Na_Catch_ROI_Y_max

        bg_area = (y_max_bg - y_min_bg)*(x_max_bg - x_min_bg)
        roi_area = (y_max_roi - y_min_roi)*(x_max_roi - x_min_roi)

        od_roi = (-np.log(safe_subtract(self.img[0,:,:], self.img[2,:,:])/safe_subtract(self.img[1,:,:], self.img[2,:,:])))
        od_roi = np.nan_to_num(od_roi)
        od_roi = np.clip(od_roi, 0, ABSORPTION_LIMIT)
        od_roi_cropped = od_roi[x_min_roi:x_max_roi, y_min_roi:y_max_roi] # just OD, but cropped

        od_bg = (-np.log(safe_subtract(self.img[0,:,:], self.img[2,:,:])/safe_subtract(self.img[1,:,:], self.img[2,:,:])))
        od_bg = np.nan_to_num(od_bg)
        od_bg = np.clip(od_bg, 0, ABSORPTION_LIMIT)
        od_bg_cropped = od_bg[x_min_roi:x_max_bg, y_min_roi:y_max_bg] # just OD, but cropped

        # integrate
        count_od = sum(sum(float(od_roi_cropped)))
        count_bg = sum(sum(float(od_bg_cropped)))

        # convert to bg corresponding to roi area:
        count_bg = int(count_bg*(roi_area/bg_area))
        # then calculate catch score
        self.Na_Catch_score = count_od - count_bg
        # display this on catch score entry:
        self.Na_Catch_score_entry.delete(0,'end')   
        self.Na_Catch_score_entry.insert(0, str('{:.2e}'.format(self.Na_Catch_score)))
        

    def Na_Catch_BackgroundROI_Crop(self):
        def line_select_callback(eclick, erelease):
            'eclick and erelease are the press and release events'
            x1, y1 = eclick.xdata, eclick.ydata
            x2, y2 = erelease.xdata, erelease.ydata

            self.Na_Catch_background_X_min = int(min(x1,x2))
            self.Na_Catch_background_X_max = int(max(x1,x2))
            self.Na_Catch_background_Y_min = int(min(y1,y2))
            self.Na_Catch_background_Y_max = int(max(y1,y2))

            self.Na_Catch_background_X_min_entry.delete(0,'end')   
            self.Na_Catch_background_X_min_entry.insert(0, str(self.Na_Catch_background_X_min))
            self.Na_Catch_background_X_max_entry.delete(0,'end')   
            self.Na_Catch_background_X_max_entry.insert(0, str(self.Na_Catch_background_X_max))
            self.Na_Catch_background_Y_min_entry.delete(0,'end')   
            self.Na_Catch_background_Y_min_entry.insert(0, str(self.Na_Catch_background_Y_min))
            self.Na_Catch_background_Y_max_entry.delete(0,'end')   
            self.Na_Catch_background_Y_max_entry.insert(0, str(self.Na_Catch_background_Y_max))

            # redraw image once done so that user has to click the crop bttn again to crop
            self.display_image()

        toggle_selector.RS = RectangleSelector(self.ax, line_select_callback,
        drawtype='box', useblit=True,
        button=[1,3], # don't use middle button
        minspanx=5, minspany=5,
        spancoords='pixels')
        plt.connect('key_press_event', toggle_selector)
        

    def Na_Catch_ROI_Crop(self):
        def line_select_callback(eclick, erelease):
            'eclick and erelease are the press and release events'
            x1, y1 = eclick.xdata, eclick.ydata
            x2, y2 = erelease.xdata, erelease.ydata

            self.Na_Catch_ROI_X_min = int(min(x1,x2))
            self.Na_Catch_ROI_X_max = int(max(x1,x2))
            self.Na_Catch_ROI_Y_min = int(min(y1,y2))
            self.Na_Catch_ROI_Y_max = int(max(y1,y2))

            self.Na_Catch_ROI_X_min_entry.delete(0,'end')   
            self.Na_Catch_ROI_X_min_entry.insert(0, str(self.Na_Catch_ROI_X_min))
            self.Na_Catch_ROI_X_max_entry.delete(0,'end')   
            self.Na_Catch_ROI_X_max_entry.insert(0, str(self.Na_Catch_ROI_X_max))
            self.Na_Catch_ROI_Y_min_entry.delete(0,'end')   
            self.Na_Catch_ROI_Y_min_entry.insert(0, str(self.Na_Catch_ROI_Y_min))
            self.Na_Catch_ROI_Y_max_entry.delete(0,'end')   
            self.Na_Catch_ROI_Y_max_entry.insert(0, str(self.Na_Catch_ROI_Y_max))

            # redraw image once done so that user has to clip the crop bttn again to crop
            self.display_image()

        toggle_selector.RS = RectangleSelector(self.ax, line_select_callback,
        drawtype='box', useblit=True,
        button=[1,3], # don't use middle button
        minspanx=5, minspany=5,
        spancoords='pixels')
        plt.connect('key_press_event', toggle_selector)

    def LiLF_Crop(self):
        def line_select_callback(eclick, erelease):
            'eclick and erelease are the press and release events'
            x1, y1 = eclick.xdata, eclick.ydata
            x2, y2 = erelease.xdata, erelease.ydata

            self.LiLF_X_min = int(min(x1,x2))
            self.LiLF_X_max = int(max(x1,x2))
            self.LiLF_Y_min = int(min(y1,y2))
            self.LiLF_Y_max = int(max(y1,y2))

            self.LiLF_X_min_entry.delete(0,'end')   
            self.LiLF_X_min_entry.insert(0, str(self.LiLF_X_min))
            self.LiLF_X_max_entry.delete(0,'end')   
            self.LiLF_X_max_entry.insert(0, str(self.LiLF_X_max))
            self.LiLF_Y_min_entry.delete(0,'end')   
            self.LiLF_Y_min_entry.insert(0, str(self.LiLF_Y_min))
            self.LiLF_Y_max_entry.delete(0,'end')   
            self.LiLF_Y_max_entry.insert(0, str(self.LiLF_Y_max))

            # redraw image once done so that user has to clip the crop bttn again to crop
            self.display_image()

        toggle_selector.RS = RectangleSelector(self.ax, line_select_callback,
        drawtype='box', useblit=True,
        button=[1,3], # don't use middle button
        minspanx=5, minspany=5,
        spancoords='pixels')
        plt.connect('key_press_event', toggle_selector)

    def LiLF_DoIt(self):
        # acquire lims:
        x_min = self.LiLF_X_min
        x_max = self.LiLF_X_max
        y_min = self.LiLF_Y_min
        y_max = self.LiLF_Y_max

        # params
        pixelsize = float(self.LiLF_pixel_size_entry.get())
        sigma = float(self.LiLF_cross_section_entry.get())
        Nsat = float(self.LiLF_sat_count_entry.get())

        od = (-np.log(safe_subtract(self.img[0,:,:], self.img[2,:,:])/safe_subtract(self.img[1,:,:], self.img[2,:,:])))
        ic =  safe_subtract(self.img[1,:,:], self.img[0,:,:])/Nsat

        # now clean od and ic:
        od = np.nan_to_num(od)
        # fix clipping
        od = np.clip(od, 0, ABSORPTION_LIMIT)

        od_cropped = od[x_min:x_max, y_min:y_max] # just OD, but cropped
        ic_cropped = ic[x_min:x_max, y_min:y_max]
        atomnumber_map = (ic_cropped+od_cropped)*pixelsize/sigma
        Li_atomnumber = sum(sum(atomnumber_map))
        self.LiLF_atom_number_entry.delete(0,'end')   
        self.LiLF_atom_number_entry.insert(0, str('{:.2e}'.format(Li_atomnumber)))

    def reset_view_button(self):
        if self.img.any():
            # get dims of image
            dims = self.img[0,:,:].shape 
            x_limit = dims[1]
            y_limit = dims[0]

            self.fig.clf()
            self.ax = self.fig.add_subplot(111)
            self.ax.imshow(self.frame, cmap='gray', vmin=0, vmax=2**15).set_clim(self.min_scale, self.max_scale)
            self.ax.invert_yaxis()
            self.ax.set_xlim([0, x_limit])
            self.ax.set_ylim([0, y_limit])
            self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.98, top=0.94, wspace=0, hspace=0)
            self.canvas.draw_idle()

    def ROI_poly_button(self):
        # first clear all rois:
        self.clear_ROI_poly_button()
        # now generate new one:
        self.roi = RoiPoly(fig = self.fig, ax = self.ax, color='r')
        # stop scan and show new:
        self.scan_bttn.config(relief="raised")
        self.scan_bttn.config(fg='black')
        self.show_new_bttn.config(relief="raised")
        self.show_new_bttn.config(fg='black')

    def clear_ROI_poly_button(self):
        self.roi  = None 
        self.display_roi()
        self.display_image()

    def load_ROI_poly_button(self):
        roi_load_filename = filedialog.askopenfilename()
        if roi_load_filename:
            file = open(roi_load_filename, 'rb')
            self.roi = pickle.load(file)
            file.close()
            self.load_ROI_poly_entry.delete(0,'end')
            self.load_ROI_poly_entry.insert(1,os.path.basename(roi_load_filename))

    def save_ROI_poly_button(self):
        if self.folder_path and self.roi:
            roi_save_file_name = self.save_ROI_poly_entry.get()
            name = self.folder_path+ "/" + roi_save_file_name
            fileObj = open(name, 'wb')
            pickle.dump(self.roi, fileObj)
            fileObj.close()

    def display_image(self):
        fits_image = fits.open(self.current_file_fullpath)
        # fits_image.info() # display fits image info
        self.img = fits_image[0].data
        fits_image.close()

        # get dims of image
        dims = self.img[0,:,:].shape 
        x_limit = dims[1]
        y_limit = dims[0]
        # get dims of current axes:
        [self.XMIN, self.XMAX] = self.ax.get_xlim()
        [self.YMIN, self.YMAX] = self.ax.get_ylim()

        # now show image:
        frame_type = self.frame_type
        if frame_type == 'OD':
            self.frame = (-np.log(safe_subtract(self.img[0,:,:], self.img[2,:,:])/safe_subtract(self.img[1,:,:], self.img[2,:,:])))
            # clean image: using nan_to_num
            self.frame = np.nan_to_num(self.frame, nan=ABSORPTION_LIMIT)
            # fix clipping
            self.frame = np.clip(self.frame, 0, ABSORPTION_LIMIT)

            self.fig.clf()
            self.ax = self.fig.add_subplot(111)
            self.ax.imshow(self.frame, cmap='gray', vmin=0, vmax=2**15).set_clim(self.min_scale, self.max_scale)
            self.ax.invert_yaxis()
            # zoom/pan perspective
            if (self.oldSizeX == x_limit) and (self.oldSizeY == y_limit):
                self.ax.set_xlim([self.XMIN, self.XMAX])
                self.ax.set_ylim([self.YMIN, self.YMAX])
            else:
                self.ax.set_xlim([0, x_limit])
                self.ax.set_ylim([0, y_limit])
            self.oldSizeX = x_limit
            self.oldSizeY = y_limit
            # end of zoom/pan perspective
            self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.98, top=0.94, wspace=0, hspace=0)
            self.canvas.draw_idle()
        else:
            if frame_type == 'FakeOD':
                self.frame = (safe_subtract(self.img[0,:,:], self.img[2,:,:])/safe_subtract(self.img[1,:,:], self.img[2,:,:]))
                # clean image: using nan_to_num
                self.frame = np.nan_to_num(self.frame)
                # fix clipping
                self.frame = np.clip(self.frame, 0, ABSORPTION_LIMIT)

                self.fig.clf()
                self.ax = self.fig.add_subplot(111)
                self.ax.imshow(self.frame, cmap='gray', vmin=0, vmax=2**15).set_clim(self.min_scale, self.max_scale)
                self.ax.invert_yaxis()
                # zoom/pan perspective
                if (self.oldSizeX == x_limit) and (self.oldSizeY == y_limit):
                    self.ax.set_xlim([self.XMIN, self.XMAX])
                    self.ax.set_ylim([self.YMIN, self.YMAX])
                else:
                    self.ax.set_xlim([0, x_limit])
                    self.ax.set_ylim([0, y_limit])
                self.oldSizeX = x_limit
                self.oldSizeY = y_limit
                # end of zoom/pan perspective
                self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.98, top=0.94, wspace=0, hspace=0)
                self.canvas.draw_idle()
            else:
                if frame_type == 'With atoms':
                    self.frame = self.img[0,:,:]
                    # clean image: using nan_to_num
                    self.frame = np.nan_to_num(self.frame)
                    
                    self.fig.clf()
                    self.ax = self.fig.add_subplot(111)
                    self.ax.imshow(self.frame, cmap='gray', vmin=0, vmax=2**self.brightness)  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                    self.ax.invert_yaxis()
                    # zoom/pan perspective
                    if (self.oldSizeX == x_limit) and (self.oldSizeY == y_limit):
                        self.ax.set_xlim([self.XMIN, self.XMAX])
                        self.ax.set_ylim([self.YMIN, self.YMAX])
                    else:
                        self.ax.set_xlim([0, x_limit])
                        self.ax.set_ylim([0, y_limit])
                    self.oldSizeX = x_limit
                    self.oldSizeY = y_limit
                    # end of zoom/pan perspective
                    self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.98, top=0.94, wspace=0, hspace=0)
                    self.canvas.draw_idle()
                elif frame_type == 'Without atoms':
                    self.frame = self.img[1,:,:]
                    # clean image: using nan_to_num
                    self.frame = np.nan_to_num(self.frame)

                    self.fig.clf()
                    self.ax = self.fig.add_subplot(111)
                    self.ax.imshow(self.frame, cmap='gray', vmin=0, vmax=2**self.brightness)  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                    self.ax.invert_yaxis()
                    # zoom/pan perspective
                    if (self.oldSizeX == x_limit) and (self.oldSizeY == y_limit):
                        self.ax.set_xlim([self.XMIN, self.XMAX])
                        self.ax.set_ylim([self.YMIN, self.YMAX])
                    else:
                        self.ax.set_xlim([0, x_limit])
                        self.ax.set_ylim([0, y_limit])
                    self.oldSizeX = x_limit
                    self.oldSizeY = y_limit
                    # end of zoom/pan perspective
                    self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.98, top=0.94, wspace=0, hspace=0)
                    self.canvas.draw_idle()
                elif frame_type == 'Dark':
                    self.frame = self.img[2,:,:]
                    # clean image: using nan_to_num
                    self.frame = np.nan_to_num(self.frame)

                    self.fig.clf()
                    self.ax = self.fig.add_subplot(111)
                    self.ax.imshow(self.frame, cmap='gray', vmin=0, vmax=2**self.brightness)  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                    self.ax.invert_yaxis()
                    # zoom/pan perspective
                    if (self.oldSizeX == x_limit) and (self.oldSizeY == y_limit):
                        self.ax.set_xlim([self.XMIN, self.XMAX])
                        self.ax.set_ylim([self.YMIN, self.YMAX])
                    else:
                        self.ax.set_xlim([0, x_limit])
                        self.ax.set_ylim([0, y_limit])
                    self.oldSizeX = x_limit
                    self.oldSizeY = y_limit
                    # end of zoom/pan perspective
                    self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.98, top=0.94, wspace=0, hspace=0)
                    self.canvas.draw_idle()
                else:
                    self.frame = (-np.log(safe_subtract(self.img[0,:,:], self.img[2,:,:])/safe_subtract(self.img[1,:,:], self.img[2,:,:])))
                    # clean image: using nan_to_num
                    self.frame = np.nan_to_num(self.frame)

                    self.fig.clf()
                    self.ax = self.fig.add_subplot(111)
                    self.ax.imshow(self.frame, cmap='gray', vmin=0, vmax=2**15).set_clim(self.min_scale, self.max_scale)
                    self.ax.invert_yaxis()
                    # zoom/pan perspective
                    if (self.oldSizeX == x_limit) and (self.oldSizeY == y_limit):
                        self.ax.set_xlim([self.XMIN, self.XMAX])
                        self.ax.set_ylim([self.YMIN, self.YMAX])
                    else:
                        self.ax.set_xlim([0, x_limit])
                        self.ax.set_ylim([0, y_limit])
                    self.oldSizeX = x_limit
                    self.oldSizeY = y_limit
                    # end of zoom/pan perspective
                    self.fig.subplots_adjust(left=0.05, bottom=0.04, right=0.98, top=0.94, wspace=0, hspace=0)
                    self.canvas.draw_idle()
        # now display roi if there is one:
        self.display_roi()
    
    def display_roi(self):
        if self.roi:
            #coords = list(zip(self.roi.x, self.roi.y))
            #print(coords)
            self.roi_xs = self.roi.x
            self.roi_ys = self.roi.y
            self.roi_xs.append(self.roi_xs[0])
            self.roi_ys.append(self.roi_ys[0])
            self.ax.plot(self.roi_xs, self.roi_ys, color = 'r')
            self.canvas.draw_idle()

    def run_button(self):
        self.confirm_bttn["state"] = DISABLED
        self.add_bttn["state"] = DISABLED

        if self.run_bttn.config('relief')[-1] == 'sunken': # if RUNNING: this initiates STOP
            self.run_bttn.config(text='Do it')
            self.run_bttn.config(relief="raised")
            self.run_bttn.config(fg='black')

            self.run_bttn["state"] = DISABLED

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
            self.confirm_bttn["state"] = self.confirm_button_state_before
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
                self.confirm_button_state_before = NORMAL
                self.folder_name_entry_state_before = NORMAL

                # proceed if folder name is valid
                if not(saver.is_savefolder_name_forbidden(self.folder_name)) and not(self.folder_name == "") and not(self.folder_name == 'dryrun'):

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
                    self.acquisition_state = "RUNNING"
                    # t = Thread (target = self.acquire)
                    t = Thread (target = self.acquire)
                    t.start()

                else:
                    # reset status box:
                    self.image_saver_status.delete(0,'end')
                    self.image_saver_status.insert(0,"Invalid folder name!")
                    if self.folder_name == 'dryrun':
                        # reset status box:
                        self.image_saver_status.delete(0,'end')
                        self.image_saver_status.insert(0,"Click 'Dry run' to run a a dryrun...")

            else:
                # means that we're running in dryrun mode
                self.dryrun_state_before = NORMAL 
                self.custom_state_before = DISABLED 
                self.folder_name_entry_state_before = DISABLED
                self.confirm_button_state_before = DISABLED
                
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
                self.acquisition_state = "RUNNING"
                # t = Thread (target = self.acquire)
                t = Thread (target = self.acquire)
                t.start()

    def acquire_test(self):
        while True:
            print('fake acquiring...')
            time.sleep(5)
            if self.acquisition_state == "STOPPED":  
                break
            

    def acquire(self):
        camera_saving_folder_pathname, saving_location_root_pathname, image_specification_list = saver.load_config()
        user_entered_name = self.folder_name
        is_dryrun = user_entered_name == "dryrun"
        savefolder_pathname = saver.initialize_savefolder_portal(saving_location_root_pathname, user_entered_name, is_dryrun)

        if is_dryrun:
            print("Running as a dry run. WARNING: All images will be deleted on termination.\n")

        print("Initializing watchdog...\n")
        my_watchdog = ImageWatchdog(camera_saving_folder_pathname, savefolder_pathname, image_specification_list, image_extension = IMAGE_EXTENSION)
        print("Running!") 

        while True:
            # main while loop goes here
            image_saved = my_watchdog.associate_images_with_run()
            if(image_saved):
                print("Saved something at: ") 
                t = datetime.datetime.now().strftime("%H-%M-%S")
                print(t)
                status_string =  'Saved to: ' + self.folder_name + ', at ' + t
                # reset status box:
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0, status_string)
                
            if self.acquisition_state == "STOPPED":   
                # reset status box:
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0,"Saving last image...")
                print("Trying to save the last images...") 
                my_watchdog.associate_images_with_run() 
                my_watchdog.save_run_parameters()
                print("Success!") 
                time.sleep(1)
                # reset status box:
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0,"Success!")
                if (is_dryrun):
                    saver.nuke_savefolder(savefolder_pathname)
                break  

    def dryrun_toggle(self):
        if self.dryrun_bttn.config('relief')[-1] == 'sunken':
            self.dryrun_bttn.config(relief="raised")
            self.dryrun_bttn.config(fg='black')
            self.custom_bttn["state"] = NORMAL
            self.folder_name_entry["state"] = DISABLED
            self.run_bttn["state"] = DISABLED
        else:
            self.dryrun_bttn.config(relief="sunken")  
            self.dryrun_bttn.config(fg='red')
            self.custom_bttn["state"] = DISABLED
            self.folder_name_entry["state"] = DISABLED
            self.run_bttn["state"] = NORMAL
            self.is_dryrun = True
            # reset status box:
            self.image_saver_status.delete(0,'end')
            self.image_saver_status.insert(0,"dryrun mode selected")

    def custom_toggle(self):
        if self.custom_bttn.config('relief')[-1] == 'sunken':
            self.custom_bttn.config(relief="raised")
            self.custom_bttn.config(fg='black')
            self.dryrun_bttn["state"] = NORMAL
            self.run_bttn["state"] = DISABLED
            self.folder_name_entry["state"] = DISABLED

            # disable confirm button
            self.confirm_bttn["state"] = DISABLED
        else:
            self.custom_bttn.config(relief="sunken")   
            self.custom_bttn.config(fg='red')
            self.dryrun_bttn["state"] = DISABLED
            
            self.is_dryrun = False
            self.folder_name_entry["state"] = NORMAL

            # enable confirm button:
            self.confirm_bttn["state"] = NORMAL

    def confirm_button(self):
        self.folder_name = self.folder_name_entry.get()

        # check for duplicates and validity:
        if (saver.is_savefolder_name_forbidden(self.folder_name)) or (self.folder_name == "") or (self.folder_name == 'dryrun'):

            self.image_saver_status.delete(0,'end')
            self.image_saver_status.insert(0,"Invalid folder name!")
            if self.folder_name == 'dryrun':
                # reset status box:
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0,"Click 'Dry run' to run a a dryrun...")
        
        else: # if all is GRAND...
            # check if folder name already exists:
            camera_saving_folder_pathname, saving_location_root_pathname, image_specification_list = saver.load_config()
            user_entered_name = self.folder_name
            is_dryrun = user_entered_name == "dryrun"
            savefolder_pathname = saver.initialize_savefolder_portal(saving_location_root_pathname, user_entered_name, is_dryrun)

            if (os.path.isdir(savefolder_pathname) and not is_dryrun):
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0,"Folder already exists. Click 'Add' to add or try again.")
                self.add_bttn["state"] = NORMAL
            else:
                self.image_saver_status.delete(0,'end')
                self.image_saver_status.insert(0,"Folder OK. Click 'Do it' to run.")
                self.run_bttn["state"] = NORMAL

    def add_button(self):
        self.run_bttn["state"] = NORMAL
        self.add_bttn["state"] = DISABLED

        # reset status box:
        self.image_saver_status.delete(0,'end')
        self.image_saver_status.insert(0,"Adding to existing folder. 'Do it' to run, or try different folder name.")

    # IMAGING RESONANCE FUNCTIONS:
    def browse_res_button(self):
        self.image_processing_folder_path = filedialog.askdirectory()
        if self.image_processing_folder_path:
            self.res_image_folder_entry.delete(0,'end')
            self.res_image_folder_entry.insert(0, self.image_processing_folder_path)
            # print(self.image_processing_folder_path)
            self.enable_resonance_imaging_mode_buttons()

    def enable_resonance_imaging_mode_buttons(self):
        # enable buttons:
        self.side_lf_bttn["state"] = NORMAL
        self.side_hf_bttn["state"] = NORMAL
        self.TopA_bttn["state"] = NORMAL
        self.TopB_bttn["state"] = NORMAL
        self.TopAB_bttn["state"] = NORMAL
        self.analyze_bttn["state"] = DISABLED

    def side_lf(self):
        if self.side_lf_bttn.config('relief')[-1] == 'sunken':
            self.side_lf_bttn.config(relief="raised")
            self.side_lf_bttn.config(fg='black')
            
            self.enable_resonance_imaging_mode_buttons()
        else:
            self.side_lf_bttn.config(relief="sunken")  
            self.side_lf_bttn.config(fg='red')
            self.resonance_imaging_mode = 'Side_lf'
            # enable buttons:
            self.side_hf_bttn["state"] = DISABLED
            self.TopA_bttn["state"] = DISABLED
            self.TopB_bttn["state"] = DISABLED
            self.TopAB_bttn["state"] = DISABLED
            self.analyze_bttn["state"] = NORMAL

    def side_hf(self):
        if self.side_hf_bttn.config('relief')[-1] == 'sunken':
            self.side_hf_bttn.config(relief="raised")
            self.side_hf_bttn.config(fg='black')
            
            self.enable_resonance_imaging_mode_buttons()
        else:
            self.side_hf_bttn.config(relief="sunken")  
            self.side_hf_bttn.config(fg='red')
            self.resonance_imaging_mode = 'Side_hf'
            # enable buttons:
            self.side_lf_bttn["state"] = DISABLED
            self.TopA_bttn["state"] = DISABLED
            self.TopB_bttn["state"] = DISABLED
            self.TopAB_bttn["state"] = DISABLED

            self.analyze_bttn["state"] = NORMAL

    def TopA(self):
        if self.TopA_bttn.config('relief')[-1] == 'sunken':
            self.TopA_bttn.config(relief="raised")
            self.TopA_bttn.config(fg='black')
            
            self.enable_resonance_imaging_mode_buttons()
        else:
            self.TopA_bttn.config(relief="sunken")  
            self.TopA_bttn.config(fg='red')
            self.resonance_imaging_mode = 'TopA'
            # enable buttons:
            self.side_lf_bttn["state"] = DISABLED
            self.side_hf_bttn["state"] = DISABLED
            self.TopB_bttn["state"] = DISABLED
            self.TopAB_bttn["state"] = DISABLED

            self.analyze_bttn["state"] = NORMAL

    def TopB(self):
        if self.TopB_bttn.config('relief')[-1] == 'sunken':
            self.TopB_bttn.config(relief="raised")
            self.TopB_bttn.config(fg='black')
            
            self.enable_resonance_imaging_mode_buttons()
        else:
            self.TopB_bttn.config(relief="sunken")  
            self.TopB_bttn.config(fg='red')
            self.resonance_imaging_mode ='TopB'
            # enable buttons:
            self.side_hf_bttn["state"] = DISABLED
            self.side_lf_bttn["state"] = DISABLED
            self.TopA_bttn["state"] = DISABLED
            self.TopAB_bttn["state"] = DISABLED
            self.analyze_bttn["state"] = NORMAL

    def TopAB(self):
        if self.TopAB_bttn.config('relief')[-1] == 'sunken':
            self.TopAB_bttn.config(relief="raised")
            self.TopAB_bttn.config(fg='black')
            
            self.enable_resonance_imaging_mode_buttons()
        else:
            self.TopAB_bttn.config(relief="sunken")  
            self.TopAB_bttn.config(fg='red')
            self.resonance_imaging_mode = 'TopAB'
            # enable buttons:
            self.side_hf_bttn["state"] = DISABLED
            self.TopA_bttn["state"] = DISABLED
            self.TopB_bttn["state"] = DISABLED
            self.side_lf_bttn["state"] = DISABLED
            self.analyze_bttn["state"] = NORMAL

    def analyze_button(self):
        # print(self.resonance_imaging_mode)
        self.analyze_bttn["state"] = DISABLED
        measurement_directory_path = self.image_processing_folder_path
        imaging_mode_string = self.resonance_imaging_mode
        # talk to imaging_resonance_processing
        imaging_resonance_processing.main_after_inputs(measurement_directory_path,imaging_mode_string)
    
    # rf resonance processing:
    def browse_rf_button(self):
        self.rf_processing_folder_path = filedialog.askdirectory()
        if self.rf_processing_folder_path:
            self.rf_spect_folder_entry.delete(0,'end')
            self.rf_spect_folder_entry.insert(0, self.rf_processing_folder_path)
            # print(self.rf_processing_folder_path)
            self.rf_analyze_bttn["state"] = NORMAL
            self.rf_analyze_with_guess_bttn["state"] = NORMAL

    def rf_analyze_button(self):        
        rf_spect_processing.main_after_inputs(self.rf_processing_folder_path, self.rf_resonance_key)       

    def rf_analyze_with_guess_button(self):        
        # need add guesses here
        Rabi_guess = self.Rabi_guess_var.get()
        RF_center_guess = self.RF_center_guess_var.get()
        if Rabi_guess == '':
            Rabi_guess = None
        if RF_center_guess == '':
            RF_center_guess = None
        rf_spect_processing.main_after_inputs(self.rf_processing_folder_path, self.rf_resonance_key, RF_center_guess, Rabi_guess)        

    def RF_imaging_options(self, event):
        RF_direction = self.RF_direction.get()
        for i in range(0,len(RF_DIRECTIONS)):
            if RF_direction == RF_DIRECTIONS[i]:
                self.rf_resonance_key = ALL
        print(self.rf_resonance_key)

    # hybrid top analysis
    def browse_hybrid_button(self):
        self.hybrid_processing_folder_path = filedialog.askdirectory()
        if self.hybrid_processing_folder_path:
            self.hybrid_folder_entry.delete(0,'end')
            self.hybrid_folder_entry.insert(0, self.hybrid_processing_folder_path)
            self.abs_img_bttn["state"] = NORMAL
            self.polrot_img_bttn["state"] = NORMAL

    def hybrid_analyze_button(self):  
        t = Thread (target = self.hybrid_analyze_button_act)
        t.start()

    def hybrid_analyze_button_act(self):
        hybrid_top_processing.main_after_inputs(self.hybrid_processing_folder_path, self.hybrid_imaging_mode)

    def abs_img(self):
        if self.abs_img_bttn.config('relief')[-1] == 'sunken':
            self.abs_img_bttn.config(relief="raised")
            self.abs_img_bttn.config(fg='black')
            
            self.abs_img_bttn["state"] = NORMAL
            self.polrot_img_bttn["state"] = NORMAL
            self.hybrid_analyze_bttn["state"] = DISABLED   
        else:
            self.abs_img_bttn.config(relief="sunken")  
            self.abs_img_bttn.config(fg='red')
            self.hybrid_imaging_mode = 'abs'
            # enable buttons:
            self.polrot_img_bttn["state"] = DISABLED
            self.hybrid_analyze_bttn["state"] = NORMAL

    def polrot_img(self):
        if self.polrot_img_bttn.config('relief')[-1] == 'sunken':
            self.polrot_img_bttn.config(relief="raised")
            self.polrot_img_bttn.config(fg='black')
            
            self.polrot_img_bttn["state"] = NORMAL
            self.abs_img_bttn["state"] = NORMAL
            self.hybrid_analyze_bttn["state"] = DISABLED   
        else:
            self.polrot_img_bttn.config(relief="sunken")  
            self.polrot_img_bttn.config(fg='red')
            self.hybrid_imaging_mode = 'polrot'
            # enable buttons:
            self.abs_img_bttn["state"] = DISABLED
            self.hybrid_analyze_bttn["state"] = NORMAL

def toggle_selector(event):
            print (' Key pressed.')
            if event.key in ['Q', 'q'] and toggle_selector.RS.active:
                print (' RectangleSelector deactivated.')
                toggle_selector.RS.set_active(False)
            if event.key in ['A', 'a'] and not toggle_selector.RS.active:
                print (' RectangleSelector activated.')
                toggle_selector.RS.set_active(True)

'''
Credit: Eric A. Wolf, BEC1@MIT, 2022. 

Convenience function for safely subtracting two arrays of unsigned type.
Minimum cast: A numpy dtype which represents the ‘minimal datatype’ to which the
minuend and subtrahend must be cast. For unsigned type, np.byte is the default,
enforcing a signed type without data loss.
Please note: if the differences returned by safe_subtract are later manipulated,
it may be necessary to use a ‘larger’ minimum cast for safety. np.byte only guarantees
that no overflows are obtained when two unsigned integers are subtracted.
'''

def safe_subtract(x, y, minimum_cast = np.byte):
    newtype = np.result_type(x, y, minimum_cast)
    return x.astype(newtype) - y.astype(newtype)

#####################################################################
#####################################################################

#### code for free hand tool... taken from github.com/jdoepfert/roipoly.py/blob/master/roipoly/roipoly.py
#### why not install package? Because code is cursed... some methods don't work properly

class RoiPoly:

    def __init__(self, fig=None, ax=None, color='b',
                 roicolor=None, show_fig=True, close_fig=True):
        """
        Parameters
        ----------
        fig: matplotlib figure
            Figure on which to create the ROI
        ax: matplotlib axes
            Axes on which to draw the ROI
        color: str
           Color of the ROI
        roicolor: str
            deprecated, use `color` instead
        show_fig: bool
            Display the figure upon initializing a RoiPoly object
        close_fig: bool
            Close the figure after finishing ROI drawing
        """

        if roicolor is not None:
            color = roicolor

        if fig is None:
            fig = plt.gcf()
        if ax is None:
            ax = plt.gca()

        self.start_point = []
        self.end_point = []
        self.previous_point = []
        self.x = []
        self.y = []
        self.line = None
        self.completed = False  # Has ROI drawing completed?
        self.color = color
        self.fig = fig
        self.ax = ax
        self.close_figure = close_fig

        # Mouse event callbacks
        self.__cid1 = self.fig.canvas.mpl_connect(
            'motion_notify_event', self.__motion_notify_callback)
        self.__cid2 = self.fig.canvas.mpl_connect(
            'button_press_event', self.__button_press_callback)

        if show_fig:
            self.show_figure()

    @staticmethod
    def show_figure():
        if sys.flags.interactive:
            plt.show(block=False)
        else:
            plt.show(block=True)

    def __motion_notify_callback(self, event):
        if event.inaxes == self.ax:
            x, y = event.xdata, event.ydata
            if ((event.button is None or event.button == 1) and
                    self.line is not None):
                # Move line around
                x_data = [self.previous_point[0], x]
                y_data = [self.previous_point[1], y]
                logger.debug("draw line x: {} y: {}".format(x_data, y_data))
                self.line.set_data(x_data, y_data)
                self.fig.canvas.draw()

    def __button_press_callback(self, event):
        if event.inaxes == self.ax:
            x, y = event.xdata, event.ydata
            ax = event.inaxes
            if event.button == 1 and not event.dblclick:
                logger.debug("Received single left mouse button click")
                if self.line is None:  # If there is no line, create a line
                    self.line = plt.Line2D([x, x], [y, y],
                                           marker='.', color=self.color)
                    self.start_point = [x, y]
                    self.previous_point = self.start_point
                    self.x = [x]
                    self.y = [y]

                    ax.add_line(self.line)
                    self.fig.canvas.draw()
                    # Add a segment
                else:
                    # If there is a line, create a segment
                    x_data = [self.previous_point[0], x]
                    y_data = [self.previous_point[1], y]
                    logger.debug(
                        "draw line x: {} y: {}".format(x_data, y_data))
                    self.line = plt.Line2D(x_data, y_data,
                                           marker='.', color=self.color)
                    self.previous_point = [x, y]
                    self.x.append(x)
                    self.y.append(y)

                    event.inaxes.add_line(self.line)
                    self.fig.canvas.draw()

            elif (((event.button == 1 and event.dblclick) or
                   (event.button == 3 and not event.dblclick)) and
                  self.line is not None):
                # Close the loop and disconnect
                logger.debug("Received single right mouse button click or "
                             "double left click")
                self.fig.canvas.mpl_disconnect(self.__cid1)
                self.fig.canvas.mpl_disconnect(self.__cid2)

                self.line.set_data([self.previous_point[0],
                                    self.start_point[0]],
                                   [self.previous_point[1],
                                    self.start_point[1]])
                ax.add_line(self.line)
                self.fig.canvas.draw()
                self.line = None
                self.completed = True

                if not sys.flags.interactive and self.close_figure:
                    #  Figure has to be closed so that code can continue
                    plt.close(self.fig)




#####################################################################
#####################################################################
#####################################################################
#####################################################################
#####################################################################


def main():
    root = Tk()
    root.title('BEC1 Image Browser')
    root.geometry("1920x1080")
    BEC1_exp_portal = BEC1_Portal(root)
    root.mainloop()

    return 

if __name__ == "__main__":
	main()