WITH tb_cliente_dia AS (

SELECT IdCliente,
    substr(DtCriacao, 1, 10) AS Dia,
    count(DISTINCT Idtransacao) AS QntdTransacoes

FROM transacoes

WHERE DtCriacao >= '2025-08-25' 
AND DtCriacao < '2025-08-30'

GROUP BY IdCliente, substr(DtCriacao, 1, 10)

),

tb_lag AS (

SELECT *,
       sum(QntdTransacoes) OVER (PARTITION BY IdCliente ORDER BY Dia) AS SomaAcumulada,
       lag(QntdTransacoes) OVER (PARTITION BY IdCliente ORDER BY Dia) AS lag

FROM tb_cliente_dia

)

SELECT *,
    1.* QntdTransacoes / lag AS VariacaoPercentual


FROM tb_lag
