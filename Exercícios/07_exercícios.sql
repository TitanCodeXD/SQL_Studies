/**/

WITH tb_transacoes_janeiro AS (

SELECT *

FROM transacoes

WHERE DtCriacao >= '2025-01-01'
AND DtCriacao < '2025-02-01'

)

SELECT count(DISTINCT t1.IdCliente) AS ClientesJaneiro,
       count(DISTINCT t2.IdCliente) AS ClientesQueVoltaram

FROM tb_transacoes_janeiro AS t1

LEFT JOIN transacoes AS t2
ON t1.IdCliente = t2.IdCliente
AND t2.DtCriacao >= '2025-08-25'
AND t2.DtCriacao < '2025-08-30';
