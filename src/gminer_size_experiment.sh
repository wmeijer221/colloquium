#!/bin/sh
#SBATCH --mem=8G
#SBATCH --gres=gpu:v100:1

# This script executes the entire GMiner data-size experiment.

D=(1000 750 500 250 100)
T=20
I=10

echo -e "Starting Density Experiment"

for d in "${D[@]}"
do 
    :
    echo -e "Step 1: Generating dataset (D: $d)"
    DATA_DIR="./datasets/ibm"
    FNAME="D${d}K-T${T}-I${I}K"

    ./repositories/ibm_generator/seq_data_generator lit -ntrans $d -nitems $I -tlen $T -ascii -fname "$DATA_DIR/$FNAME"
    python3 ./src/generate_datasets/clean.py "$DATA_DIR/$FNAME.data"
    python3 ./src/generate_datasets/calc_statistics.py "$DATA_DIR/$FNAME.data.cl" >> "$DATA_DIR/$FNAME.pat"


    echo -e "Step 2: Intermediary Clean-up"
    rm $DATA_DIR/**.data
    mv "$DATA_DIR/$FNAME.data.cl" "$DATA_DIR/$FNAME.dat"


    echo -e "Step 3: Perform experiment"
    RESULT_DIR="./results"

    REPS=10
    MIN_SUP=0.0005

    echo -e "Dataset: $FNAME\nRepetitions: $REPS\nMinimum Support: $MIN_SUP\n\n" >> "$RESULT_DIR/$FNAME.out"

    for ((i=1; i<=$REPS; i+=1))
    do 
        :
        echo -e "Repetition $i/$REPS"
        echo -e "\n\nRepetition: $i / $REPS" >> "$RESULT_DIR/$FNAME.out"
        ./repositories/gminer/GMiner -i "$DATA_DIR/$FNAME.dat" -o "$RESULT_DIR/$FNAME.dat" -s $MIN_SUP -w 1 >> "$RESULT_DIR/$FNAME.out"
    done


    echo -e "Step 4: Final clean-up"
    echo -e "\n\nGenerated Pattern File:\n" >> "$RESULT_DIR/$FNAME.out"
    cat "$DATA_DIR/$FNAME.pat" >> "$RESULT_DIR/$FNAME.out"
    rm "$DATA_DIR/$FNAME.pat"

    echo -e "\n\nFound Patterns:\n" >> "$RESULT_DIR/$FNAME.out"
    cat "$RESULT_DIR/$FNAME.dat" >> "$RESULT_DIR/$FNAME.out"
    rm "$RESULT_DIR/$FNAME.dat"

    echo -e "Step 5: Done!\n"
done
