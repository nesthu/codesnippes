-- Gleichteile zwischen DRS und VIH
select *
from HLP_PN_ZU_MATERIAL_SEARCH
where material_search like '%DRS%' and material_search like '%VIH%'
