import sys


def w(output_file, trans):
    o = ""
    for t in trans:
        o += f"{t} "
    o += "\n"
    output_file.write(o)


if len(sys.argv) == 1:
    filename = input("Fill in data file: ")
else:
    filename = sys.argv[1]


with open(filename, "r") as data_file:
    data = [entry.strip().split(" ") for entry in data_file.readlines()]

with open(filename + ".cl", "w") as output_file:
    for entry in data:
        split = entry[1:]

        trans = []

        prev_element = 0
        for element in split:
            if prev_element < int(element):
                trans.append(element)
                prev_element = int(element)
            else:
                w(output_file, trans)
                trans = [element]
                prev_element = int(element)

        w(output_file, trans)
