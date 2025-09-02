/* 1 Categoria de produtos mais vendidos */

SELECT t1.*,
       t2.DescCateogriaProduto,
       count(DISTINCT t1.Idtransacao) AS TotalVendas

FROM transacao_produto AS t1

LEFT JOIN produtos AS t2
ON t1.IdProduto = t2.IdProduto

GROUP BY t2.DescCateogriaProduto

ORDER BY TotalVendas DESC;

/* 2 Em 2024, quantas transações de lovers tivemos? */
SELECT 
    count(DISTINCT t1.Idtransacao) AS TotalVendas

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.Idtransacao = t2.Idtransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE t1.DtCriacao >='2024-01-01' 
AND t1.DtCriacao < '2025-01-01'
AND t3.DescCateogriaProduto = 'lovers';

/* 3 Qual mes tivemos mais lista de presença assinada? */
SELECT 
       substring(t1.DtCriacao, 1, 7) AS Mes,
         count(DISTINCT t1.Idtransacao) AS TotalVendas

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

WHERE DescProduto = 'Lista de presença'

GROUP BY Mes

ORDER BY TotalVendas DESC;


