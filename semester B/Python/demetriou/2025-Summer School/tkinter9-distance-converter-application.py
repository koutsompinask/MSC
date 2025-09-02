#tkinter-distance-converter-application.py
'''
9
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
def convert_km_to_miles():
    km = textbox1.get()
    try:
        km = float(km)
        message = round(km * 0.6214,2)
        textbox2.delete(0, END)
        textbox2.insert(END, message)
    except ValueError:
        textbox2.delete(0, END)
        textbox2.insert(END, "Invalid input")

def convert_miles_to_km():
    miles = textbox2.get()
    try:
        miles = float(miles)
        message = round(miles * 1.60934,2)
        textbox1.delete(0, END)
        textbox1.insert(END, message)
    except ValueError:
        textbox1.delete(0, END)
        textbox1.insert(END, "Invalid input")

window = Tk()
window.title("Distance Converter")
window.geometry("260x200")

label1 = Label(text="Enter the value you want to convert:")
label1.place(x=30, y=20)

textbox1 = Entry()
textbox1["justify"] = "center"
textbox1.place(x=30, y=50, width=200, height=25)
textbox1.focus()

convert_button1 = Button(text="km to miles", command=convert_km_to_miles)
convert_button1.place(x=30, y=80, width=100, height=25)

convert_button2 = Button(text="miles to km", command=convert_miles_to_km)
convert_button2.place(x=130, y=80, width=100, height=25)

textbox2 = Entry()
textbox2.place(x=30, y=110, width=200, height=25)
textbox2["justify"] = "center"

window.mainloop()
