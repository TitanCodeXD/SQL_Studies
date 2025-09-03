/*Soma de todos pontos que rodaram no mes, somando todos clientes */
SELECT sum(QtdePontos) AS TotalPontos 

FROM transacoes

WHERE DtCriacao BETWEEN '2025-07-01' AND '2025-08-01'
AND QtdePontos > 0;


/**/
SELECT sum(QtdePontos),
        sum(CASE 
            WHEN QtdePontos > 0 THEN QtdePontos
        END) AS QtdePontosPositivos,

        sum(CASE 
            WHEN QtdePontos <= 0 THEN QtdePontos
        END) AS QtdePontosNegativos,

        count(CASE 
            WHEN QtdePontos > 0 THEN QtdePontos
        END) AS QtdeTransacoesPositivas,

        count(CASE 
            WHEN QtdePontos < 0 THEN QtdePontos
        END) AS QtdeTransacoesNegativas

FROM transacoes

WHERE DtCriacao BETWEEN '2025-07-01' AND '2025-08-01';