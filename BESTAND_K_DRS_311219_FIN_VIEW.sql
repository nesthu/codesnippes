select
    sc.INFOSATZ as INFO_RECORD_NUMBER,
    sc.MATERIAL as MATERIAL,
    sc.MATINDEX,
    sc.MATERIALKURZTEXTDE as MATERIAL_DESCRIPTION_DE,
    sc.MATERIALKURZTEXTZ1 as MATERIAL_DESCRIPTION_Z1,
    sc.LIEFERANTNR as VENDOR_NUMBER,
    sc.LIEFERANTNAME as VENDOR_NAME,
    sc.LIEFERANTENMATERIALNR as VENDOR_MATERIALNUMMER,
    sc.ENTSCHEIDUNG_MM as DECISION_MM,
    sc.MM_GROUP,
    bs.consignment_stock,
    s.einheit_meldebestand as UNIT,
    i.UMSATZSTEUERKENNZEICHEN as "TAX_VAT_Identifier",
    bs.FREE,
    bs.QM,
    bs.NOT_FREE,
    bs.blocked,
    k.stock_value_eur
from CHECK_MAT_EU_STEUER_CHANGE sc
    left join MM_BESTAND_K_DRS_311219_FIN bs on bs.material = sc.matindex
    left join mm_stammdaten_drs s on s.material = sc.matindex
    left join MM_INFOSATZMAT_DRS i on i.material = sc.matindex and i.typ_infosatz = '2'
    left join mm_consignment_value_all_en k on k.material = sc.matindex and k."DATE" = '30.11.2019'
