--zad1
SELECT DISTINCT T2019_KAR_BUILDINGS.* INTO buildingsNew
FROM T2019_KAR_BUILDINGS LEFT JOIN T2018_KAR_BUILDINGS ON ST_AsText(T2019_KAR_BUILDINGS.geom) = ST_AsText(T2018_KAR_BUILDINGS.geom)
WHERE T2018_KAR_BUILDINGS.geom IS NULL
SELECT * FROM buildingsNew

--zad2
SELECT T2019_KAR_POI_TABLE.type,COUNT(DISTINCT T2019_KAR_POI_TABLE.*) 
FROM buildingsNew,T2019_KAR_POI_TABLE LEFT JOIN T2018_KAR_POI_TABLE on T2019_KAR_POI_TABLE.geom = T2018_KAR_POI_TABLE.geom
WHERE T2018_KAR_POI_TABLE.geom IS NULL
AND ST_Intersects(ST_Buffer(buildingsNew.geom::geography,500),T2019_KAR_POI_TABLE.geom::geography)
GROUP BY T2019_KAR_POI_TABLE.type

--zad3
SELECT gid,link_id,st_name,ref_in_id,nref_in_id,func_class,speed_cat,fr_speed_l,to_speed_l,dir_travel,ST_Transform(geom,3068) AS geom
INTO streets_reprojected
FROM T2019_KAR_STREETS
--zad4
CREATE TABLE input_points (
gid INT PRIMARY KEY,
geom GEOMETRY);
INSERT INTO input_points
VALUES (1,(ST_SetSRID(ST_MakePoint(8.36093,49.03174), 4326))),
		(2,(ST_SetSRID(ST_MakePoint(8.39876,49.00644), 4326)))
SELECT * FROM input_points

--zad5
UPDATE input_points
SET geom=ST_Transform(geom,3068)
SELECT ST_AsText(geom) FROM input_points

--zad6
UPDATE input_points
SET geom=ST_Transform(geom,4326)
SELECT T2019_KAR_STREET_NODE.* 
FROM input_points a,input_points b,T2019_KAR_STREET_NODE 
WHERE a.gid=1 AND b.gid=2 
AND ST_Distance(T2019_KAR_STREET_NODE.geom::geography,ST_MakeLine(a.geom,b.geom)::geography) <= 200

--zad7
SELECT COUNT(T2019_KAR_POI_TABLE.*) FROM T2019_KAR_POI_TABLE,T2019_KAR_LAND_USE_A 
WHERE T2019_KAR_POI_TABLE.type LIKE 'Sporting Goods Store' 
AND T2019_KAR_LAND_USE_A.type LIKE 'Park (City/County)' 
AND ST_Distance(T2019_KAR_POI_TABLE.geom::geography,T2019_KAR_LAND_USE_A.geom::geography) <= 300

--zad8
SELECT DISTINCT ST_Intersection(T2019_KAR_RAILWAYS.geom,T2019_KAR_WATER_LINES.geom) 
INTO T2019_KAR_BRIDGES 
FROM T2019_KAR_RAILWAYS,T2019_KAR_WATER_LINES

SELECT * FROM T2019_KAR_BRIDGES


