/* Selecionar todos clientes com email cadastrado*/
SELECT *
FROM clientes
WHERE FlEmail = 1;

/* Selecionar todas tranações com 50 pontos */
SELECT *
FROM transacoes
WHERE QtdePontos = 50;


/* Todos cliente com mais de 500 pontos */
SELECT IdCliente, QtdePontos
FROM clientes
WHERE QtdePontos > 500;

/* Produtos que tem 'churn' no nome*/
SELECT *
FROM produtos

WHERE DescProduto = 'Churn_10pp' OR 
DescProduto = 'Churn_5pp' OR 
DescProduto = 'Churn_2pp';

-- OU --
SELECT *
FROM produtos

WHERE DescProduto IN ('Churn_10pp', 
'Churn_5pp',
'Churn_2pp');

-- OU O Melhor Jeito genérico--
SELECT *
FROM produtos

WHERE DescProduto LIKE '%Churn%'; /* % = Coringa */

-- OU O Melhor Jeito e Menos Custoso --
SELECT *

FROM produtos

WHERE DescCateogriaProduto = 'churn_model';