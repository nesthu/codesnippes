-- UNION + LinkedPN dazu
select distinct
p.material,
p.material_description_de,
p.stock_value,
p.total_stock,
p.reorder_point,
p.net_price_in_eur,
p.vendor_number,
p.vendor_name,
p.current_oem_supplier,
p.mrp_controller,
p.mrp_type,
p.ANLAGE_AGG,
p.CONTRACT_PART ,
p.PLANT_SPECIFIC_STATUS,
p.PICKS,
mp.LINKED_PN,
case
    when mp.LINKED_PN is null then 'NO'
    when pm.material_search is null then 'NO'
    else pm.material_search
    end as LINKED_MATERIAL,
p.location
from (
        -- Liste mit allen 300MM Spares DRS und VIH
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
                mv.PICKS,
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
                -- INFO
                -- Spares DRS 31013 gesammt   ** where location =  'DRS' and mm_group = 'SPARE'
                union

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
                mv.PICKS,
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

                -- INFO
                -- Spares VIH 16333 gesammt   ** where location =  'VIH' and mm_group = 'SPARE'
) p
    left outer join HLP_MATERIAL_ZU_PN_SEARCH mp
        on mp.material = p.material and mp.location = p.location
    left outer Join (
    select
                lieferantmaterial,
                material_search
                from HLP_PN_ZU_MATERIAL_SEARCH
                where material_search like '%DRS%' and material_search like '%VIH%'
                ) pm
        on pm.lieferantmaterial like ('%' || mp.LINKED_PN || '%')
--Order by STOCK_VALUE DESC
