from tkinter import *

def click():
    name = textbox1.get()
    message = str("hello " + name)
    textbox2["bg"] = "yellow"
    textbox2["text"] = message
    textbox2["fg"] = "black"

window = Tk()
window.title("My First GUI Application")
window.geometry("500x500")

label1 = Label(window, text="Enter your name:")
label1.place(x=30, y=20)

textbox1 = Entry(text = "")
textbox1.place(x=170, y=20, width=500, height=25)
textbox1["justify"] = "center"
textbox1.focus()

textbox2 = Message(text="", width=500)
textbox2.place(x=170, y=50, width=500, height=25)
textbox2["justify"] = "center"

button1 = Button(text="Submit", command=click)
button1.place(x=30, y=50, width=120, height=25)

window.mainloop()