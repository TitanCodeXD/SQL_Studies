/*Saldo de pontos acumulados de cada usuário*/

/*Criar tabela para evitar sobrecarregamento de refresh de querys
*/
DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE IF NOT EXISTS relatorio_diario AS

WITH tb_diario AS (
    
    SELECT substr(DtCriacao,1,10) AS Dia,
           count(distinct IdTransacao) AS qtdTransacao

    FROM transacoes
    GROUP BY Dia
    ORDER BY Dia
),

tb_acum AS (
    SELECT *,
            sum(qtdTransacao) OVER (ORDER BY Dia) AS qtdeTransacaoAcum

    FROM tb_diario
)

SELECT *
FROM tb_acum
;


SELECT * FROM relatorio_diario
