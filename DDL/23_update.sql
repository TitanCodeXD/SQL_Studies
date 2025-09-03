SELECT * FROM relatorio_diario;

/*UPDATE SEM WHERE, errado de forma geral
UPDATE relatorio_diario 
SET QntdTransações = 100;*/

UPDATE relatorio_diario 
SET QntdTransações = 100
WHERE Dia >= '2025-08-25';

SELECT * FROM relatorio_diario