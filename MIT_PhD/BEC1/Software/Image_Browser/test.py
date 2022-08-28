def main():

    stuff = 100

    try:
        while True:
            a = 5/stuff
            stuff = stuff-1
            print(a)
    except ZeroDivisionError:
        print("Trying to save the last images...") 
        print("Success!") 
    finally:
        print("finally")



if __name__ == "__main__":
    main() 