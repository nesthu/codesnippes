-- Identifizierung Mischbestand für Fokus Teile Wo haben wir Mischbestand und wieviel (Feld Neubestand ;-))
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
