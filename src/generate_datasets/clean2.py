import sys 

data_path = sys.argv[1]

with open(data_path, "r") as data_file: 
    data = data_file.read().strip().split(" ")


def parse(_index: int, output_file, data: list) -> int:
    length = int(data[_index])
    start = _index + 1
    end = start + length
    entry = data[start:end]

    for element in entry: 
        output_file.write(f'{element} ')
    output_file.write("\n")

    return end

output_path = f'{data_path}.cl'
with open(output_path, "w") as output_file: 
    index = 0
    while index < len(data): 
        index = parse(index, output_file, data)

