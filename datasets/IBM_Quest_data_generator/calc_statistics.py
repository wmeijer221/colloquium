import sys

if len(sys.argv) == 1: 
    datafile = input("Fill in data file: ")
else: 
    datafile = sys.argv[1]


with open(datafile, "r") as data_file: 
    data = [entry.strip().split(" ") for entry in data_file.readlines()]


avg_trans_length = 0.0
items = set()

for entry in data:
    avg_trans_length += len(entry)
    for element in entry: 
        items.add(element)

avg_trans_length /= len(data)

density = (avg_trans_length / len(items)) * 100


print(f'Statistics:\n\t{density=}%\n\t{avg_trans_length=}\n\t{len(items)=}\n\t30{len(data)=}')
