-- Creating international_students table

CREATE TABLE international_students(
    id_number NUMBER,
    first_name VARCHAR2(100),
    last_name VARCHAR2(200)
);

--inserting data into international_students table using proccedure
DECLARE
   counter NUMBER := 1;
BEGIN
   FOR i IN 1..2000000 LOOP
      INSERT INTO international_students (id_number, first_name, last_name)
      VALUES (counter, 'Noor ' || counter, 'Afghan ' || counter);
      
      counter := counter + 1;
   END LOOP;
   
   COMMIT;
END;

select * from international_students;

-- Creating cluster
CREATE CLUSTER first_cluster (id_number NUMBER);

-- Creating cluster index
CREATE INDEX cluster_index ON CLUSTER first_cluster;

-- Creating non-cluster index
CREATE INDEX non_cluster_index ON international_students (first_name);