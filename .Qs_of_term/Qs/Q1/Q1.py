# Amir Arsalan Yavari - 9830253

from re import compile


# Ansii color class
class bcolors:
    OK = '\033[92m'  # GREEN
    FAIL = '\033[91m'  # RED
    PROMPT = '\033[93m'  # YELLOW
    RESET = '\033[0m'  # RESET COLOR


def main():
    x = input("Which part of Q1?\n1) All binaries string with exactly four 1\n2) All binaries number that greater than 101001\n3) All binaries number that multiple of 5\n4) All strings that at most 2 times \"11\" substring apeard\n" + bcolors.PROMPT + ">> " + bcolors.RESET)

    try:
        if(x == "1"):
            Q1()
        elif(x == "2"):
            Q2()

        elif(x == "3"):
            Q3()

        elif(x == "4"):
            Q4()

        else:
            print("Invalid input :(\tbye bye :D")

    except KeyboardInterrupt:
        exit()


def Q1():
    reg = compile('0*10*10*10*10*$')
    while True:
        i = input("Enter your input\n" +
                  bcolors.PROMPT + ">> " + bcolors.RESET)
        if reg.match(i):
            print(bcolors.OK + "Yes it matched" + bcolors.RESET)
        else:
            print(bcolors.FAIL + "The pattern !matche" + bcolors.RESET)


def Q2():
    reg = compile('[0-1]*1((1[0-1]{4})|(011[0-1]{2})|(0101[0-1]))$')
    while True:
        i = input("Enter your input\n" +
                  bcolors.PROMPT + ">> " + bcolors.RESET)
        if reg.match(i):
            print(bcolors.OK + "Yes its more than 101001 :D" + bcolors.RESET)
        else:
            print(bcolors.FAIL +
                  "Sorry the input number in Wrong format(its not binary!) OR less than 101001 X(" + bcolors.RESET)


def Q3():
    reg = compile('(0|1(10)*(0|11)(01*01|01*00(10)*(0|11))*1)*$')
    while True:
        i = input("Enter your input\n" +
                  bcolors.PROMPT + ">> " + bcolors.RESET)
        if reg.match(i):
            print(bcolors.OK + "Yes its multiple of 5 =)" + bcolors.RESET)
        else:
            print(bcolors.FAIL +
                  "Oops! its not multiple of 5 =(" + bcolors.RESET)


def Q4():
    # reg = compile("[^11]*(11)?[^11]*(11)?[^11]*$")
    # piram kard :$       Download qam o andoh faravan :(       1 saat tool keshid X(
    # https://stackoverflow.com/questions/611883/regex-how-to-match-everything-except-a-particular-pattern#611897   khoda kheyresh bede

    # reg = compile(
    #     "[^1]*((?!11)\w)*[^1]*(11)?[^1]*((?!11)\w)*[^1]*(11)?[^1]*((?!11)\w)*[^1]*$")

    # The last version
    reg = compile("((?!11).)*(11)?((?!11).)*(11)?((?!11).)*$")

    while True:
        i = input("Enter your input\n" +
                  bcolors.PROMPT + ">> " + bcolors.RESET)
        if reg.match(i):
            print(
                bcolors.OK + "Yes The input string has at most 2 times of \"11\" :D" + bcolors.RESET)
        else:
            print(bcolors.FAIL + "Oops! Wrong format X(" + bcolors.RESET)


if __name__ == "__main__":
    main()
