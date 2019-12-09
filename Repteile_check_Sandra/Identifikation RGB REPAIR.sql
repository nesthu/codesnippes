--RBG
select
LOCATION,
Material,
WERKSSPEZ_MATERIALSTATUS,
RMaterial
from (
      select
      'RBG' as LOCATION,
      s.MATERIAL,
      s.WERKSSPEZ_MATERIALSTATUS,
      ma.RMATERIAL
      from MM_STAMMDATEN_RBG s
              left join (select
              am.LIEFERANTMATERIAL,
              am.MATERIAL_SEARCH as ALLMATERIAL,
              rp.MATERIAL_SEARCH as RMATERIAL
              from HLP_PN_ZU_MATERAL_SEARCH am
                  left join HLP_PN_ZU_RMATERAL_SEARCH rp on rp.LIEFERANTMATERIAL = am.LIEFERANTMATERIAL) ma
                  on ma.ALLMATERIAL LIKE ('%' || s.MATERIAL || '%')
      where      "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS is null
              or "LÖSCHKENNZEICHEN_WK" is null  and WERKSSPEZ_MATERIALSTATUS <>'R'
      ) where RMaterial is not null

union
 -- DRS
     select
     'DRS' as LOCATION,
     Material,
     WERKSSPEZ_MATERIALSTATUS,
     RMaterial
     from (
           select
           s.MATERIAL,
           s.WERKSSPEZ_MATERIALSTATUS,
           ma.RMATERIAL
           from MM_STAMMDATEN_DRS s
                   left join (select
                   am.LIEFERANTMATERIAL,
                   am.MATERIAL_SEARCH as ALLMATERIAL,
                   rp.MATERIAL_SEARCH as RMATERIAL
                   from HLP_PN_ZU_MATERAL_SEARCH am
                       left join HLP_PN_ZU_RMATERAL_SEARCH rp on rp.LIEFERANTMATERIAL = am.LIEFERANTMATERIAL) ma
                       on ma.ALLMATERIAL LIKE ('%' || s.MATERIAL || '%')
           where      "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS is null
                   or "LÖSCHKENNZEICHEN_WK" is null  and WERKSSPEZ_MATERIALSTATUS <>'R'
           ) where RMaterial is not null
union
-- KLM
    select
    'KLM' as LOCATION,
    Material,
    WERKSSPEZ_MATERIALSTATUS,
    RMaterial
    from (
          select
          s.MATERIAL,
          s.WERKSSPEZ_MATERIALSTATUS,
          ma.RMATERIAL
          from MM_STAMMDATEN_KLM s
                  left join (select
                  am.LIEFERANTMATERIAL,
                  am.MATERIAL_SEARCH as ALLMATERIAL,
                  rp.MATERIAL_SEARCH as RMATERIAL
                  from HLP_PN_ZU_MATERAL_SEARCH am
                      left join HLP_PN_ZU_RMATERAL_SEARCH rp on rp.LIEFERANTMATERIAL = am.LIEFERANTMATERIAL) ma
                      on ma.ALLMATERIAL LIKE ('%' || s.MATERIAL || '%')
          where      "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS is null
                  or "LÖSCHKENNZEICHEN_WK" is null  and WERKSSPEZ_MATERIALSTATUS <>'R'
          ) where RMaterial is not null
union
--VIH
      select
      'VIH' as LOCATION,
      Material,
      WERKSSPEZ_MATERIALSTATUS,
      RMaterial
      from (
            select
            s.MATERIAL,
            s.WERKSSPEZ_MATERIALSTATUS,
            ma.RMATERIAL
            from MM_STAMMDATEN_VIH s
                    left join (select
                    am.LIEFERANTMATERIAL,
                    am.MATERIAL_SEARCH as ALLMATERIAL,
                    rp.MATERIAL_SEARCH as RMATERIAL
                    from HLP_PN_ZU_MATERAL_SEARCH am
                        left join HLP_PN_ZU_RMATERAL_SEARCH rp on rp.LIEFERANTMATERIAL = am.LIEFERANTMATERIAL) ma
                        on ma.ALLMATERIAL LIKE ('%' || s.MATERIAL || '%')
            where      "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS is null
                    or "LÖSCHKENNZEICHEN_WK" is null  and WERKSSPEZ_MATERIALSTATUS <>'R'
            ) where RMaterial is not null
