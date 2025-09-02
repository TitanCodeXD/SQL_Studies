/* 1 Quais clientes mais perderam pontos por Lover?
 */
/*SELECT t1.IdCliente,
        sum(t1.QtdePontos) AS TotalPontos,
        t1.IdTransacao,
        t2.IdProduto,
        t3.DescProduto,
        t3.DescCateogriaProduto

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.DescCateogriaProduto = 'lovers'

GROUP BY t1.IdCliente

ORDER BY TotalPontos ASC

LIMIT 5;*/



/* 2 Quais clientes assinaram a lista de presença no dia 2025/08/25?
 */ 
/*SELECT *

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE substring(t1.DtCriacao, 1, 10) = '2025-08-25'
AND t3.DescProduto = 'Lista de presença';*/





/* 3 Do início ao fim do nosso curso (2025/08/25 a 2025/08/29), quantos clientes assinaram a lista de presença?
*/

/*SELECT count(DISTINCT t1.IdCliente) AS TotalClientes

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE substring(t1.DtCriacao, 1, 10) >= '2025-08-25'
AND substring(t1.DtCriacao, 1, 10) < '2025-08-30'
AND t3.DescProduto = 'Lista de presença';*/

/* 4 Clientes mais antigos, tem mais frequência de transação? */
/*Exportar para CSV e fazer um gráfico lá*/
SELECT t1.IdCliente,
       julianday('now') - julianday(substr(t1.DtCriacao,1, 19)) AS DiasComoCliente,
        count(t2.IdTransacao) AS TotalTransacoes
        

FROM clientes AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente

GROUP BY t1.IdCliente, DiasComoCliente










/* 5 Quantidade de transações Acumuladas ao longo do tempo?
*/   








/* 6 */






/* 7 */






/* 8 */





/* 9 */

