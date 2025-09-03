/*Primeira Tabela*/
WITH tb_primeiro_dia AS (

SELECT DISTINCT IdCliente
FROM transacoes
WHERE substr(DtCriacao, 1, 10) = '2025-08-25'

),

/*Segunda tabela*/
tb_ultimo_dia AS (

SELECT DISTINCT IdCliente
FROM transacoes
WHERE substr(DtCriacao, 1, 10) = '2025-08-29'

)

SELECT * 

FROM tb_primeiro_dia AS t1

LEFT JOIN tb_ultimo_dia AS t2
ON t1.IdCliente = t2.IdCliente;



