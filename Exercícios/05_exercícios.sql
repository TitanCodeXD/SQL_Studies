/*CTE*/

/*Quem iniciou o curso no primeiro dia?, 
fazer média dos dias de curso*/

/*Quem participou da primeria aula*/
WITH tb_primeiro_dia AS (

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'

),

/*Dias de curso, quem participou do curso inteiro*/

tb_dias_curso AS (

    SELECT DISTINCT IdCliente, substr(DtCriacao, 1, 10) AS presenteDia
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) BETWEEN '2025-08-25' AND '2025-08-29'

    ORDER BY IdCliente, presenteDia
),

tb_cliente_dias AS (

SELECT t1.IdCliente,
       count(t2.presenteDia) AS TotalDiasPresente
       
FROM tb_primeiro_dia AS t1

LEFT JOIN tb_dias_curso AS t2
ON t1.IdCliente = t2.IdCliente

GROUP BY t1.IdCliente

)

SELECT AVG(TotalDiasPresente),
        max(TotalDiasPresente),
        min(TotalDiasPresente)
FROM tb_cliente_dias;