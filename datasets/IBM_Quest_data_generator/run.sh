OUTPUT=output/datafile

echo "P1: Generating new dataset"
./seq_data_generator seq -slen 6 -tlen 29 -nitems 0.05 -ascii -fname $OUTPUT

echo "P2: Cleaning/Reformatting dataset"
python3 ./clean2.py $OUTPUT.data

echo "P3: Generating dataset statistics"
python3 ./calc_statistics.py $OUTPUT.data.cl
