
import sys 

if len(sys.argv) == 1:
    filename = input("Fill in data file: ")
else:
    filename = sys.argv[1]

def w(output_file, trans):
    o = ""
    for t in trans:
        o += f"{t} "
    o += "\n"
    output_file.write(o)


with open(filename, "r") as data_file: 
    data = [entry.strip().split( ) for entry in data_file.readlines()]

with open(f'{filename}.cl', "w") as output_file: 
    for entry in data: 
        t_count = int(entry[0])
        index = 1

        for i in range(t_count):
            t_len = int(entry[index])
            trans = entry[index + 1: index + 1 + t_len]
            index = index + t_len + 1
            w(output_file, trans)
