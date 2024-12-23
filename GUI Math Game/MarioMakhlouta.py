import tkinter as tk
from tkinter import messagebox
import random
import os

# Change root directory to script directory
script_directory = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_directory)

# global Variables
score = 0
corect_answer_counter = 0
random_operation = ""
timer = 60
user_name = ""

# functions
def update_timer():
    global timer
    global score
    global user_name

    if timer > 0:
        timer_as_string = str(timer)
        timer_label.config(text=f"Timer: {timer_as_string}s")
        timer -= 1
        main_window.after(1000, update_timer)   
    else:
        timer_label.config(text="Timer: 00s")
        messagebox.showinfo("Time's Up", f"The time has ended!\nYour score is: {score} points\nSaved in <scores.txt>")
        try:
            with open("scores.txt", 'a') as output_fd:
                output_fd.write(f"Name: {user_name}, Score: {score}\n")
        except FileNotFoundError:
            messagebox.showinfo("File Not Found", "Error. File <scores.txt> Not found!")
        main_window.destroy()

def generate_operation():
    global random_operation

    random_operation = ""
    random_number_1 = random.randint(1,20)
    random_operation += str(random_number_1)
    list_operator = ['+', '-', '*', '/']
    operator = random.choice(list_operator)
    random_operation += operator
    random_number_2 = random.randint(1,20)
    while((operator == '/' and random_number_1 < random_number_2) or (random_number_1 % random_number_2) != 0):
        random_number_2 = random.randint(1,20)
    random_operation += str(random_number_2)
    random_problem.config(text=random_operation)

def check_answer(event=None):
    global score
    global corect_answer_counter

    try:
        correct_answer = eval(random_operation)
        user_answer = int(input_entry.get())
        if int(correct_answer) == user_answer:
            score += 10
            corect_answer_counter += 1
            score_label.config(text=f"Correct answer: {corect_answer_counter}")
            generate_operation()
            input_entry.delete(0, tk.END)
        else:
            messagebox.showinfo("Wrong Answer", f"You have entered a wrong answer.\nYour score is: {score} points")
            generate_operation()
            input_entry.delete(0, tk.END)
    except ValueError:
        messagebox.showerror("Input Error", "Please enter a valid number.")
        input_entry.delete(0, tk.END)

def quit(event):
    main_window.destroy()


# Main Program (Main window and Widgets)
user_name = input("What's Your Name? ") #to enter the user name in the terminal

main_window = tk.Tk()
main_window.title("Python Game")
main_window.geometry("300x300")
main_window.resizable(False, False)

main_window.bind("<KeyPress-m>", quit) #key m to quit

random_problem = tk.Label(main_window, text="", font=("Arial", 15), fg="Blue")
random_problem.pack(pady=10)

generate_operation()

input_entry = tk.Entry(main_window, justify='center', bd=5)
input_entry.pack(pady=10)

submit_button = tk.Button(main_window, text="Submit", font=("Arial", 10, "bold"), bd=5, command=check_answer)
submit_button.pack(pady=10)

input_entry.bind("<Return>", check_answer) # bind an event with the entry widgets by clicking ENTER button

timer_label = tk.Label(main_window, text="", font=("Arial", 15, "bold"), fg="Red")
timer_label.pack(pady=10)

score_label = tk.Label(main_window, text=f"Correct answer: {corect_answer_counter}", font=("Arial", 20, "bold", "italic"))
score_label.pack(pady=10)

update_timer()

main_window.mainloop()