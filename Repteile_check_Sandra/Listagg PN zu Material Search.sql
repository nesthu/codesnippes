-- ohne distinct 119430  auch mit Distinct 119430 ??
select
LIEFERANTMATERIAL,
WERKSSPEZ_MATERIALSTATUS,
LOCATION,
listagg(MATERIAL, ', ') within group( order by MATERIAL ) AS NOV_SEARCH
from (
--Liefrantenmaterialnummer OEM Ursprung (Mehrfach) aus Klassifizierung für alle Standorte holen zu allen R Parts 1629 DRS
select distinct
    k.OBJEKT as MATERIAL,
    k.OEM_PN_URSPRUNG as LIEFERANTMATERIAL,
    r.WERKSSPEZ_MATERIALSTATUS as WERKSSPEZ_MATERIALSTATUS,
    r.LOCATION as LOCATION
from MM_KLASSE_MAT_ALLE_WERKE k
    inner JOIN (
                    select
                    s.Material,
                    s.WERKSSPEZ_MATERIALSTATUS,
                    s.STANDORT as LOCATION
                    from MM_STAMMDATEN_ALLE_WERKE s
                    where s."LÖSCHKENNZEICHEN_WK" is null) r
                    on r.Material = k.OBJEKT and r.LOCATION = k.WERK
where   LENGTH(k.OEM_PN_URSPRUNG) > 3 -- Ausblenden Nullwerte und kleiner 999
        and k.OEM_PN_URSPRUNG not in ('no OEM p/n','nicht bekannt','N.A.','OHNE') -- Ausblenden nicht realer Nummern
        --and r.WERKSSPEZ_MATERIALSTATUS = 'R'; -- Anzeige nur markierte Repteile
union

--Liefrantenmaterialnummer aus Infosatz  für alle Standorte holen zu allen R Parts 1629 DRS
select distinct
    i.MATERIAL,
    trim(i.LIEFERANTENMATERIALNR) as LIEFERANTENMATERIALNR,
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
where LENGTH(i.LIEFERANTENMATERIALNR) > 3  --and r.WERKSSPEZ_MATERIALSTATUS = 'R'

union

--Liefrantenmaterialnummer OEM aktuell aus Klassifizierung für alle Standorte holen zu allen R Parts 1629 DRS
select distinct
    k.OBJEKT,
    k.OEM_PN_AKTUELL,
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
where   LENGTH(k.OEM_PN_AKTUELL) > 3 -- Ausblenden Nullwerte und kleiner 999
        and k.OEM_PN_AKTUELL not in ('no OEM p/n','nicht bekannt','N.A.','OHNE') -- Ausblenden nicht realer Nummern
        --and r.WERKSSPEZ_MATERIALSTATUS = 'R'; -- Anzeige nur markierte Repteile

union

--Liefrantenmaterialnummer  PARTNUMMER_LIEFARTNR_1 aus Klassifizierung für alle Standorte holen zu allen R Parts 1629 DRS
select distinct
    k.OBJEKT,
    k.PARTNUMMER_LIEFARTNR_1,
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
where   LENGTH(k.PARTNUMMER_LIEFARTNR_1) > 3 -- Ausblenden Nullwerte und kleiner 999
        and k.PARTNUMMER_LIEFARTNR_1 not in ('no OEM p/n','nicht bekannt','N.A.','OHNE') -- Ausblenden nicht realer Nummern
        --and r.WERKSSPEZ_MATERIALSTATUS = 'R'; -- Anzeige nur markierte Repteile

union

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
        --and r.WERKSSPEZ_MATERIALSTATUS = 'R'; -- Anzeige nur markierte Repteile
)
group by
    LIEFERANTMATERIAL,
WERKSSPEZ_MATERIALSTATUS,
LOCATION
;
