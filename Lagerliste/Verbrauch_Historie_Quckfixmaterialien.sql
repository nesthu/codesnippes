select
    h.MATERIAL,
    h.BATCH_NUMBER,
    h.GR_NUMBER,
    h.POSTING_DATE as DELIVERY_DATE,
    h.CONSUMPTION_DATE as CONSUMPTION_DATE,
    h.CONSUMPTION as QUANTITY
from MM_LAGERLIST_USAGE_HIST h
inner join (
            select MATERIAL
            from MM_INFOSATZMAT_DRS
            where TYP_INFOSATZ = '2' and UMSATZSTEUERKENNZEICHEN = 'EA') i on i.material = h.material
order by h.CONSUMPTION_DATE  DESC
