/* Achar os produtos com resgatar ponei (15)*/

/*SELECT *

FROM transacao_produto AS t1

WHERE t1.IdProduto IN (
    SELECT IdProduto
    FROM produtos
    WHERE DescProduto = 'Resgatar Ponei');*/


/**/
/*SELECT count(DISTINCT IdCliente) AS TotalClientes

FROM transacoes

WHERE IdCliente IN (

SELECT DISTINCT IdCliente
FROM transacoes  
WHERE substring(DtCriacao, 1, 10) = '2025-08-25')

AND substring(DtCriacao, 1, 10) = '2025-08-24';*/

SELECT *

FROM (
SELECT *
FROM transacoes
WHERE DtCriacao >= '2025-01-01'
)

WHERE DtCriacao < '2026-07-01';