-- arquivo utilitário para dar uma olhada nos arquivos, entender como as linhas estão vindo preenchidas

-- carrega todos os dados de arquivos de um determinado diretório
data = LOAD 'tmp/extracted_files/estab/*' USING TextLoader() AS (line:chararray);

-- filtrar linhas com string desejada
filtered_data = FILTER data BY INDEXOF(line, 'INCORPORADORA E CONSTRUTORA SPE LTDA') >= 0;

-- exibir resultado
DUMP filtered_data;