/* Count para contar registros */
SELECT count(*),
        count(1)


FROM clientes;

/* Distinct para registros únicos/distintos */
SELECT DISTINCT FlTwitch, 
                FlEmail /* Vai trazer valores distintos para a combinação que eu colocar*/

FROM clientes;

/* Contar Distintos */
SELECT count(DISTINCT FlTwitch)

FROM clientes;

/* Quantidade de criações em junho */
SELECT count(*),
       count(DISTINCT IdCliente)

FROM transacoes

WHERE DtCriacao BETWEEN '2025-07-01' AND '2025-08-01';

/*strftime('%m', dateTime(substr(DtCriacao, 1, 19))) = '07';
*/