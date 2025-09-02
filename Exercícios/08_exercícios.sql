/*Dia com maior engajamento de cada aluno*/


WITH tb_alunos_dia1 AS (

SELECT *
FROM transacoes
WHERE substring(DtCriacao, 1, 10) = '2025-08-25'

),

tb_dia_cliente AS (
SELECT t1.IdCliente,
       substr(t2.DtCriacao,1, 10) AS Dia,
       count(*) AS QntdInterações

FROM tb_alunos_dia1 AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
AND substring(t2.DtCriacao, 1, 10) >= '2025-08-25'
AND substring(t2.DtCriacao, 1, 10) < '2025-08-30'

GROUP BY t1.IdCliente, substr(t2.DtCriacao,1, 10)

ORDER BY t1.IdCliente, Dia

),

/*Windown Function*/
tb_rn AS (
SELECT *,
       row_number() OVER (PARTITION BY IdCliente ORDER BY QntdInterações DESC, Dia) AS rn

FROM tb_dia_cliente
)

SELECT *

FROM tb_rn

WHERE rn = 1


/*

tb_max_interação AS (

SELECT IdCliente,
    max(QntdInterações) AS MaiorEngajamento,


FROM tb_dia_cliente AS t1

GROUP BY IdCliente

)

SELECT t1.IdCliente,
       t2.Dia

FROM tb_max_interação AS t1

LEFT JOIN tb_dia_cliente AS t2
ON t1.IdCliente = t2.IdCliente
AND t1.MaiorEngajamento = t2.QntdInterações

ORDER BY t1.IdCliente, t2.Dia;
*/