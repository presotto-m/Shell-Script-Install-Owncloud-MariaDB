# Shell-Script-Install-Owncloud-MariaDB
Shell Scritp para instalação Owncloud com MariaDB em Debian 11

**Importante:** este é um trabalho em andamento.

**Ainda mais importante:** Se você realmente planeja usar isso, não se esqueça de editar os arquivos de configuração de acordo com suas necessidades (arquivos de serviço, arquivos de configuração YAML, etc.). Os arquivos de configuração fornecidos aqui são apenas arquivos genéricos.

Este script baixa os arquivos no diretório atual. Você poderia mudar isso.

Quaisquer sugestões e contribuições são bem-vindas.

# Como usar isso?

* chmod +x owncloud.sh

* sudo ./owncloud.sh

## Instalação completa

A instalação completa instalará o seguinte:

* Owncloud

* MariaDB

# Acesso

* http://localhost/
* http://seu-host-name/

* Basta criar um usuario e senha no momento do login, exemplo: User (Admin) senha (Admin)

# Acesso banco de dados de acordo com a config disponibilizada no script

* Database user: owncloud
* Database name: owncloud
* Database password: owndbpass
* Lembre-se de alterá-las
* Porta de acesso padrão MariaDB: 3306
