CREATE TABLE IF NOT EXISTS buses (
    id INT,
    origin  VARCHAR(25),
    destination  VARCHAR(25),
    time  VARCHAR(10)
);


CREATE TABLE IF NOT EXISTS passengers (
    id INT,
    origin  VARCHAR(25),
    destination  VARCHAR(25),
    time  VARCHAR(10)
);


-- insert into buses values (10, 'Warsaw', 'Berlin', '10:55');
-- insert into buses values (20, 'Berlin', 'Paris', '06:20');
-- insert into buses values (21, 'Berlin', 'Paris', '14:00');
-- insert into buses values (22, 'Berlin', 'Paris', '21:40');
-- insert into buses values (30, 'Paris', 'Madrid', '13:30');

insert into buses values (100, 'Munich', 'Rome', '13:00');
insert into buses values (200, 'Munich', 'Rome', '15:30');
insert into buses values (300, 'Munich', 'Rome', '20:00');

insert into passengers values (1, 'Munich', 'Rome', '10:01');
insert into passengers values (2, 'Munich', 'Rome', '11:30');
insert into passengers values (3, 'Munich', 'Rome', '11:30');
insert into passengers values (4, 'Munich', 'Rome', '12:03');
insert into passengers values (5, 'Munich', 'Rome', '13:00');


insert into passengers values (1, 'Paris', 'Madrid', '13:30');
insert into passengers values (2, 'Paris', 'Madrid', '13:31');
insert into passengers values (10, 'Warsaw', 'Paris', '10:00');
insert into passengers values (11, 'Warsaw', 'Berlin', '22:31');
insert into passengers values (40, 'Berlin', 'Paris', '06:15');
insert into passengers values (41, 'Berlin', 'Paris', '06:50');
insert into passengers values (42, 'Berlin', 'Paris', '07:12');
insert into passengers values (43, 'Berlin', 'Paris', '12:03');
insert into passengers values (44, 'Berlin', 'Paris', '20:00');

SELECT id, COUNT(id) AS passengers FROM buses 
INNER JOIN (SELECT bus_time, 
            passengers_id,
            passengers_origin,
            passengers_destination FROM (SELECT  sort_time_passengers.id as passengers_id, 
            sort_time_passengers.origin as passengers_origin, 
            sort_time_passengers.destination as passengers_destination, 
            sort_time_passengers.time as passengers_time, 
            MIN(sort_time_buses.time) as bus_time 
            FROM (SELECT * FROM passengers ORDER BY passengers.time) AS sort_time_passengers
            INNER JOIN (SELECT * FROM buses ORDER BY buses.time) AS sort_time_buses
            ON  sort_time_passengers.origin = sort_time_buses.origin AND
                sort_time_passengers.destination = sort_time_buses.destination AND
                sort_time_passengers.time <= sort_time_buses.time
            GROUP BY    passengers_id, passengers_time, 
                        passengers_origin, passengers_destination) AS time_leave
            ) as summary_table
ON  buses.origin = summary_table.passengers_origin AND
    buses.destination = summary_table.passengers_destination AND
    buses.time = summary_table.bus_time
GROUP BY id;


SELECT id, COUNT(id) AS passengers FROM buses 
INNER JOIN (SELECT bus_time, 
            passengers_id,
            passengers_origin,
            passengers_destination FROM (SELECT  sort_time_passengers.id as passengers_id, 
            sort_time_passengers.origin as passengers_origin, 
            sort_time_passengers.destination as passengers_destination, 
            sort_time_passengers.time as passengers_time, 
            MIN(sort_time_buses.time) as bus_time 
            FROM (SELECT * FROM passengers ORDER BY passengers.time) AS sort_time_passengers
            INNER JOIN (SELECT * FROM buses ORDER BY buses.time) AS sort_time_buses
            ON  sort_time_passengers.origin = sort_time_buses.origin AND
                sort_time_passengers.destination = sort_time_buses.destination AND
                sort_time_passengers.time <= sort_time_buses.time
            GROUP BY    passengers_id, passengers_time, 
                        passengers_origin, passengers_destination) AS time_leave
            ) as summary_table
ON  buses.origin = summary_table.passengers_origin AND
    buses.destination = summary_table.passengers_destination AND
    buses.time = summary_table.bus_time
GROUP BY id;

SELECT b1.id, (SELECT COUNT(p1.id) 
    FROM passengers AS p1 
    WHERE p1.origin = b1.origin AND
        p1.destination = b1.destination AND
        p1.time <= b1.time AND p1.id NOT IN (
            SELECT p2.id FROM passengers AS p2 
            WHERE p2.origin = b1.origin AND
                    p2.destination = b1.destination AND
                    p2.time <= (SELECT b2.time FROM 
                    buses AS b2 
                    WHERE b1.id != b2.id AND 
                    b2.origin = b1.origin AND
                    b2.destination = b1.destination AND 
                    p1.time <= b2.time AND
                    b2.time < b1.time  LIMIT 1
                    )
        )
    ) as value
FROM buses AS b1;

-- Solution

SELECT b1.id, IFNULL(passengers, 0) AS passengers
FROM buses AS b1
LEFT JOIN (
    SELECT id, COUNT(id) AS passengers 
    FROM buses 
    INNER JOIN (
                SELECT 
                    bus_time, 
                    passengers_origin,
                    passengers_destination 
                    FROM (
                            SELECT  passengers.id as passengers_id, 
                                    passengers.origin as passengers_origin, 
                                    passengers.destination as passengers_destination, 
                                    passengers.time as passengers_time, 
                                    MIN(buses.time) as bus_time 
                            FROM passengers
                            INNER JOIN buses
                            ON  passengers.origin = buses.origin AND
                                passengers.destination = buses.destination AND
                                passengers.time <= buses.time
                            GROUP BY    passengers_id, passengers_time, 
                                        passengers_origin, passengers_destination) AS time_leave
                ) as summary_table
    ON  buses.origin = summary_table.passengers_origin AND
        buses.destination = summary_table.passengers_destination AND
        buses.time = summary_table.bus_time
    GROUP BY id) as final_table
ON final_table.id = b1.id;



-- SELECT sort_time_buses.id as bus_id, sort_time_passengers.id as passengers_id, sort_time_passengers.time as passengers_time, sort_time_buses.time as bus_time FROM (SELECT * FROM passengers ORDER BY passengers.time) AS sort_time_passengers
-- INNER JOIN (SELECT * FROM buses ORDER BY buses.time) AS sort_time_buses
-- ON sort_time_passengers.origin = sort_time_buses.origin AND
-- sort_time_passengers.destination = sort_time_buses.destination AND
-- sort_time_passengers.time <= sort_time_buses.time;