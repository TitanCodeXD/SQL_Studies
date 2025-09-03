WITH tb_diario AS (

SELECT IdTransacao,
        substr(DtCriacao, 1, 10) AS Dia,
        count(DISTINCT IdTransacao) AS QntdTransações
       

FROM transacoes

GROUP BY substr(DtCriacao, 1, 10)
ORDER BY substr(DtCriacao, 1, 10)

),

tb_acumulado AS (

SELECT *,
        sum(QntdTransações) OVER (ORDER BY Dia) AS QntdTransaçõesAcumuladas

FROM tb_diario

)

INSERT INTO relatorio_diario /*Pode ficar repetindo*/

SELECT * 

FROM tb_acumulado

WHERE QntdTransaçõesAcumuladas > 100000
ORDER BY QntdTransaçõesAcumuladas
LIMIT 1;


SELECT * FROM relatorio_diario