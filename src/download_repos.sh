
rm -r -f ./repositories
mkdir ./repositories

echo -e "\nCloning GMiner"
git clone --progress https://github.com/coderbond007/GMiner.git ./repositories/gminer

echo -e "\n Cloning GFPG-LLMA"
git clone --progress https://github.com/cofiiwu/GFPG-LLMA.git ./repositories/gfpg-llma

echo -e "\nDownloading IBM Quest Data Generator"
curl -o ./repositories/ibm_generator.zip https://www.philippe-fournier-viger.com/spmf/datasets/IBM_Quest_data_generator.zip
unzip ./repositories/ibm_generator.zip -d ./repositories/ibm_generator
rm ./repositories/ibm_generator.zip

echo -e "\nDone!"
