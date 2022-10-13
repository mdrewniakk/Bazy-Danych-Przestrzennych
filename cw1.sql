CREATE TABLE budynki(
id INT PRIMARY KEY,
	geometria GEOMETRY,
	nazwa VARCHAR(15),
	wysokosc NUMERIC(4,1)
);
CREATE TABLE drogi(
id INT PRIMARY KEY,
	geometria GEOMETRY,
	nazwa VARCHAR(15)
);
CREATE TABLE pktinfo(
id INT PRIMARY KEY,
	geometria GEOMETRY,
	nazwa VARCHAR(15),
	liczprac INT
);
INSERT INTO budynki
VALUES (1, ST_GeomFromText('POLYGON((8 4,10.5 4,10.5 1.5,8 1.5,8 4))'),'BuildingA',5),
		(2, ST_GeomFromText('POLYGON((4 5,6 5,6 7,4 7,4 5))'),'BuildingB',9),
		(3, ST_GeomFromText('POLYGON((3 6,5 6,5 8,3 8,3 6))'),'BuildingC',10),
		(4, ST_GeomFromText('POLYGON((9 8,10 8,10 9,9 9,9 8))'),'BuildingD',8),
		(5, ST_GeomFromText('POLYGON((1 1,2 1,2 2,1 2,1 1))'),'BuildingF',6);
INSERT INTO drogi
VALUES (1, ST_GeomFromText('LINESTRING(7.5 10.5,7.5 0)'),'RoadY'),
		(2, ST_GeomFromText('LINESTRING(12 4.5,0 4.5)'),'RoadX');

INSERT INTO pktinfo
VALUES (1, ST_GeomFromText('POINT(1 3.5)'),'G',16),
		(2, ST_GeomFromText('POINT(5.5 1.5)'),'H',10),
		(3, ST_GeomFromText('POINT(9.5 6)'),'I',26),
		(4, ST_GeomFromText('POINT(6.5 6)'),'J',39),
		(5, ST_GeomFromText('POINT(6 9.5)'),'K',41);
--zad1		
SELECT SUM(ST_LENGTH(geometria)) FROM drogi;
--zad2
SELECT ST_AsText(geometria) AS GeometriaWKT,ST_AREA(geometria) AS Pole_powierzchni,ST_Perimeter(geometria) AS Obwód FROM budynki WHERE nazwa='BuildingA';
--zad3
SELECT ST_AREA(geometria) AS Pole_powierzchni,nazwa FROM budynki ORDER BY nazwa;
--zad4
SELECT ST_Perimeter(geometria) AS Obwód, nazwa FROM budynki ORDER BY Obwód DESC LIMIT 2;
--zad5
SELECT ST_Distance(budynki.geometria,pktinfo.geometria) AS odleglosc FROM budynki,pktinfo WHERE budynki.nazwa='BuildingC' AND pktinfo.nazwa='G';
--zad6
SELECT ST_Area(ST_Difference(b.geometria,ST_Buffer(a.geometria,0.5))),a.geometria,b.geometria FROM budynki a, budynki b WHERE a.nazwa='BuildingB' AND b.nazwa='BuildingC';
--zad7
SELECT budynki.nazwa FROM budynki,drogi WHERE drogi.nazwa='RoadX' AND ST_Y(ST_Centroid(budynki.geometria)) > ST_Y(ST_Centroid(drogi.geometria));
--zad8
SELECT ST_Area(ST_SymDifference(geometria,ST_GeomFromText('POLYGON((4 7,6 7,6 8,4 8,4 7))'))) FROM budynki WHERE nazwa='BuildingC';
