-- aktuelle Lagerliste für Teile welche Konsi INfosatz mit EA Kennzeichen
select
    ls.MATERIAL,
    ls.MRP_TYPE,
    ls.MRP_CONTROLLER,
    ls.PURCHASING_GROUP,
    ls.PLANT,
    ls.PLANT_NUMBER,
    ls.PLANT_TYPE,
    ls.PLANT_AREA,
    ls.QUANT,
    ls.BATCH_NUMBER,
    ls.SPECIAL_STOCK_TYP,
    ls.GR_NUMBER,
    ls.POSTING_DATE,
    ls.TOTAL_VALUATED_STOCK,
    ls.UNIT,
    ls.LAST_UPDATE
from  MM_LAGERLIST_DRS ls

inner join (
select
i.material
from MM_INFOSATZMAT_DRS i
where i.typ_infosatz = '2' and i.UMSATZSTEUERKENNZEICHEN = 'EA'
) i on i.material = ls.material
