select
    cl.INFOSATZ as INFO_RECORD_NUMBER,
    cl.MATERIAL as MATERIAL,
    cl.LIEFERANTNUMMER as VENDOR_NUMBER,
    cl.KONSIBESTAND as CONSIGNMENT_STOCK_3112,
    case
    when vb.verbrauch is null then 0
    else vb.verbrauch
    end as  CONSUMPTION_SINCE_010120,
    i.UMSATZSTEUERKENNZEICHEN as  TAX_VAT_IDENTIFIER ,
    cl.KONSIBESTAND - nvl(vb.verbrauch,0) as  SWITCH_CHECK,
    LOCALTIMESTAMP as  LAST_UPDATE
from CHECK_MAT_EU_STEUER_VIHCN cl
    left outer join MM_INFOSATZMAT_VIH i
            on i.material = cl.material and cl.infosatz = i.infosatz and i.typ_infosatz = '2'
    left outer join (
                    Select  -- Select zum Auflisten Materialnummer und Summe Veräuche ab dem 1.1.20 Stornierungen werden berücksichtigt
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
                                from MM_MSEG_MATBELEG_12M_VIH_VIEW ms
                        inner join CHECK_MAT_EU_STEUER_VIHCN c on c.MATERIAL = ms.materialnummer
                        where sonderbestandskennzeichen = 'K' and bewegungsart in ('261','201','262','502','202','411','122') and buchungsdatum_beleg > '31.12.19'  -- Datum muss auf 31.12.19 angepasster werden !! um Entnahmen ab 1.1. zu sehen
                ) list
                group by list.materialnummer
                )vb on vb.materialnummer = cl.material
    
