--select material, count(*)
--from (
select
fb.material,
fb.VENDOR_NUMBER,
fb.INFO_RECORD_NUMBER,
fb."TAX_VAT_Identifier",
fb.CONSIGNMENT_STOCK as CONSIGNMENT_STOCK_3112,
nvl(vb.verbrauch,0) as Consumption_Since_010120,
fb.CONSIGNMENT_STOCK - nvl(vb.verbrauch,0) as Switch_check
from bestand_k_drs_311219_fin_view fb --Final Bestand
left join (
            select  -- Select zum Auflisten Materialnummer und Summe Veräuche ab dem 1.1.19 Stornierungen werden berücksichtigt
            list.materialnummer,
            sum(list.Menge) as VERBRAUCH
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
            group by list.materialnummer
            )vb on vb.materialnummer = fb.material
--where fb."TAX_VAT_Identifier" = 'VA'
--)
--group by material
-- doppelt 2001450  und P000115860
