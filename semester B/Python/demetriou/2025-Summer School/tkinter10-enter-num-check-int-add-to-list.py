#tkinter-enter-num-check-int-add-to-list+csv.py

'''
10
Create a window that will ask the user to enter
a number in a text box. When they click on a
button it will use the code
variable.isdigit()
to check to see if it is a whole number.
If it is a whole number, add it to a list box,
otherwise clear the entry box. Add another button
that will clear the list.

'''

from tkinter import *
import csv

def add_number():
    num = num_box.get()
    if num.isdigit():
        num_list.insert(END, num)
        num_box.delete(0, END)
        num_box.focus()
    else:
        num_box.delete(0, END)
        num_box.focus()

def clear_list():
    num_list.delete(0, END)
    num_box.focus()

def save_list():
    with open("numbers.csv", "w", newline='') as file:
        writer = csv.writer(file)
        tmp_list = num_list.get(0, END)
        for record in tmp_list:
            writer.writerow([record])  # Write each number as a new row

window = Tk()
window.title("Number list")
window.geometry("400x200")

label1 = Label(text="Enter a number:")
label1.place(x=20, y=20, width=100, height=25)

num_box = Entry()  #Enter or display a single line of text in Tkinter
num_box.place(x=120, y=20, width=100, height=25)
num_box.focus()

button1 = Button(text="Add to list", command=add_number)
button1.place(x=250, y=20, width=100, height=25)

num_list = Listbox()
num_list.place(x=120, y=50, width=100, height=100)

button2 = Button(text="Clear list", command=clear_list)
button2.place(x=250, y=50, width=100, height=25)

button3 = Button(text="Save list", command=save_list)
button3.place(x=250, y=80, width=100, height=25)

window.mainloop()
