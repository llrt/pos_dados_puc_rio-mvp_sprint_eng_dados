# MVP da Sprint Engenharia de Dados da pós Ciência de Dados & Analytics na PUC Rio

Projeto criado como MVP para a Sprint de Engenharia de Dados da pós de Ciência de Dados & Analytics na PUC Rio.

O Projeto foca em criar uma base de dados que possa ser utilizado para pesquisas de mercado para criação de novas empresas ou lançamentos de produtos, utilizando-se como ponto de partida a base pública de empresas da RFB (QSA).

Bases utilizadas:
- QSA - Receita Federal do Brasil (RFB):
  - Dados de empresas
  - Dados de estabelecimentos
  - Tabelas de domínio (CNAEs, municípios, naturezas jurídicas, motivos de situação)
- Base dos Dados (https://basedosdados.org/):
  - CNAEs
  - Municípios


Plataforma de dados utilizada: Databricks Community Edition


Notebooks:

- 0 - Definições Iniciais: 
> Apresenta as definições iniciais, e.g. o problema que se deseja resolver, as perguntas de negócio a serem respondidas, as bases de dados utilizadas, etc
> URL Databricks pública: https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/1442342657537942/4816729637231441/latest.html 

- 1 - Coleta e Carga de Dados:
> Inclui o pipeline para coleta e carga de dados crus no Spark
> OBS: como as bases de dados da RFB vem zipadas e são muito grandes (mais de 15 GB) e o Databricks Community Edition limita o tempo máximo de processamento do cluster recém alocado, não estava sendo possível incluir todo o processo de coleta e carga no próprio notebook. A solução foi previamente baixar e dezipar localmente os dados (ver scripts *.sh neste repositório) e fazer o upload dos dados no serviço S3-like chamado [Tigris](https://www.tigrisdata.com/) . O notebook então processa os dados já inclusos nos buckets S3-like, continuando o processo a partir dali.
> URL Databricks pública: https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/362263227772676/4816729637231441/latest.html


- 2.* - Qualidade dos Dados:
> Inclui as análises de qualidade dos dados das bases cruas. Por questões de limitação de tamanho máximo de notebook exportável no Databricks Community Edition, esta parte foi dividida em vários notebooks, cada pedaço focando em um conjunto de bases/tabelas
 dali.
> URL Databricks pública:
> > - https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/859199491543184/4816729637231441/latest.html
> > - https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/1219889015366514/4816729637231441/latest.html
> > - https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/3126307248776606/4816729637231441/latest.html
> > - https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/3126307248776668/4816729637231441/latest.html


- 3 - Modelo de Dados:
> Inclui o processamento necessário para criação do modelo de dados criado para resolução do problema posto. Também inclui a documentação (catálogo) das bases de dados criadas no modelo.
> URL Databricks pública: https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/383385470364597/4816729637231441/latest.html

- 4 - Análise dos Dados:
> Aqui é onde se faz a análise de dados e se busca resolver as perguntas de negócio do problema posto, apresentando o raciocínio passo a passo e a conclusão final
> URL Databricks pública: https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/877524467196870/4816729637231441/latest.html


- 5 - Autoavaliação:
> Este último script apresenta uma autoavaliação sobre o trabalho todo, as dificuldades/desafios encontrados, sugestão de trabalhos futuros e agradecimentos
> URL Databricks pública: https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/819797422142962/4816729637231441/latest.html


Arquivos auxiliares:

- baixar_dados_*.sh:
> Estes scripts Shell foram utilizados para baixar e dezipar localmente (fora da nuvem da Databricks) os dados da RFB

- subir_arquivos_tigris.py:
> Este script Python foi utilizado para subir os dados crus baixados localmente (fora da nuvem da Databricks) para o serviço S3-like do Tigris

- grep.pig:
> Este script Pig foi utilizado para buscar por determinadas linhas nos arquivos crus e identificar eventuais problemas de caracteres especiais nos campos, ajudando a definir a forma certa de importar algumas bases. O output do script em console é governado pelo arquivo log4j.properties (o Apache Pig foi implementado em Java originalmente)

- \#\# Reconstruir tabelas Spark:
> Este notebook bônus apresenta um script que pode ser utilizado para recriar tabelas Spark a partir dos arquivos delta armazenados no dbfs, contornando um problema do Databricks Community Edition onde todas as tabelas Spark (na verdade apenas seus metadados na Hive Metastore) são perdidos quando o cluster é desligado entre uma sessão e outra
> URL Databricks pública: https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3708345446877627/1526718537246742/4816729637231441/latest.html