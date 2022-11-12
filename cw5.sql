--Tworzenie tabeli
CREATE TABLE obiekty(
id INT PRIMARY KEY,
nazwa VARCHAR(12),
geom GEOMETRY
)
--Wstawienie obiektów do tabeli
INSERT INTO obiekty
VALUES(1,'obiekt1',(SELECT ST_GeomFromEWKT('CIRCULARSTRING(0 1,1 1,1 1,2 0,3 1,4 2,5 1,5 1,6 1,6 1, 6 1)'))),
(2,'obiekt2',(SELECT ST_GeomFromEWKT('CURVEPOLYGON(
										  COMPOUNDCURVE((10 2,10 6),(10 6,14 6),CIRCULARSTRING(14 6,16 4,14 2,12 0,10 2)),
										  CIRCULARSTRING(11 2,12 3,13 2,12 1,11 2))'))),
(3,'obiekt3',(SELECT ST_GeomFromEWKT('CIRCULARSTRING(7 15,7 15,10 17,12 13,12 13,7 15,7 15)'))),

(4,'obiekt4',(SELECT ST_Collect(
	ST_GeomFromEWKT('CIRCULARSTRING(20 20,25 25,25 25,27 24,27 24,25 22,25 22,26 21,26 21,22 19,22 19,20.5 19.5,20.5 19.5)'))
)),
(5,'obiekt5',(SELECT ST_Collect(ST_GeomFromEWKT('POINT(38 32 234)'),
	ST_GeomFromEWKT('POINT(30 30 59)')))),
(6,'obiekt6',(SELECT ST_Collect(ST_GeomFromEWKT('CIRCULARSTRING(1 1,3 2,3 2)'),ST_GeomFromEWKT('POINT(4 2)'))
))
--zad 1
SELECT ST_Area(ST_Buffer(ST_Shortestline(a.geom,b.geom),5)) 
FROM obiekty a,obiekty b 
WHERE a.nazwa='obiekt3' AND b.nazwa='obiekt4'
--zad 2
UPDATE obiekty
SET geom=(SELECT ST_Polygonize(ST_Collect(geom,ST_GeomFromEWKT('CIRCULARSTRING(20.5 19.5,20 20,20 20)'))) 
		   FROM obiekty WHERE nazwa='obiekt4') WHERE nazwa='obiekt4'
--zad 3
INSERT INTO obiekty
VALUES(7,'obiekt7',(SELECT st_collect(a.geom,b.geom) 
					FROM obiekty a,obiekty b 
					WHERE a.nazwa='obiekt3' AND b.nazwa='obiekt4'))
--zad 4
Select ST_Area(ST_buffer(geom,5)) from obiekty where st_hasarc(geom)='false'
