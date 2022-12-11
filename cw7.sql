--zad2
--F:\PostgreSQL\14\bin\raster2pgsql.exe -s 27700 -N -32767 -t 4000x4000 -I -C -M -d F:\danexd\data\*.tif 
--rasters.uk_250k | psql -d cw7 -h localhost -U postgres -p 5432
--zad6
CREATE TABLE uk_lake_district AS
SELECT ST_Clip(a.rast, b.geom, true), b.gid
FROM rasters.uk_250k AS a, public.main AS b
WHERE ST_Intersects(a.rast, b.geom) AND b.gid=1;
--zad9
--F:\PostgreSQL\14\bin\raster2pgsql.exe -s 32630 -N -32767 -t 128x128 -I -C -M -d C:\Users\Maciek\OneDrive\Pulpit\sdfdg\*.jp2 
--rasters.b03 | psql -d cw7 -h localhost -U postgres -p 5432

--F:\PostgreSQL\14\bin\raster2pgsql.exe -s 32630 -N -32767 -t 128x128 -I -C -M -d C:\Users\Maciek\OneDrive\Pulpit\sdfdg\*.jp2 
--rasters.b08 | psql -d cw7 -h localhost -U postgres -p 5432
--zad10
WITH r1 AS ((SELECT ST_Union(ST_Clip(a.rast, ST_Transform(b.geom,32630), true)) as rast
FROM rasters.b03 AS a, public.main AS b
WHERE ST_Intersects(a.rast, ST_Transform(b.geom,32630)) AND b.gid=1)),

r2 AS (
SELECT ST_Union(ST_Clip(a.rast, ST_Transform(b.geom,32630), true)) as rast
FROM rasters.b08 AS a, public.main AS b
WHERE ST_Intersects(a.rast, ST_Transform(b.geom,32630)) AND b.gid=1)

SELECT ST_MapAlgebra(r1.rast,r2.rast, '([rast1.val]-[rast2.val])/([rast1.val]+[rast2.val])::float','32BF') AS rast  
INTO rasters.uk_ndwi2 FROM r1,r2

