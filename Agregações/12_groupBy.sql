SELECT IdProduto,
        count(*)

FROM transacao_produto

GROUP BY IdProduto;

/*Cliente que mais fez ponto em julho*/
SELECT IdCliente,
        sum(QtdePontos) AS TotalPontos

FROM transacoes

WHERE DtCriacao BETWEEN '2025-07-01' AND '2025-08-01'

GROUP BY IdCliente

HAVING TotalPontos >= 4000 /*Sempre após o where, é um filtro após agregação, é o 'where do group by'*/

ORDER BY TotalPontos DESC

LIMIT 10;
