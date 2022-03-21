#!/bin/sh
# This script executes the entire GMiner FIM experiment.

I=(1 2 3 4 5 6)             # Number of unique items
D=(100 250 500 750 1000)    # Number of transactions
T=(10 25 40 55)             # Average transaction length
MIN_SUP=(0.0002 0.0006 0.001 0.0014 0.0018 0.0022)  # Minimum support values

REPS=3                      # Number of repetitions performed.
DATA_DIR="./datasets/ibm"
RESULT_DIR="./results/gminer"

mkdir ./datasets
mkdir ./datasets/ibm
mkdir ./results
mkdir ./results/gminer

echo -e "Starting Experiment"

for d in "${D[@]}"
do 
    :
    for t in "${T[@]}"
    do 
        :

        for i in "${I[@]}"
        do
            : 
                
            FNAME="D${d}K-T${t}-I${i}K"

            echo -e "\nStep 1: Generating dataset: $FNAME"

            ./repositories/ibm_generator/seq_data_generator lit -ntrans $d -nitems $i -tlen $t -ascii -fname "$DATA_DIR/$FNAME"
            python3 ./src/clean.py "$DATA_DIR/$FNAME.data"
            python3 ./src/calc_statistics.py "$DATA_DIR/$FNAME.data.cl" >> "$DATA_DIR/$FNAME.pat"


            echo -e "Step 2: Intermediary Clean-up"
            rm $DATA_DIR/**.data
            mv "$DATA_DIR/$FNAME.data.cl" "$DATA_DIR/$FNAME.dat"


            for s in "${MIN_SUP[@]}"
            do
                : 
                echo -e "Step 3: Perform experiment (Support: $s)"
                echo -e "Dataset: $FNAME\nRepetitions: $REPS\nMinimum Support: $s\n\n" >> "$RESULT_DIR/$FNAME-s$s.out"
                
                for ((i=1; i <=$REPS; i+=1))
                do 
                    :
                    echo -e "Repetition $i/$REPS"
                    echo -e "\n\nRepetition: $i / $REPS" >> "$RESULT_DIR/$FNAME-s$s.out"

                    ./repositories/gminer/GMiner -i "$DATA_DIR/$FNAME.dat" -o "$RESULT_DIR/$FNAME.dat" -s $s -w 1 >> "$RESULT_DIR/$FNAME-s$s.out"
                done

                echo -e "Step 4: Final clean-up"
                echo -e "\n\nGenerated Pattern File:\n" >> "$RESULT_DIR/$FNAME-s$s.out"
                cat "$DATA_DIR/$FNAME.pat" >> "$RESULT_DIR/$FNAME-s$s.out"
            done 
        done

        rm "$RESULT_DIR/$FNAME.dat"
        rm "$DATA_DIR/$FNAME.pat"
    done
done 

echo -e "Step 5: Done!\n"
