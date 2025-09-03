DELETE FROM relatorio_diario

WHERE strftime('%w', substr(DtCriacao, 1, 10)) = '0';/*Deletando todos domindos da tabela*/

SELECT * FROM relatorio_diario