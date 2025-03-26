
# Como o processamento no Databricks Community Edition é limitado a 1 h,
# baixar os arquivos e dezipar dentro da plataforma estava estourando o limite.
# Será necessário baixar os arquivos offline, na máquina local,
# subir para um bucket e de lá o Databricks ler os dados

if ! [ -d ./tmp/ ]; then
    mkdir ./tmp/
fi

echo "Limpando arquivos temporários anteriores"
rm -f ./tmp/Municipios*
rm -rfd ./tmp/extracted_files/mun/ 

echo "Criando diretórios se necessário"
if ! [ -d ./tmp/extracted_files/ ]; then
    mkdir ./tmp/extracted_files/
fi

if ! [ -d ./tmp/extracted_files/mun/ ]; then
    mkdir ./tmp/extracted_files/mun/
fi


cd ./tmp/
MES_ATUAL="2025-02"
# baixar arquivo Municipios.zip e extrair o conteúdo
FILENAME="Municipios.zip"
URL="https://arquivos.receitafederal.gov.br/dados/cnpj/dados_abertos_cnpj/${MES_ATUAL}/${FILENAME}" 

echo "===> Baixando e extraindo o arquivo de ${URL} ..."
wget $URL 
    
unzip $FILENAME -d extracted_files/mun/

echo "======> Extraiu zip na pasta extracted_files/mun/"

echo "Conteúdo final da pasta extracted_files/mun/"
ls extracted_files/mun/
