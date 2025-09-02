#tkinter-names-list-application.py
'''
8
'''

from tkinter import *
def add_name():
    name = name_box.get()
    if name:  # Check if the name is not empty
        name_list.insert(END, name)
        name_box.delete(0, END)
        name_box.focus()

def clear_list():
    name_list.delete(0, END)
    name_box.focus()

# Create the main window
window = Tk()
window.title("Names List")
window.geometry("400x200")

# Label for input
label1 = Label(text="Enter a name:")
label1.place(x=20, y=20, width=100, height=25)

# Entry box for user input
name_box = Entry()
name_box.place(x=120, y=20, width=100, height=25)
name_box.focus()

# Listbox to display names
name_list = Listbox()
name_list.place(x=120, y=50, width=100, height=100)

# Button to clear the list
button2 = Button(text="Clear list", command=clear_list)
button2.place(x=250, y=50, width=100, height=25)

# Button to add name (added this to ensure functionality)
button1 = Button(text="Add to list", command=add_name)
button1.place(x=250, y=20, width=100, height=25)

# Start the main loop
window.mainloop()
