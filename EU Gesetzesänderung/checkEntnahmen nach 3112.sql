select  -- Select zum Auflisten Materialnummer und Summe Veräuche ab dem 1.1.19 Stornierungen werden berücksichtigt
list.materialnummer,
sum(list.Menge)
from (
        select
        materialnummer,
        case
            when SOLL_HABEN_KENNZEICHEN = 'S' then 0 - MENGE
            when SOLL_HABEN_KENNZEICHEN = 'H' then Menge
            else 0
            end as MENGE,
        SOLL_HABEN_KENNZEICHEN
        from MM_MSEG_MATBELEG_12M_DRS_VIEW ms
        inner join CHECK_MAT_EU_STEUER_CHANGE c on c.MATERIAL = ms.materialnummer
        where sonderbestandskennzeichen = 'K' and bewegungsart in ('261','201','262','502','202') and buchungsdatum_beleg > '25.12.19'  -- Datum muss auf 31.12.19 angepasster werden !! um Entnahmen ab 1.1. zu sehen
) list

group by list.materialnummer;
-- Bewegungsarten noch prüfen  mit Tableau checken Jahresverbrauch .. Tableau soll zu dieser Auswertung passen für die Teile dann perfekt
