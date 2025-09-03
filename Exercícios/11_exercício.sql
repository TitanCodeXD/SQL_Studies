/*Dia mais ativo de cada usuário?*/


WITH tb_dia_cliente AS (

SELECT IdCliente, 
         strftime('%w', substr(DtCriacao, 1, 10)) AS Dia,
         count(DISTINCT IdTransacao) AS QntdTransações
         

FROM transacoes

GROUP BY IdCliente, strftime('%w', substr(DtCriacao, 1, 10))

),

tb_rn AS (

SELECT *,
       CASE
            WHEN Dia = '0' THEN 'Domingo'
            WHEN Dia = '1' THEN 'Segunda-feira'
            WHEN Dia = '2' THEN 'Terça-feira'
            WHEN Dia = '3' THEN 'Quarta-feira'
            WHEN Dia = '4' THEN 'Quinta-feira'
            WHEN Dia = '5' THEN 'Sexta-feira'
            WHEN Dia = '6' THEN 'Sábado'
       END AS NomeDia,
      row_number() OVER (PARTITION BY IdCliente ORDER BY QntdTransações DESC, Dia) AS rn

FROM tb_dia_cliente

)

SELECT *

FROM tb_rn

WHERE rn = 1
