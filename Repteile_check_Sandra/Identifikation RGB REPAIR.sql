--MM_CHECK_REPAIR_POTENTIAL   UPDATE_CHECK_REPAIR_POTENTIAL
select
st.LOCATION,
st.MATERIAL,
st.MATERIAL_DESCRIPTION_DE,
st.MATERIAL_DESCRIPTION_Z1,
st.MRP_CONTROLLER,
st.MRP_TYPE,
st.PLANT_SPECIFIC_STATUS,
mv."12M_CONSUMPTION",
mv.CONSUMPTION_EUR_12M,
st.LINKED_REPAIR_MATERIAL
from (
--RBG
select
LOCATION as "LOCATION",
MATERIAL as MATERIAL,
MATERIALKURZTEXTDE as MATERIAL_DESCRIPTION_DE,
MATERIALKURZTEXTZ1 as MATERIAL_DESCRIPTION_Z1,
DISPONENT as MRP_CONTROLLER,
DISPOMERKMAL as MRP_TYPE,
WERKSSPEZ_MATERIALSTATUS as PLANT_SPECIFIC_STATUS,
RMATERIAL as LINKED_REPAIR_MATERIAL
from (
      select
      'RBG' as LOCATION,
      s.MATERIAL,
      s.MATERIALKURZTEXTDE,
      s.MATERIALKURZTEXTZ1,
      s.DISPONENT,
      s.DISPOMERKMAL,
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
     MATERIALKURZTEXTDE,
     MATERIALKURZTEXTZ1,
     DISPONENT,
     DISPOMERKMAL,
     WERKSSPEZ_MATERIALSTATUS,
     RMaterial
     from (
           select
           s.MATERIAL,
           s.MATERIALKURZTEXTDE,
           s.MATERIALKURZTEXTZ1,
           s.DISPONENT,
           s.DISPOMERKMAL,
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
    MATERIALKURZTEXTDE,
    MATERIALKURZTEXTZ1,
    DISPONENT,
    DISPOMERKMAL,
    WERKSSPEZ_MATERIALSTATUS,
    RMaterial
    from (
          select
          s.MATERIAL,
          s.MATERIALKURZTEXTDE,
          s.MATERIALKURZTEXTZ1,
          s.DISPONENT,
          s.DISPOMERKMAL,
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
      MATERIALKURZTEXTDE,
      MATERIALKURZTEXTZ1,
      DISPONENT,
      DISPOMERKMAL,
      WERKSSPEZ_MATERIALSTATUS,
      RMaterial
      from (
            select
            s.MATERIAL,
            s.MATERIALKURZTEXTDE,
            s.MATERIALKURZTEXTZ1,
            s.DISPONENT,
            s.DISPOMERKMAL,
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
)
where RMaterial is not null
) st
left outer join MM_MATERIAL_VIEW_ALL_EN mv on mv.MATERIAL = st.MATERIAL and st."LOCATION" = mv.LOCATION
order by mv.CONSUMPTION_EUR_12M DESC
