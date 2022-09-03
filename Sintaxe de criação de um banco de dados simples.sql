
/*

CATEGORIA DE COMANDO PARA SE ENCONTRAR EM UM BANCO DE DADOS 

DML - DATA MANIPULATION LANGUAGE -> COMANDO INSERT/SELECT/UPDATE
DDL - DATA DEFINITION LANGUAGE -> TIPO DE DADO: CREATE TABLE();, ALTER TABLE 
DCL - DATA CONTROL LANGUAGE -> 
TCL - TRANSACTION CONTROL LANGUAGE  

*/


/*

Relatório geral

utilize primeiramente o comando desc para AS tabelas

use o comando:


*/



/*CRIANDO BANCO*/
CREATE DATABASE DADOS_DE_CLIENTES;

/*USANDO BANCO*/
USE DADOS_DE_CLIENTES;

/*CRIANDO TABELA CLIENTE*/
CREATE TABLE CLIENTE (
IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
NOME VARCHAR (50) NOT NULL,
SEXO ENUM ('M', 'F'),
EMAIL VARCHAR (50),
CPF VARCHAR (14)
);

INSERT INTO CLIENTE VALUES (NULL, 'Guilherme da Silva Pessoa Lucas', 'M', 'forcecell954@gmail.com', '00000000001');
INSERT INTO CLIENTE VALUES (NULL, 'Luiz Faria Santos', 'M', 'luizfaria@gmail.com', '00000000002');
INSERT INTO CLIENTE VALUES (NULL, 'Agatha Thainá da Silva', 'F', 'Agathasilva@gmail.com', '00000000003');
INSERT INTO CLIENTE VALUES (NULL, 'Alexandro Pinto Assunção', 'M', NULL, '00000000004');






/*CRIANDO TABELA ENDERECO*/
CREATE TABLE ENDERECO (
IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
RUA VARCHAR (50) NOT NULL,
BAIRRO VARCHAR (25) NOT NULL,
CIDADE VARCHAR (25) NOT NULL,
N_CASA VARCHAR (5) NOT NULL, 
ESTADO CHAR (2) NOT NULL
);

INSERT INTO ENDERECO VALUES (NULL, 'Rua padre josé ribeiro', 'Jardim Tupã', 'Barueri', '125', 'SP');
INSERT INTO ENDERECO VALUES (NULL, 'Jacarai Perreira', 'Jardim do Edem', 'Franca', '13', 'SP');
INSERT INTO ENDERECO VALUES (NULL, 'Avenida São Paulo', 'Aristn 1', 'Carapicuiba', '233', 'SP');
INSERT INTO ENDERECO VALUES (NULL, 'Ribeirinho de São Paulo', 'Santa Cruz', 'Claraval', '9', 'MG');









/* CRIANDO TABELA TELEFONE */
CREATE TABLE TELEFONE (
IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
TIPO ENUM ('CEL', 'RES', 'COM'),
NUMERO CHAR (13)
);

INSERT INTO TELEFONE VALUES (NULL, 'CEL', '5511000000001');
INSERT INTO TELEFONE VALUES (NULL, 'RES', '5511000000002');
INSERT INTO TELEFONE VALUES (NULL, 'COM', '5511000000003');
INSERT INTO TELEFONE VALUES (NULL, 'CEL', '5511000000004');










/* SELECIONANDO AS 3 TABELAS POR ID */
SELECT IDCLIENTE, NOME, SEXO, EMAIL, CPF, RUA, BAIRRO, CIDADE, ESTADO, N_CASA, TIPO, NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO
ON IDCLIENTE = IDENDERECO
INNER JOIN TELEFONE 
ON IDTELEFONE = IDENDERECO;





/* SELECIONAR POR ID */
SELECT IDCLIENTE, NOME, SEXO, EMAIL, CPF, RUA, BAIRRO, CIDADE, ESTADO, N_CASA, TIPO, NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO
ON IDCLIENTE = IDENDERECO
INNER JOIN TELEFONE 
ON IDTELEFONE = IDENDERECO 
WHERE IDCLIENTE = 1;





/* ATUALIZAR CAMPO BAIRRO */
UPDATE ENDERECO
SET BAIRRO = 'Jardim do Edem'
WHERE IDENDERECO=2;





/* ATUALIZANDO MAIS DE UMA LINHA AO MESMO TEMPO */
UPDATE ENDERECO
SET BAIRRO = 'Ariston 2'
WHERE IDENDERECO IN (1,2,3);




/* QUANTIDADE DE PESSOAS DE CADA SEXO */
SELECT COUNT(*) AS QUANTIDADE_POR_SEXO, SEXO
FROM CLIENTE
GROUP BY SEXO;
















/*  
                                                                               FUNÇÃO IFNULL
																			   


Podemos criar um bloco de programação que irá retornar determinado valor.

*/

/* SELECIONANDO AS 3 TABELAS POR ID */
SELECT IDCLIENTE, NOME, EMAIL, CIDADE, ESTADO, TIPO, NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO
ON IDCLIENTE = IDENDERECO
INNER JOIN TELEFONE 
ON IDTELEFONE = IDENDERECO;



/*  
criando função IFNULL  
se acaso tiver um valor vazio neste campo retorne '*'
*/
SELECT NOME, 
            IFNULL(EMAIL, '********') AS 'NOME_RELATÓRIO',
			ESTADO, NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON IDCLIENTE = IDENDERECO
INNER JOIN TELEFONE
ON IDTELEFONE = IDENDERECO;



/*VEJA COMO FICOU*/
+---------------------------------+------------------------+--------+---------------+
| NOME                            | NOME_RELATÓRIO         | ESTADO | NUMERO        |
+---------------------------------+------------------------+--------+---------------+
| Guilherme da Silva Pessoa Lucas | forcecell954@gmail.com | SP     | 5511000000001 |
| Luiz Faria Santos               | luizfaria@gmail.com    | SP     | 5511000000002 |
| Agatha Thainá da Silva          | Agathasilva@gmail.com  | SP     | 5511000000003 |
| Alexandro Pinto Assunção        | ********               | MG     | 5511000000004 |
+---------------------------------+------------------------+--------+---------------+























/*  
                                                                                        VIEWS
																				 
																				 
																				 
																				 
																				 

SÃO COMANDOS DE VISUALIZAÇÕES QUE FICAM SALVOS EM NOSSO BANCO

SELECT * FROM NOME_VIW;
*/

/*AO INVÉS DE REPETIR O MESMO COMANDO TODOS OS DIAS PODEMOS FAZER DA SEGUINTE FORMA
1º CRIAR O COMANDO SELECT.
2º CRIAR A VIEW.


VEJA:
*/


/*CRIANDO FUNÇÃO SELECT*/
SELECT IDCLIENTE, 
	NOME, 
	SEXO, 
	EMAIL, 
	CPF, 
	RUA, 
	BAIRRO, 
	CIDADE, 
	ESTADO, 
	N_CASA, 
	TIPO, 
	NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO
ON IDCLIENTE = IDENDERECO
INNER JOIN TELEFONE 
ON IDTELEFONE = IDENDERECO;



/*CRIANDO VIEW*/
CREATE VIEW NOME_VIEW AS 
SELECT IDCLIENTE, 
	NOME, 
	SEXO, 
	EMAIL, 
	CPF, 
	RUA, 
	BAIRRO, 
	CIDADE, 
	ESTADO, 
	N_CASA, 
	TIPO, 
	NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO
ON IDCLIENTE = IDENDERECO
INNER JOIN TELEFONE 
ON IDTELEFONE = IDENDERECO;


/*AGORA BASTA UTILIZAR O COMANDO ABAIXO PARA RETORNAR A VIEW:
SELECT * FROM NOME_VIEW;


RESULTADO:
*/

ysql> SELECT * FROM NOME_VIEW;
+-----------+---------------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+
| IDCLIENTE | NOME                            | SEXO | EMAIL                  | CPF         | RUA                     | BAIRRO         | CIDADE      | ESTADO | N_CASA | TIPO | NUMERO        |
+-----------+---------------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+
|         1 | Guilherme da Silva Pessoa Lucas | M    | forcecell954@gmail.com | 00000000001 | Rua padre josé ribeiro  | Jardim Tupã    | Barueri     | SP     | 125    | CEL  | 5511000000001 |
|         2 | Luiz Faria Santos               | M    | luizfaria@gmail.com    | 00000000002 | Jacarai Perreira        | Jardim do Edem | Franca      | SP     | 13     | RES  | 5511000000002 |
|         3 | Agatha Thainá da Silva          | F    | Agathasilva@gmail.com  | 00000000003 | Avenida São Paulo       | Ariston 2      | Carapicuiba | SP     | 233    | COM  | 5511000000003 |
|         4 | Alexandro Pinto Assunção        | M    | NULL                   | 00000000004 | Ribeirinho de São Paulo | Santa Cruz     | Claraval    | MG     | 9      | CEL  | 5511000000004 |
+-----------+---------------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+




/*  TAMBÉM É POSSIVEL UTILIZAR VIEWS PARA SELECIONAR CAMPOS ESPECIFICOS
VEJA:
*/

SELECT NOME, ESTADO, RUA, N_CASA, CIDADE
FROM NOME_VIEW;

ysql> SELECT NOME, ESTADO, RUA, N_CASA, CIDADE
    -> FROM NOME_VIEW;
+---------------------------------+--------+-------------------------+--------+-------------+
| NOME                            | ESTADO | RUA                     | N_CASA | CIDADE      |
+---------------------------------+--------+-------------------------+--------+-------------+
| Guilherme da Silva Pessoa Lucas | SP     | Rua padre josé ribeiro  | 125    | Barueri     |
| Luiz Faria Santos               | SP     | Jacarai Perreira        | 13     | Franca      |
| Agatha Thainá da Silva          | SP     | Avenida São Paulo       | 233    | Carapicuiba |
| Alexandro Pinto Assunção        | MG     | Ribeirinho de São Paulo | 9      | Claraval    |
+---------------------------------+--------+-------------------------+--------+-------------+








/*                                                              UTILIZANDO CLAUSULAS INSERT, DELETE, UPDATE EM VIWS                        









SE FORMOS UTILIZAR PARA INSERIR NO BANCO IRÁ DAR UM ERRO, CONTUDO PODEMOS USAR PARA DELETAR COLUNAS OU ATUALIZAR.
*/


UPDATE NOME_VIEW SET NOME = 'Guilherme Silva' WHERE NOME = 'Guilherme da Silva Pessoa Lucas';


mysql> select * from nome_view;
+-----------+--------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+
| IDCLIENTE | NOME                     | SEXO | EMAIL                  | CPF         | RUA                     | BAIRRO         | CIDADE      | ESTADO | N_CASA | TIPO | NUMERO        |
+-----------+--------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+
|         1 | Guilherme Silva          | M    | forcecell954@gmail.com | 00000000001 | Rua padre josé ribeiro  | Jardim Tupã    | Barueri     | SP     | 125    | CEL  | 5511000000001 |
|         2 | Luiz Faria Santos        | M    | luizfaria@gmail.com    | 00000000002 | Jacarai Perreira        | Jardim do Edem | Franca      | SP     | 13     | RES  | 5511000000002 |
|         3 | Agatha Thainá da Silva   | F    | Agathasilva@gmail.com  | 00000000003 | Avenida São Paulo       | Ariston 2      | Carapicuiba | SP     | 233    | COM  | 5511000000003 |
|         4 | Alexandro Pinto Assunção | M    | NULL                   | 00000000004 | Ribeirinho de São Paulo | Santa Cruz     | Claraval    | MG     | 9      | CEL  | 5511000000004 |
+-----------+--------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+




/*

DELETANDO INFORMAÇÃO

*/
DELETE FROM NOME_VIEW 
WHERE CPF = '00000000004';













/*                                                                             ORDER BY/ORDENAR POR







o comando order by ordena 
*/

/*  ORDENA A COLUNA IDCLIENTE EM SEQUENCIA  */
SELECT * FROM CLIENTE
ORDER BY IDCLIENTE;

/*  SUPONDO QUE ID SE REPITA E MAIS DE UM CLIENTE VAMOS ORDENAR AS COLUNAS IDCLIENTE E NOME  */
SELECT * FROM CLIENTE
ORDER BY IDCLIENTE, NOME;

/*  É POSSIVEL ORDENAR TANTO EM ASCENDENDE(ASC) QUANTO DESCRESCENTE(DESC)  */
SELECT * FROM CLIENTE
ORDER BY IDCLIENTE DESC;


/*   ORDENANDO UM SELEÇÃO MAIOR - ORDENAR COLUNA NOME  */
SELECT IDCLIENTE, 
	NOME, 
	SEXO, 
	EMAIL, 
	CPF, 
	RUA, 
	BAIRRO, 
	CIDADE, 
	ESTADO, 
	N_CASA, 
	TIPO, 
	NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO
ON IDCLIENTE = IDENDERECO
INNER JOIN TELEFONE 
ON IDTELEFONE = IDENDERECO
ORDER BY NOME;

/*   VEJA QUE TEMOS A PROJEÇÃO DOS NOMES EM ORDEM CRESCENTE   */
+-----------+--------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+
| IDCLIENTE | NOME                     | SEXO | EMAIL                  | CPF         | RUA                     | BAIRRO         | CIDADE      | ESTADO | N_CASA | TIPO | NUMERO        |
+-----------+--------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+
|         3 | Agatha Thainá da Silva   | F    | Agathasilva@gmail.com  | 00000000003 | Avenida São Paulo       | Ariston 2      | Carapicuiba | SP     | 233    | COM  | 5511000000003 |
|         4 | Alexandro Pinto Assunção | M    | NULL                   | 00000000004 | Ribeirinho de São Paulo | Santa Cruz     | Claraval    | MG     | 9      | CEL  | 5511000000004 |
|         1 | Guilherme Silva          | M    | forcecell954@gmail.com | 00000000001 | Rua padre josé ribeiro  | Jardim Tupã    | Barueri     | SP     | 125    | CEL  | 5511000000001 |
|         2 | Luiz Faria Santos        | M    | luizfaria@gmail.com    | 00000000002 | Jacarai Perreira        | Jardim do Edem | Franca      | SP     | 13     | RES  | 5511000000002 |
+-----------+--------------------------+------+------------------------+-------------+-------------------------+----------------+-------------+--------+--------+------+---------------+


EXEMPLO BRMODELO: https://app.brmodeloweb.com/#!/conceptual/630f1c440e3a6f8a660445b5



















/*                                                                                  PROGRAMAÇÃO EM BANCO DE DADOS                                     


Programação em banco de dados se trata de procedimento armazenados no banco.

OBS: Para realizar esse processo devemos trocar o delimitador pois temos um (;) na metade do código:

delimiter $
*/


CREATE PROCEDURE PROCEDURE_CLIENTE ()
BEGIN
	SELECT IDCLIENTE, 
	NOME, 
	SEXO, 
	EMAIL, 
	CPF
FROM CLIENTE 
ORDER BY IDCLIENTE;
END
.


/*  CHAMANDO O PROCEDURE  */

mysql> CALL PROCEDURE_CLIENTE();
+-----------+--------------------------+------+------------------------+-------------+
| IDCLIENTE | NOME                     | SEXO | EMAIL                  | CPF         |
+-----------+--------------------------+------+------------------------+-------------+
|         1 | Guilherme Silva          | M    | forcecell954@gmail.com | 00000000001 |
|         2 | Luiz Faria Santos        | M    | luizfaria@gmail.com    | 00000000002 |
|         3 | Agatha Thainá da Silva   | F    | Agathasilva@gmail.com  | 00000000003 |
|         4 | Alexandro Pinto Assunção | M    | NULL                   | 00000000004 |
+-----------+--------------------------+------+------------------------+-------------+





/*                                                                                     ENCAIXANDO PROCEDURE NO DIA A DIA 



PARA ISSO NÃO ESQUEÇA DE MUDAR O DELIMITADOR, COMANDO> DELIMITER .

*/

/*  SINTAXE  */
CREATE PROCEDURE NOME_PROCEDURE()
BEGIN
	CÓDIGO;
END.





CREATE PROCEDURE DADOS_TELEFONE()
BEGIN
	SELECT * FROM TELEFONE;
END.


/*  OUTRO EXEMPLO  

OBS: note que as entradas no banco foram substituidas por váriaveis NOME, SEXO, EMAIL, CPF.
*/
CREATE PROCEDURE ENTRADA_TB_CLIENTE_NOVO()
BEGIN
	INSERT INTO CLIENTE VALUES (NULL, NOME, SEXO, EMAIL, CPF);
END.



CALL ENTRADA_TB_CLIENTE_NOVO (NULL, 'user teste', 'M', 'Emailteste@gmail.com', '000000teste');




















/*                                                                                       FUNÇÃO DE AGRAÇÃO NUMERICAS 


sintaxe: 
SELECT FUNÇÃO(COLUNA) AS TITULO
FROM TABELA;

*/



/*  MAX - TRAZ O VALOR MAXIMO DE UMA COLUNA  */
mysql> SELECT MAX(N_CASA) AS MAIO_N_DE_CASA
    -> FROM ENDERECO;
+----------------+
| MAIO_N_DE_CASA |
+----------------+
| 9              |
+----------------+

/*  MIN - TRAZ O MENOR VALOR DE UMA COLUNA  */
SELECT MIN(CPF) AS TITULO
FROM CLIENTE;



/*  AVG - TRAZ O VALOR MÉDIO DE UMA COLUNA  */
SELECT AVG(CPF) AS TITULO
FROM CLIENTE;




/*   USANDO VÁRIAS FUNÇÕES AO MESMO TEMPO   */
SELECT MAX(CPF) MAIOR_CPF,
MIN(CPF) MENOR_CPF,
AVG(CPF) MÉDIA_CPF
FROM CLIENTE;

/* PROJEÇÃO */
+-------------+-------------+-----------+
| MAIOR_CPF   | MENOR_CPF   | MÉDIA_CPF |
+-------------+-------------+-----------+
| 00000000004 | 00000000001 |       2.5 |
+-------------+-------------+-----------+



/* TRUNCATE - FUNÇÃO PARA CASAS DECIMAIS */
/* TRUNCATE(FUNÇAÕ(COLUNA), QUANTIDADE_DE_CASAS_DECIMAIS) */

SELECT MAX(CPF) MAIOR_CPF,
TRUNCATE(MIN(CPF),1) MENOR_CPF,
AVG(CPF) MÉDIA_CPF
FROM CLIENTE;




/*  FUNÇÃO SUM - FUNÇÃO PARA SOMAR   */
SELECT SUM(CPF) AS SOMA_CPF
FROM CLIENTE;

/* PROJEÇÃO */
+----------+
| SOMA_CPF |
+----------+
|       10 |
+----------+


/*  Somar cpfs por sexos  */
SELECT SEXO, SUM(CPF) AS SOMA_CPF
FROM CLIENTE
GROUP BY SEXO;

