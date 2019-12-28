
-- Check ob Bestandsdaten generell in der Datenbank eingelaufen sind
select MAX(LAST_UPDATE)
from MM_BESTAND_DRS;

-- check ob Consignment MB54 Daten eingelaufen sind
select max("DATUM")
from MM_CONSIGNMENT_VALUE_DRS;

--- check ob auch im view der MB54 das letzte Datum der 31.12.19 ist
select MAX("DATE")
from MM_CONSIGNMENT_VALUE_ALL_EN
where LOCATION = 'DRS';


-- wann ist das letzte mal das Bestandsupdate gefahren  (
select MAX(LAST_UPDATE)
from MM_BESTAND_K_DRS_311219_FIN;
-- wenn nicht aktuell, dann UPDATE_BESTAND_K_311219_FIN  manuell noch mal Starten ebenso UPDATE_MONITORING_KONSI_VAT

-- check ob Prüftabellen für Tableau aktuell sind
select MAX(LAST_UPDATE)
from BESTAND_K_SWITCH_CHECK_TABL;

select MAX(LAST_UPDATE)
from MM_BESTAND_K_DRS_311219_TABL
