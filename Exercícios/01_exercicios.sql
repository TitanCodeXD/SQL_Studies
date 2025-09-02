/* 01 */
SELECT *
FROM transacoes
WHERE QtdePontos = 1;


/* 02  Pegando só os fins de semana */
SELECT IdCliente,

        DtCriacao,

        strftime('%w', dateTime(substr(DtCriacao, 1, 19))) AS FimDeSemana

FROM clientes

WHERE FimDeSemana IN ('0', '6');


/* 03 */
SELECT *
FROM clientes
WHERE QtdePontos = 0;

/* 04 */
SELECT *
FROM clientes
WHERE QtdePontos >= 100 AND
QtdePontos <= 200;


/* 05 */
SELECT *
FROM produtos
WHERE DescProduto LIKE 'Venda de%'; 


/* 06 */
SELECT *
FROM produtos
WHERE DescProduto LIKE '%Lover'; 

/* 07 */
SELECT *
FROM produtos
WHERE DescProduto LIKE '%chapéu%'; 

/* 08 */
SELECT *

FROM transacao_produto

WHERE IdProduto = 15

/* 09 Listar todas as transações adicionando 
uma coluna nova sinalizando “alto”, 
“médio” e “baixo” para o valor dos pontos 
[<10 ; <500; >=500]
*/

SELECT Idtransacao,
        QtdePontos,

       CASE 
            WHEN QtdePontos < 10 THEN 'baixo'
            WHEN QtdePontos >= 10 AND QtdePontos < 500 THEN 'médio'
            ELSE 'alto'
       END AS CategoriaPontos

FROM transacoes

ORDER BY QtdePontos DESC;
