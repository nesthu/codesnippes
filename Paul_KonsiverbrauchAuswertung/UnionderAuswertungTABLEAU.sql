select
    mp.material,
    mp.meldebestand,
    mp.bestand_bewertet as WERT,
    TRUNC(TO_DATE(mp.datum),'MM') as DATUM,
    'Eigenbestand' as Bemerkung
from MM_MATDISPLUS_HISTORIE_DRS mp
where TRUNC(TO_DATE(mp.datum),'MM') > (trunc(sysdate, 'MM'))- interval '24' month
-- MATERIAL  meldebestand WERT DATUM BEMERKUNG
union
select
    materialnr,
    0 as meldebestand,
    0-change_in_stock as WERT,
    TRUNC(TO_DATE(month_year),'MM') as DATUM,
    'Consumption' as Bemerkung
from MM_ZHMDMAVL_DRS
union
select
material,
0 as meldebestand,
ROUND(avg(konsibestand),1) as WERT,
TRUNC(TO_DATE(CAST(last_update AS DATE)),'MM') as DATUM,
'Consignment_Stock' as Bemerkung
from MM_KONSI_PERFORMANCE_DETAIL
group by Material, TRUNC(TO_DATE(CAST(last_update AS DATE)),'MM')
