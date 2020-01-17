-- Meldebestand und Eigenbestand je Material
select
material,
meldebestand,
bestand_bewertet,
TRUNC(TO_DATE(datum),'MM') as DATUM
from MM_MATDISPLUS_HISTORIE_DRS
