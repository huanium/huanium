# Huan Q. Bui, BEC1@MIT
# Created: 10:00 am, April 13, 2023
# Last updated: April 13, 2023

# Lock monitor for BEC1 with GUI

import tkinter as tk
from tkinter import *
from tkinter import ttk

class Lock_Monitor():
    def __init__(self, master):
        self.master = master
        self.lock_monitor = Frame(master)
        self.lock_monitor.pack() 

        tabControl = ttk.Notebook(master)
        self.tab1 = ttk.Frame(tabControl)
        tabControl.pack(expand = 1, fill ="both")

        tabControl.add(self.tab1, text ='Image Browser')

        # engage button
        self.engage_bttn = Button(self.tab1, text="Engage", relief="raised",  width=8, command= self.engage)
        self.engage_bttn.place(x=20,y=20)
        # disengage button
        self.disengage_bttn = Button(self.tab1, text="Stop", relief="raised",  width=8, command= self.disengage)
        self.disengage_bttn.place(x=150,y=20)

        # add trigger level
        self.trig_label = Label(self.tab1, text="Trigger level for Li: ")
        self.trig_label.place(x=20, y=70)
        self.trig_entry = Entry(self.tab1, text="new param", width=15)
        self.trig_entry.place(x=150, y=70)  
        self.trig_entry.delete(0,'end')   
        self.trig_entry.insert(0, "") 
        self.trig = self.trig_entry.get()

    def engage(self):
         return 
    
    def disengage(self):
         return
            

def main():
    root = Tk()
    root.title('BEC1 Lock Monitor')
    root.geometry("500x500")
    lock_monitor = Lock_Monitor(root)
    root.mainloop()

    return 

if __name__ == "__main__":
	main()