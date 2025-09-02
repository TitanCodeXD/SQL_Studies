WITH tb_sumario_dias AS (

SELECT substr(DtCriacao, 1, 10) AS Dia,
       count(DISTINCT Idtransacao) AS QntdTransacoes

FROM transacoes

WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'

GROUP BY substr(DtCriacao, 1, 10)

)

/* Soma Acumulada */
SELECT *,
        sum(QntdTransacoes) OVER (ORDER BY Dia) AS SomaAcumulada

FROM tb_sumario_dias