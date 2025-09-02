SELECT round(avg(QtdePontos), 2) AS MediaPontos,
         1. * sum(QtdePontos) / count(IdCliente) AS MediaPontos2,
         round(min(QtdePontos), 2) AS MinimoPontos,
         round(max(QtdePontos), 2) AS MaximoPontos,
         sum(FlTwitch),
         sum(FlEmail)

FROM clientes