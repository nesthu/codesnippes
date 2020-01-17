-- durchschnittliche Konsibestand im Monat je Material
select
material,
ROUND(avg(konsibestand),1),
TRUNC(TO_DATE(CAST(last_update AS DATE)),'MM') as DATUM
from MM_KONSI_PERFORMANCE_DETAIL
group by Material, TRUNC(TO_DATE(CAST(last_update AS DATE)),'MM')
