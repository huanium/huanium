import PySimpleGUI as sg
import GUI_functions as GUI_functions
import GUI_main
import settings




if __name__ == "__main__":

    settings.init()
    GUI_main.make_window(10)


    while True:
        
        if settings.new_time_points != settings.old_time_points:
            GUI_main.make_window(settings.new_time_points)
