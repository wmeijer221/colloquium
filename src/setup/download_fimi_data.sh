
mkdir ./datasets
mkdir ./datasets/fimi

URL=http://fimi.uantwerpen.be/data/
DIR=./datasets/fimi

datasets=(T10I4D100K.dat T40I10D100K.dat chess.dat connect.dat mushroom.dat pumsb.dat pumsb_star.dat kosarak.dat retail.dat accidents.dat webdocs.dat.gz)

for set in "${datasets[@]}"
do 
    : 
    echo -e "\nDownloading $set..."
    curl -X GET $URL$set >> $DIR/$set
done

echo -e "\nUnzipping webdocs..."
gunzip $DIR/webdocs.dat
