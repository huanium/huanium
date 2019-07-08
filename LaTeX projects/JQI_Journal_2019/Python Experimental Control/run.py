import PySimpleGUI as sg
from tkinter import *
import GUI_functions as GUI_functions
import GUI_main
import settings
import nidaqmx
import math
import numpy as np
from nidaqmx import *
import matplotlib.pyplot as plt

# the settings library defines some global variables
if __name__ == "__main__":
    # runs the GUI on Loop
    # every change in the window results in a new refresh
    # The default number of time points is 5

    settings.init()
    GUI_main.sequence_to_instructions()
    GUI_main.make_window(settings.default_num_pts)
    GUI_main.update_sequence()
    GUI_main.sequence_to_instructions()

    while True:
        if settings.event == 'Apply' or settings.event == '_spin_' or settings.new_time_points != settings.old_time_points:
            GUI_main.sequence_to_instructions()
            GUI_main.make_window(settings.new_time_points)
# settings.new_time_points != settings.old_time_points or s
