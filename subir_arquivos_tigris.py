import os
from dotenv import load_dotenv 
import boto3
from botocore.client import Config 

load_dotenv() # carregar env vars do arquivo .env
print("Variáveis de ambiente carregadas")

# criando cliente S3 para acessar dados no Tigris
svc = boto3.client(
    's3',
    endpoint_url='https://fly.storage.tigris.dev',
    config=Config(s3={'addressing_style': 'virtual'}),
)

print("Conectado no Tigris (S3-like storage)")


try:
    bucket_name = "pos-pucrio-dados"
    base_dir = 'mvp_sprint_eng_dados/'
    # para cada dir com arquivos extraídos, fazer o upload de todos os files para o bucket alvo
    for d in ['emp/', 'estab/', 'mot/', 'mun/', 'cnae/', 'nat/']:
      directory = os.path.join('tmp/extracted_files/', d)
      print(f"Processando diretório local {directory}")
      for filename in sorted(os.listdir(directory)):
          if os.path.isfile(os.path.join(directory, filename)):
              local_path = os.path.join(directory, filename)
              tigris_key = os.path.join(base_dir, d, filename)

              # Upload the file
              print(f"Subindo arquivo {filename} para s3a://{bucket_name}/{tigris_key} ...")
              svc.upload_file(local_path, bucket_name, tigris_key)
              print(f"Subiu")
except Exception as e:
    print(f"Erro: {e}")
