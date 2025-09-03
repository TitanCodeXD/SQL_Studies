/*Saldo de pontos acumulados de cada usuário*/

WITH tb_cliente_dia AS (

SELECT  IdCliente,
        substr(DtCriacao,1,10) AS Dia,
        sum(QtdePontos) AS TotalPontos

FROM transacoes

GROUP BY IdCliente, Dia

)

SELECT *,
        sum(TotalPontos) OVER (PARTITION BY IdCliente ORDER BY Dia) AS Saldo

FROM tb_cliente_dia

