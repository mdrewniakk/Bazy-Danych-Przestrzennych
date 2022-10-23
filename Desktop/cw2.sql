--zad4
SELECT COUNT(DISTINCT popp.*) FROM popp,majrivers 
WHERE popp.f_codedesc='Building' AND ST_Distance(popp.geom,majrivers.geom) < 3280.8399

SELECT DISTINCT popp.* INTO tableB FROM popp,majrivers 
WHERE popp.f_codedesc='Building' AND ST_Distance(popp.geom,majrivers.geom) < 3280.8399
--zad5
--a
SELECT elev,name,geom INTO airportsNew from airports
Select name,MAX(ST_X(geom)) AS maxe from airportsNew 
GROUP BY name 
ORDER BY maxe DESC LIMIT 1
Select name,MIN(ST_X(geom)) AS maxw from airportsNew 
GROUP BY name 
ORDER BY maxw ASC LIMIT 1
--b
INSERT INTO airportsNew
VALUES (561.000,'airportB',(SELECT ST_astexT(ST_Centroid(ST_MakeLine(a.geom,b.geom)))
							FROM airportsNew a, airportsNew b \
							WHERE a.name = 'ANNETTE ISLAND' 
							AND b.name = 'ATKA'));
SELECT name,geom FROM airportsNew WHERE name='ANNETTE ISLAND' OR name = 'ATKA' OR name='airportB'
--zad6
SELECT ST_Area(ST_Buffer(ST_Shortestline(lakes.geom,airports.geom),1000)) 
FROM lakes,airports 
WHERE airports.name = 'AMBLER' AND lakes.names = 'Iliamna Lake'
--zad7
SELECT vegdesc,SUM(ST_area(ST_intersection(trees.geom,tundra.geom)))+SUM(ST_area(ST_intersection(trees.geom,swamp.geom))) 
FROM tundra,trees,swamp 
GROUP BY vegdesc
