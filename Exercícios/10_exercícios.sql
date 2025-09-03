/*Window Function, Quantidade de usuarios */

WITH tb_clientes_dia AS (

SELECT substr(DtCriacao,1,10) AS Dia,
       count(DISTINCT IdCliente) AS QntdUsuarios
       

FROM clientes

GROUP BY Dia

),

tb_acumulado AS (

SELECT *,
       sum(QntdUsuarios) OVER (ORDER BY Dia) AS QntdUsuariosAcumulados

FROM tb_clientes_dia

)

SELECT *

FROM tb_acumulado

ORDER BY Dia;


