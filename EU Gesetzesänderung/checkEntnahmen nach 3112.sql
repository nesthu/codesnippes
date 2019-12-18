select materialnummer, sum(Menge)
from MM_MSEG_MATBELEG_12M_DRS_VIEW
where sonderbestandskennzeichen = 'K' and bewegungsart in ('261','201') and buchungsdatum_beleg > '31.12.18'
group by materialnummer
-- Bewegungsarten noch prüfen  mit Tableau checken Jahresverbrauch .. Tableau soll zu dieser Auswertung passen für die Teile dann perfekt
