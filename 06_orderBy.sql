SELECT IdCliente, 
    QtdePontos,
    ROW_NUMBER() OVER (ORDER BY QtdePontos DESC) AS RankingPontos

FROM clientes

ORDER BY QtdePontos DESC

LIMIT 10;


-- Ordenar por data --

SELECT * 

FROM clientes

WHERE FlTwitch = 1

ORDER BY DtCriacao, QtdePontos DESC;

