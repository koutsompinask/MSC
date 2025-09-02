#tkinter-add-names-ages-csv-display-csv.py

'''
13
Using the .csv file you created for the previous program,
create a program that will allow people to add names
and ages to the list and create a button that will
display the contents of the .csv file by importing
it to a list box. 
'''
from tkinter import *
import csv

def create_new():
    # Create a new CSV file
    with open("ages.csv", "w") as file:
        pass  # No need to write anything, just create the file

def save_list():
    # Append name and age to the CSV file
    with open("ages.csv", "a", newline='') as file:
        name = name_box.get()
        age = age_box.get()
        new_record = name + "," + age + "\n"
        file.write(new_record)

    # Clear entry fields
    name_box.delete(0, END)
    age_box.delete(0, END)
    name_box.focus()

def read_list():
    # Clear the listbox and read entries from the CSV file
    name_list.delete(0, END)
    with open("ages.csv", newline='') as file:
        reader = csv.reader(file)
        for row in reader:
            name_list.insert(END, f"Name: {row[0]}, Age: {row[1]}")

# Set up the main window
window = Tk()
window.title("People List")
window.geometry("400x300")

# Label and entry for name
label1 = Label(text="Enter a name:")
label1.place(x=20, y=20, width=100, height=25)

name_box = Entry()
name_box.place(x=120, y=20, width=100, height=25)
name_box["justify"] = "left"
name_box.focus()

# Label and entry for age
label2 = Label(text="Enter their age:")
label2.place(x=20, y=50, width=100, height=25)

age_box = Entry()
age_box.place(x=120, y=50, width=100, height=25)
age_box["justify"] = "left"

# Button to create a new CSV file
button1 = Button(text="Create new file", command=create_new)
button1.place(x=250, y=20, width=100, height=25)

# Button to add to the CSV file
button2 = Button(text="Add to file", command=save_list)
button2.place(x=250, y=50, width=100, height=25)

# Button to read entries from the CSV file
button3 = Button(text="Read list", command=read_list)
button3.place(x=250, y=80, width=100, height=25)

# Listbox to display names and ages
name_list = Listbox()
name_list.place(x=20, y=110, width=360, height=150)

window.mainloop()
