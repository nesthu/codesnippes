--Liefrantenmaterialnummer PARTNUMMER_LIEFARTNR_2 aus Klassifizierung  für alle Standorte holen zu allen R Parts 1629 DRS
select distinct
    k.OBJEKT,
    k.PARTNUMMER_LIEFARTNR_2,
    r.WERKSSPEZ_MATERIALSTATUS,
    r.LOCATION
from MM_KLASSE_MAT_ALLE_WERKE k
    inner JOIN (
                    select
                    s.Material,
                    s.WERKSSPEZ_MATERIALSTATUS,
                    s.STANDORT as LOCATION
                    from MM_STAMMDATEN_ALLE_WERKE s
                    where s."LÖSCHKENNZEICHEN_WK" is null) r
                    on r.Material = k.OBJEKT and r.LOCATION = k.WERK
where   LENGTH(k.PARTNUMMER_LIEFARTNR_2) > 3 -- Ausblenden Nullwerte und kleiner 999
        and k.PARTNUMMER_LIEFARTNR_2 not in ('no OEM p/n','nicht bekannt','N.A.','OHNE') -- Ausblenden nicht realer Nummern
        and r.WERKSSPEZ_MATERIALSTATUS = 'R'; -- Anzeige nur markierte Repteile
