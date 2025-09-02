/* 1 Quanto clientes tem email cadastrado? */

SELECT sum(FlEmail) AS TotalClientesComEmail

FROM clientes;

-- ou --
SELECT count(*) AS TotalClientesComEmail

FROM clientes

WHERE FlEmail = 1;


/* 2 Qual cliente juntou mais pontos positivos em 2025-05 */
SELECT IdCliente,
        sum(QtdePontos) AS TotalPontos

FROM transacoes

WHERE QtdePontos > 0 AND
      DtCriacao BETWEEN '2025-05-01' AND '2025-06-01'

GROUP BY IdCliente

ORDER BY TotalPontos DESC

LIMIT 1;


/* 3 Qual cliente fez mais transações em 2024? */
SELECT Idcliente,
        count(*),
        count(DISTINCT IdTransacao) AS TotalTransacoes

FROM transacoes

WHERE DtCriacao BETWEEN '2024-01-01' AND '2025-01-01'

GROUP BY IdCliente

ORDER BY TotalTransacoes DESC

LIMIT 1;


/* 4 Quantos produtos sao de rpg? */
SELECT count(*) AS TotalProdutosRPG

FROM produtos

WHERE DescCateogriaProduto = 'rpg';


-- ou, agrupando todos produtos já, fica mais facil para agrupar todos ja --
SELECT DescCateogriaProduto,
    count(*) AS TotalPorCategoria

FROM produtos

GROUP BY DescCateogriaProduto;



/* 5 Valor médio de pontos positivos por dia */
SELECT sum(QtdePontos) AS TotalPontos,
        count(DISTINCT substr(DtCriacao, 1, 10)) AS QntdeDiasUnicos,
        sum(QtdePontos) / count(DISTINCT substr(DtCriacao, 1, 10)) AS MediaPorDia


FROM transacoes

WHERE QtdePontos > 0;


/* 6 Dia da semana que mais tem pedidos em 2025*/
SELECT  strftime('%w', dateTime(substr(DtCriacao, 1, 10))) AS DiaSemana,
        count(IdTransacao) AS TotalPedidos


FROM transacoes


WHERE DtCriacao BETWEEN '2025-01-01' AND '2026-01-01'

GROUP BY 1

ORDER BY TotalPedidos DESC;





/* 7 Qual produto mais transacionado? */
SELECT IdProduto,
        count(IdProduto) AS TotalVendas


FROM transacao_produto

GROUP BY IdProduto

ORDER BY TotalVendas DESC

LIMIT 1;


/* 8 Produto com mais pontos transacionados */
SELECT IdProduto,
        sum(VlProduto) AS TotalPontos

FROM transacao_produto

GROUP BY IdProduto

ORDER BY TotalPontos DESC;

