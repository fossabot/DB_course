-- •клиентов группы "Брейк-данс", у которых срок действия абонемента заканчивается в этом месяце;
SELECT *
FROM client
WHERE team_name = 'Брейк-данс'
  AND YEAR(endTicket) = YEAR(NOW())
  AND MONTH(endTicket) = MONTH(NOW())
ORDER BY fio;
-- [2019-01-28 21:48:58] 1 row retrieved starting from 1 in 40 ms (execution: 5 ms, fetching: 35 ms)


SELECT *
FROM client
WHERE ticket IN (SELECT ticket FROM client WHERE team_name = 'Брейк-данс')
  AND YEAR(endTicket) = YEAR(NOW())
  AND MONTH(endTicket) = MONTH(NOW())
ORDER BY fio;
-- [2019-01-28 21:56:04] 1 row retrieved starting from 1 in 73 ms (execution: 9 ms, fetching: 64 ms)

-- •	клиентов, у которых дни рождения в текущем месяце;
SELECT *
FROM client
WHERE MONTH(birthday) = MONTH(NOW())
ORDER BY DAY(birthday);

-- •	групп с указанием количества клиентов на сегодняшний день;
SELECT team.*, COUNT(*) AS count
FROM team,
     scheduler,
     client
WHERE client.team_name = team.name
  AND scheduler.team_name = team.name
  AND scheduler.day_of_week = DAYOFWEEK(NOW())
GROUP BY team.name
ORDER BY count;

-- •	общая продолжительность занятий в каждом зале по дням недели.
SELECT scheduler.room, day_of_week, (SUM(scheduler.end - scheduler.start) / 100) AS duration
FROM scheduler
GROUP BY scheduler.room, scheduler.day_of_week
ORDER BY scheduler.day_of_week, scheduler.room DESC;

-- Вывести расписание занятий в определённом зале.
SELECT *
FROM scheduler
WHERE room = 'Бассейн'
ORDER BY day_of_week;