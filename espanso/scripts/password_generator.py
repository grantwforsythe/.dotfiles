import string
import random
import subprocess


LENGTH = 16


def password_generator(length: int) -> str:
    """ Function that generates a password given a length """

    uppercase_loc = random.randint(1, 4)  # random location of lowercase
    symbol_loc = random.randint(5, 6)  # random location of symbols
    lowercase_loc = random.randint(7, 12)  # random location of uppercase
    digit_loc = random.randint(13, 16) # random location of a digit

    password = ''  # empty string for password

    pool = string.ascii_letters + string.punctuation + string.digits  # the selection of characters used

    for i in range(length):

        if i == uppercase_loc:   # this is to ensure there is at least one uppercase
            password += random.choice(string.ascii_uppercase)
        elif i == lowercase_loc:  # this is to ensure there is at least one uppercase
            password += random.choice(string.ascii_lowercase)
        elif i == symbol_loc:  # this is to ensure there is at least one symbol
            password += random.choice(string.punctuation)
        elif i == digit_loc:
            password += random.choice(string.digits)
        else:  # adds a random character from pool
            password += random.choice(pool)

    return password  # returns the string


def copy2clip(txt: str):
    """ Copies a string to the clipboard """
    cmd='echo '+txt.strip()+'|clip'
    return subprocess.check_call(cmd, shell=True)


password = password_generator(LENGTH)
print(password) # write the password into form data
copy2clip(password)