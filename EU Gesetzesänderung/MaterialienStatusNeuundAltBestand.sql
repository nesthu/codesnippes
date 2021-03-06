-- Identifizierung Mischbestand für Fokus Teile Wo haben wir Mischbestand und wieviel (Feld Neubestand ;-))
select
NB.material,
NB.vendor_number,
l.NAME1,
NB.consignment_stock_3112,
NB.consumption_since_010120,
NB.switch_check,
NB.tax_vat_identifier,
NB.konsibestand,
NB.NeuerBestand,
m.mmenge as MAX_WITHDRAWAL_PER_DAY,
case
    when m.mmenge > NB.konsibestand - NB.NeuerBestand and NB.vendor_number not in ('53822') then 'Umbuchung prüfen!'
    else
    'alles ok'
    end as Umbuchung_ALARM,
BW.STOCK_VALUE_EUR_PER_UNIT *  (NB.konsibestand - NB.NeuerBestand) as "Umbuchungswert in EUR"
from (                      --  zu allen Materialien noch den neuen Bestand hinzufügen als NEUBESTAND
        select
        st.material,
        st.vendor_number,
        st.consignment_stock_3112,
        st.consumption_since_010120,
        st.switch_check,
        st.tax_vat_identifier,
        b.konsibestand,
        case
          when st.consignment_stock_3112 - st.consumption_since_010120 <= 0 then 0
                else st.consignment_stock_3112 - st.consumption_since_010120
                end as alterBestand,
        b.konsibestand - (st.consignment_stock_3112 - st.consumption_since_010120) as NeuerBestand

        from BESTAND_K_SWITCH_CHECK_TABL st
            left outer join (
                            select
                            material,
                            konsibest_frei + konsibest_qpruefung + konsibest_unfrei + konsibest_gesperrt as Konsibestand
                            from MM_BESTAND_DRS ) b on b.material = st.material
        where st.tax_vat_identifier = 'VA'
        ) NB
    left outer join (
                                                --  Max Entnahme pro Tag in den letzen 12 Monaten
                        select distinct
                        c.materialnummer as Material,
                        max(c.menge) as MMenge
                        from (
                                select
                                    materialnummer,
                                    max(menge) as menge
                                    from MM_MSEG_MATBELEG_12M_DRS_VIEW
                                where soll_haben_kennzeichen = 'H'
                                group by materialnummer,buchungsdatum_beleg
                                ) c
                            group by c.materialnummer ) m on m.Material = NB.material
left outer join MM_LIEFERANT_DRS l on l.KONTONUMMER_KREDITOR = NB.vendor_number
left outer join (
                    -- Bestandswert je Unit runter gerechnet aus letztem Konsibestandswert
                    select
                    material,
                    round(stock_value_eur / consignment_stock,2) as STOCK_VALUE_EUR_PER_UNIT
                    from MM_CONSIGNMENT_VALUE_ALL_EN
                    where "DATE" = (select max("DATE") from MM_CONSIGNMENT_VALUE_ALL_EN where location = 'DRS')
                    ) BW on bw.material = nb.material
where NeuerBestand > 0          -- Filter nur Teile Mit neuem Bestand
