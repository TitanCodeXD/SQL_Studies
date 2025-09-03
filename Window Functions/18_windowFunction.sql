/*Qual a média de dias para os clientes voltarem?*/

WITH tb_cliente_dia AS (

SELECT DISTINCT IdCliente,
       substr(DtCriacao, 1, 10) AS Dia

FROM transacoes

WHERE substr(DtCriacao, 1, 4) = '2025'

ORDER BY IdCliente, Dia

),

tb_lag AS (

SELECT *, 
      lag(Dia) OVER (PARTITION BY IdCliente ORDER BY Dia) AS DiaAnterior

FROM tb_cliente_dia

),

tb_diferença AS (

SELECT *,
        julianday(Dia) - julianday(DiaAnterior) AS DiferençaDias

FROM tb_lag

),

tb_avg_cliente AS (

SELECT IdCliente,
       avg(DiferençaDias) AS AvgDia

FROM tb_diferença
)

SELECT avg(AvgDia) AS MediaDias

FROM tb_avg_cliente
