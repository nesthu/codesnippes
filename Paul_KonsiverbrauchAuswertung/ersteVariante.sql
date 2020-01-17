select
    mp.material,
    mp.meldebestand,
    case
        when vb.consumption is null then 0
        else
        vb.consumption
        end as consumption,
    mp.bestand_bewertet,
    case
        when ks.Consignment_Stock is null then 0
        else ks.Consignment_Stock
        end as Consignment_Stock,
    TRUNC(TO_DATE(mp.datum),'MM') as DATUM
from MM_MATDISPLUS_HISTORIE_DRS mp
    -- vb Verbrauch zum Mateiral
    left outer join (
            select
                materialnr,
                0-change_in_stock as consumption,
                TRUNC(TO_DATE(month_year),'MM') as DATUM
            from MM_ZHMDMAVL_DRS) vb on vb.materialnr = mp.material and vb.DATUM = mp.DATUM
    --ks Konsignment Stock
    left outer join(
            select
                material,
                ROUND(avg(konsibestand),1) as Consignment_Stock,
                TRUNC(TO_DATE(CAST(last_update AS DATE)),'MM') as DATUM
                from MM_KONSI_PERFORMANCE_DETAIL
            group by Material, TRUNC(TO_DATE(CAST(last_update AS DATE)),'MM')
            ) ks on ks.material = mp.material and ks.DATUM = mp.DATUM
where TRUNC(TO_DATE(mp.datum),'MM') > (trunc(sysdate, 'MM'))- interval '24' month
