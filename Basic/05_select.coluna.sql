/**/
SELECT *,
        QtdePontos + 10 AS PontosFuturos
FROM clientes;

-- ou --
SELECT *,
        QtdePontos + 10

FROM clientes;


-- Mais de um --
SELECT QtdePontos,
        QtdePontos + 10 AS MaisPontos,
        QtdePontos - 10 AS MenosPontos
FROM clientes;