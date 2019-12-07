--Liefrantenmaterialnummer aus Infosatz  für alle Standorte holen zu allen R Parts 1629 DRS
select distinct
    i.MATERIAL,
    i.LIEFERANTENMATERIALNR,
    r.WERKSSPEZ_MATERIALSTATUS,
    r.LOCATION
from MM_INFOSATZ_ALLE_WERKE i
    inner JOIN (
                    select
                    s.Material,
                    s.WERKSSPEZ_MATERIALSTATUS,
                    s.STANDORT as LOCATION
                    from MM_STAMMDATEN_ALLE_WERKE s
                    where s."LÖSCHKENNZEICHEN_WK" is null) r
                    on r.Material = i.MATERIAL and r.LOCATION = i.STANDORT
where LENGTH(i.LIEFERANTENMATERIALNR) > 3  and r.WERKSSPEZ_MATERIALSTATUS = 'R';
