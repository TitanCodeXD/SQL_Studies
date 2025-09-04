/*Quantidade transações vida/dias específicos*/
WITH tb_transacoes AS (

SELECT IdTransacao,
        IdCliente,
        QtdePontos,
        datetime(substr(DtCriacao, 1, 19)) AS dtCriacao,
        julianday('now') - julianday(substr(DtCriacao, 1, 10)) AS DiffDias,
        CAST(strftime('%H', substr(DtCriacao, 1, 19)) AS INTEGER) AS dtHora

FROM transacoes

WHERE dtCriacao < '2025-07-01'


),

tb_cliente AS (
SELECT IdCliente,
        datetime(substr(DtCriacao, 1, 10)) AS dtCriacao,
        julianday('now') - julianday(substr(DtCriacao, 1, 10)) AS idadeBase


FROM clientes

),

tb_sumario_transacoes AS (

SELECT IdCliente,
        count(IdTransacao) AS QntdTransacoesVida,
        count(CASE WHEN DiffDias <= 56 THEN IdTransacao END) AS D56,
        count(CASE WHEN DiffDias <= 28 THEN IdTransacao END) AS D28,
        count(CASE WHEN DiffDias <= 14 THEN IdTransacao END) AS D14,
        count(CASE WHEN DiffDias <= 7 THEN IdTransacao END) AS D7,
        sum(QtdePontos) AS saldoPontos,
        min(DiffDias) AS diasUltimaTransacao, /*Dias desde a última transação*/

        sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS saldoPositivo,
        sum(CASE WHEN QtdePontos > 0 AND DiffDias <= 56 THEN QtdePontos ELSE 0 END) AS saldoPositivoD56,
        sum(CASE WHEN QtdePontos > 0 AND DiffDias <= 28 THEN QtdePontos ELSE 0 END) AS saldoPositivoD28,
        sum(CASE WHEN QtdePontos > 0 AND DiffDias <= 14 THEN QtdePontos ELSE 0 END) AS saldoPositivoD14,
       sum(CASE WHEN QtdePontos > 0 AND DiffDias <=  7 THEN QtdePontos ELSE 0 END) AS saldoPositivoD7,
       
       sum(CASE WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) AS saldoNegativo,
        sum(CASE WHEN QtdePontos < 0 AND DiffDias <= 56 THEN QtdePontos ELSE 0 END) AS saldoNegativoD56,
        sum(CASE WHEN QtdePontos < 0 AND DiffDias <= 28 THEN QtdePontos ELSE 0 END) AS saldoNegativoD28,
        sum(CASE WHEN QtdePontos < 0 AND DiffDias <= 14 THEN QtdePontos ELSE 0 END) AS saldoNegativoD14,
       sum(CASE WHEN QtdePontos < 0 AND DiffDias <=  7 THEN QtdePontos ELSE 0 END) AS saldoNegativoD7


FROM tb_transacoes

GROUP BY IdCliente

),

tb_transacao_produto AS (

SELECT t1.*,
        t3.DescProduto,
        t3.DescCateogriaProduto

FROM tb_transacoes AS t1

LEFT JOIN transacao_produto AS t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos AS t3
ON t2.IdProduto = t3.IdProduto

),

tb_cliente_produto AS (

SELECT IdCliente,
        DescProduto,
        count(*) AS qntdVida,
        count(CASE WHEN DiffDias <= 56 THEN IdTransacao END) AS qntd56,
        count(CASE WHEN DiffDias <= 28 THEN IdTransacao END) AS qntd28,
        count(CASE WHEN DiffDias <= 14 THEN IdTransacao END) AS qntd14,
        count(CASE WHEN DiffDias <= 7 THEN IdTransacao END) AS qntd7

FROM tb_transacao_produto

GROUP BY IdCliente, DescProduto

),

tb_cliente_produto_rn AS (


SELECT *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qntdVida DESC) AS rnVida,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qntd56 DESC) AS rn56,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qntd28 DESC) AS rn28,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qntd14 DESC) AS rn14,
        row_number() OVER (PARTITION BY IdCliente ORDER BY qntd7 DESC) AS rn7

FROM tb_cliente_produto

),

tb_cliente_dia AS (

SELECT IdCliente,
        strftime('%w', DtCriacao) AS DtDia,
        count(*) AS QntdTransacoes

FROM tb_transacoes

WHERE DiffDias <= 28

GROUP BY IdCliente

),

tb_cliente_dia_rn AS (

SELECT *,
        row_number() OVER (PARTITION BY IdCliente ORDER BY QntdTransacoes DESC) AS rnDia

FROM tb_cliente_dia

), 

tb_cliente_periodo AS (

 SELECT IdCliente,
        CASE 
            WHEN dtHora BETWEEN 7 AND 12 THEN 'MANHÃ'
            WHEN dtHora BETWEEN 13 AND 18 THEN 'TARDE'
            WHEN dtHora BETWEEN 19 AND 23 THEN 'NOITE'
            ELSE 'MADRUGADA'
        END AS periodo,
        COUNT(*) AS QntdTransacoes

FROM tb_transacoes

WHERE DiffDias <= 28

GROUP BY 1, 2

),

tb_cliente_periodo_rn AS (

    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY QntdTransacoes DESC) AS rnPeriodo

    FROM tb_cliente_periodo

),

tb_join AS (

SELECT t1.*,
        t2.idadeBase,
        t3.DescProduto AS ProdutoVida,
        t4.DescProduto AS Produto56,
        t5.DescProduto AS Produto28,
        t6.DescProduto AS Produto14,
        t7.DescProduto AS Produto7,
        COALESCE(t8.DtDia, -1) AS DtDia,
        COALESCE(t9.periodo, 'SEM INFORMAÇÃO') AS periodoMaisTransacao28

FROM tb_sumario_transacoes AS t1

LEFT JOIN tb_cliente AS t2
ON t1.IdCliente = t2.IdCliente 


LEFT JOIN tb_cliente_produto_rn AS t3
ON t2.IdCliente = t3.IdCliente 
AND t3.rnVida = 1

LEFT JOIN tb_cliente_produto_rn AS t4
ON t2.IdCliente = t4.IdCliente 
AND t4.rn56 = 1

LEFT JOIN tb_cliente_produto_rn AS t5
ON t2.IdCliente = t5.IdCliente 
AND t5.rn28 = 1

LEFT JOIN tb_cliente_produto_rn AS t6
ON t2.IdCliente = t6.IdCliente 
AND t6.rn14 = 1

LEFT JOIN tb_cliente_produto_rn AS t7
ON t2.IdCliente = t7.IdCliente 
AND t7.rn7 = 1

LEFT JOIN tb_cliente_dia_rn AS t8
ON t2.IdCliente = t8.IdCliente 
AND t8.rnDia = 1

LEFT JOIN tb_cliente_periodo_rn AS t9
ON t2.IdCliente = t9.IdCliente 
AND t9.rnPeriodo = 1

)



SELECT *

FROM tb_cliente_periodo

