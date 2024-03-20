AProjeto: GerEmp – Gerenciador Empresarial
===================
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/d95826f7-4d05-4145-8a27-b64c4a2809d2)

# Objetivo
O objetivo deste desafio é avaliar as competências técnicas.

# Introdução
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/8be63be9-a255-4c2e-99d4-d4649d218179)

#  Diagrama de Pacotes
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/edeff5f5-b310-425c-992b-5a98eafe8771)

#  Firebird 
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/5e687298-e7a2-4518-a682-68b1c1541c12)

   Versão : 2.5.9
<br>

#  Diretório
Um diretório para os arquivos será criado em C:\GerEmp, o qual incluirá uma pasta 'DADOS' contendo o banco de dados DADOS.fdb, e uma pasta 'exe' contendo o executável e a DLL de conexão.
<br>![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/c1e8415e-e149-4db3-b4ae-07dff799600e)
<br>

#  Diagrama do Banco de Dados
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/d439e580-3859-4df4-b888-94d37c052cce)
<br>

#  Login
"O sistema oferece a funcionalidade de login, permitindo o acesso por meio do usuário padrão com as seguintes credenciais:
<br>
Login: ADMIN
<br>
Senha: ADMIN"
<br>
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/4add352e-9962-4df8-a263-e560dcf90a17)


#  Interface
"O usuário terá uma interface que permite interagir com o menu lateral para acessar suas respectivas funcionalidades."
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/a316c805-0dc4-4729-a188-51a0a6f20a5e)


#  Pesquisa
Cada tela do sistema inclui um formulário de pesquisa, onde estão disponíveis as condições e campos de busca.
<br>
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/c2bcf1db-b177-4f39-a51a-3235cc09a17c)
<br>
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/7d487192-4f1c-4b87-824e-f1159d80cd64)
<br>
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/9052248d-374e-46e0-9011-9466c0e18531)
<br>

#  Cadastro de Pessoa
No cadastro de pessoa, é possível registrar indivíduos com os seguintes campos: nome, logradouro, bairro, município, estado, número, complemento, tipo (pessoa física ou jurídica), CPF/CNPJ, sexo e relação (cliente, fornecedor ou ambos).
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/e6ad9b78-657e-478f-9e5b-0afe41e15f36)
<br>
Além disso, também é possível cadastrar o telefone da pessoa.
<br>
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/69558e05-6b0c-4a8f-9c1b-360ef8e90ead)
<br>
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/b14b8386-b6c0-4091-b852-c47d2ce0fe4f)


#  Cadastro de Produto
No cadastro de produtos, é possível registrar itens com os seguintes campos: nome, preço promocional, preço regular, estoque, preço da última compra e estoque para a próxima venda (PVN). Esses campos serão calculados automaticamente na tela de pedido de compra e pedido de venda.
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/669eb0da-dbc8-4367-8946-1de0266da0cb)

#  Cadastro de Úsuarios
No cadastro de usuários, é possível registrar os usuários de acesso ao sistema, incluindo nome, login e senha. Além disso, há a possibilidade de bloquear os usuários quando necessário.
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/dc06bd30-c975-4ea7-ae71-2c04e65616ad)

#  Cadastro de Pedido de Venda
No cadastro de pedido de venda, é possível informar o cliente e adicionar observações relevantes ao pedido.
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/3a79ffb5-a8ff-4d54-94ad-11231f46fc71)
<br>
Na aba de produtos do pedido de venda, é possível selecionar os produtos que farão parte do pedido, informando o código, nome e valor de cada um. 
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/4e390332-e7c7-436c-816a-78bdd9364058)
<br>
Após a conclusão do pedido, o sistema realizará automaticamente a baixa ou estorno no estoque dos produtos selecionados.
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/a0d0ee7c-d799-4588-af24-4c0b53bde513)

#  Cadastro de Pedido de Compra 
No cadastro de pedido de compra, é possível informar o fornecedor e adicionar observações pertinentes ao pedido, seguindo a mesma lógica do pedido de venda.
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/b0cf8ed1-12a4-4ff6-880e-acbc9e4f0a98)
<br>
Na aba de produtos do pedido de compra, você pode informar quais produtos farão parte do pedido, incluindo o código, nome e valor de cada um.
![image](https://github.com/lucasdefreitasroberto/GerEmp-Gerenciador-Empresarial/assets/68399974/34cd61ec-74e6-4b4f-b325-c48e7bb791c8)



