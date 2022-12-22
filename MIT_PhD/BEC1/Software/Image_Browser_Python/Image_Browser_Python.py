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
        self.min_entry = Entry(self.tab1, text="", width=5).place(x=60, y=460)

        self.max_label = Label(self.tab1, text="Max: ").place(x=110, y = 460)
        self.max_entry = Entry(self.tab1, text="", width=5).place(x=150, y=460)

        # brightness:
        self.brightness_label = Label(self.tab1, text="Brightness: ").place(x=200, y = 460)
        self.brightness_entry = Entry(self.tab1, text="14", width=5).place(x=275, y=460)        

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
                self.file_names.append(name[1]) # make list of file names
            
            # first clear table:
            self.file_table.delete(*self.file_table.get_children())
            # then repopulate:
            for i in range(len(self.file_names)):
                id = str(len(self.file_names)-i)               
                # then repopulate
                self.file_table.insert("","end",text = id, values = (self.file_names[len(self.file_names)-i-1]))

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
            return 0

    def OD_select(self):
        self.frame_type = 'OD'

    def with_atoms_select(self):
        self.frame_type = 'With atoms'

    def without_atoms_select(self):
        self.frame_type = 'Without atoms'

    def dark_select(self):
        self.frame_type = 'Dark'

    def FakeOD_select(self):
        self.frame_type = 'FakeOD'

    def select_params(self):
        return 0

    def selectItem(self, event):
        curItem = self.file_table.focus()
        curItem = self.file_table.item(curItem)
        self.current_file_name = curItem['values'][0]

        # make fullpath of selected file
        self.current_file_fullpath = self.folder_path + '/' + self.current_file_name

        # now display image:
        display_image(self)


def display_image(self):

    fits_image = fits.open(self.current_file_fullpath)
    fits_image.info()
    img = fits_image[0].data
    fits_image.close()

    # now show image:
    frame_type = self.frame_type

    if frame_type == 'OD':
        frame = np.real(-np.log((img[0,:,:]-img[2,:,:])/(img[1,:,:]-img[2,:,:])))

        self.fig.clear()
        h = self.fig.add_subplot(111)
        h.imshow(frame, cmap='gray').set_clim(0,1.3)
        h.invert_yaxis()
        self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
        self.canvas.draw_idle()
    else:
        if frame_type == 'FakeOD':
            frame = np.real((img[0,:,:]-img[2,:,:])/(img[1,:,:]-img[2,:,:]))

            self.fig.clear()
            h = self.fig.add_subplot(111)
            h.imshow(frame, cmap='gray').set_clim(0,1.3)
            h.invert_yaxis()
            self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
            self.canvas.draw_idle()

        else:
            if frame_type == 'With atoms':
                frame = img[0,:,:]

                self.fig.clear()
                h = self.fig.add_subplot(111)
                h.imshow(frame, cmap='gray')  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                h.invert_yaxis()
                self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                self.canvas.draw_idle()

            elif frame_type == 'Without atoms':
                frame = img[1,:,:]

                self.fig.clear()
                h = self.fig.add_subplot(111)
                h.imshow(frame, cmap='gray')  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                h.invert_yaxis()
                self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                self.canvas.draw_idle()

            elif frame_type == 'Dark':
                frame = img[2,:,:]

                self.fig.clear()
                h = self.fig.add_subplot(111)
                h.imshow(frame, cmap='gray')  # need to adjust gray scale/colormap here with BRIGHTNESS variable
                h.invert_yaxis()
                self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                self.canvas.draw_idle()

            else:
                frame = np.real(-np.log((img[0,:,:]-img[2,:,:])/(img[1,:,:]-img[2,:,:])))

                self.fig.clear()
                h = self.fig.add_subplot(111)
                h.imshow(frame, cmap='gray').set_clim(0,1.3)
                h.invert_yaxis()
                self.fig.subplots_adjust(left=0.05, bottom=0.02, right=0.98, top=0.98, wspace=0, hspace=0)
                self.canvas.draw_idle()


def main():
    root = Tk()
    root.title('BEC1 Image Browser')
    root.geometry("1700x1000")
    BEC1_exp_portal = BEC1_Portal(root)
    root.mainloop()

    return 

if __name__ == "__main__":
	main()