-- Liste DRS mit allen 300mm Spares Teilen
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
                -- alle Materialen 300mm DRS MART start mit 3
                select
                material,
                location,
                plant_specific_status
                from MM_STAMMDATEN_ALLE_WERKE_EN
                where location = 'DRS' and substr(material_type,1,1) = '3'
                -- 6503 Materialien -> nach Abgleich mit Materialview all sindes noch 5030 Datensätze
                ) s on s.material = mv.material and s.location = mv.location
    left OUTER join MM_CONTRACT_SPARES_FE cp
                on cp.material = mv.material and cp.location = mv.location
    left outer join MM_KLASSE_MAT_DRS kl
                on kl.objekt = mv.material
where mv.location =  'DRS' and mv.mm_group = 'SPARE'
Order by mv.stock_value DESC
-- INFO
-- Spares DRS 31013 gesammt   ** where location =  'DRS' and mm_group = 'SPARE'
