--creating table
CREATE TABLE homework (
    id NUMBER,
    first_name VARCHAR2(100),
    last_name VARCHAR2(100)
);

--inserting values into homework table
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO homework (id, first_name, last_name)
        VALUES (i, 'Ali' || i, 'Wali' || i);
    END LOOP;
    COMMIT;
END;

--checking the size of the homework table
select * from homework;
SELECT segment_name, SUM(bytes) AS table_size
FROM user_segments
WHERE segment_name = 'homework'
GROUP BY segment_name;

--creating index
CREATE INDEX homeworkindex ON homework (id);

--calculating the size of the table homework 
SELECT segment_name, SUM(bytes) AS table_size
FROM user_segments
WHERE segment_name IN ('homework', 'homeworkindex')
GROUP BY segment_name;

--creating indeses
CREATE INDEX firstname_index ON homework (first_name);
CREATE INDEX lastname_index ON homework (last_name);

--calculating the size of the table and indices together.
SELECT segment_name,
       SUM(blocks * (SELECT value FROM v$parameter WHERE name = 'db_block_size')) AS total_size_bytes
FROM user_segments
WHERE segment_name = 'homework' OR segment_name LIKE 'homework|%'
GROUP BY segment_name;
