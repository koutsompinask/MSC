#tkinter-enter-add-numbers.py
'''
7
'''
from tkinter import *

def add_on():
    num = enter_txt.get()       # Get input from Entry
    try:
        num = int(num)          # Convert to integer
        answer = int(output_txt["text"])  # Get current output and
                                          #  convert to integer
        total = num + answer    # Calculate total
        output_txt["text"] = total  # Update the output
        enter_txt.delete(0, END)    # Clear entry field EXERCISE
    except ValueError:
        output_txt["text"] = "Invalid input"  # Handle non-integer input

def reset():
    output_txt["text"] = 0      # Reset output to 0
    enter_txt.delete(0, END)    # Clear entry field
    enter_txt.focus()           # Focus on entry field

total = 0
num = 0

# Create main window
window = Tk()
window.title("Adding Together")
window.geometry("500x100")

# Create label and entry for input
enter_label = Label(text="Enter a number:")
enter_label.place(x=20, y=20, width=150, height=25)

enter_txt = Entry()
enter_txt["justify"] = "center"
enter_txt.place(x=180, y=20, width=150, height=25)
enter_txt.focus()

# Button to add numbers
add_btn = Button(text="Add", command=add_on)
add_btn.place(x=350, y=20, width=50, height=25)

# Label for output
output_label = Label(text="Answer = ")
output_label.place(x=20, y=50, width=150, height=25)
output_txt = Message(text=0, width=150) 
output_txt.place(x=180, y=50, width=150, height=25)
output_txt["bg"] = "white"       # Set background color for output
output_txt["relief"] = "sunken"  # Set relief style

# Button to clear/reset
clear_btn = Button(text="Clear", command=reset)
clear_btn.place(x=350, y=50, width=50, height=25)

# Run the application
window.mainloop()
