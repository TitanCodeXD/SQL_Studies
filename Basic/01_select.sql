/* Select */
/*SELECT 'Olá Mundo!'*/ 

/*  Select tudo de alguma ENTIDADE*/
/*SELECT * FROM clientes;*/

/* */
SELECT 5*3;

/* Select apenas DOIS da entidade CLIENTES*/
SELECT idCliente, QtdePontos 
FROM clientes
LIMIT 10;

SELECT idCliente, DtCriacao
FROM clientes;