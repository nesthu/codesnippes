-- Liste VIH mit allen 300mm Spares Teilen
select
mv.material,
mv.material_description_de,
mv.stock_value,
mv.total_stock,
mv.reorder_point,
mv.net_price_in_eur,
mv.vendor_number,
mv.vendor_name,
mv.current_oem_supplier,
mv.mrp_controller,
mv.mrp_type,
kl.ANLAGE_AGG,
case
    when cp.CONTRACT_PART ='YES' then 'YES'
    else 'NO'
    end as CONTRACT_PART ,
s.PLANT_SPECIFIC_STATUS,
mv.location
from MM_MATERIAL_VIEW_ALL_EN mv
    inner join (
                -- Einschränkung auf nur 300mm VIH alle Materialen nur  300mm VIH aus Klassifizierung
                select distinct
                Objekt,
                anlage_agg
                from MM_KLASSE_MAT_VIH_EXP
                where wafer_durchmesser like ('%12%')
                -- 5288 Materialien -> nach Abgleich mit Materialview all sindes noch 5030 Datensätze
                ) kl on kl.objekt = mv.material
    left OUTER join MM_CONTRACT_SPARES_FE cp
                on cp.material = mv.material and cp.location = mv.location
    left OUTER join MM_STAMMDATEN_ALLE_WERKE_EN s
                on s.material = mv.material and s.location = mv.location
where mv.location =  'VIH' and mv.mm_group = 'SPARE'
Order by mv.stock_value DESC
-- INFO
-- Spares VIH 16333 gesammt   ** where location =  'VIH' and mm_group = 'SPARE'
