--DRS 1451 Materialnummern zu Reparaturteilen (Werksstatus R)
    select
    Material,
    'DRS' as LOCATION
    from MM_STAMMDATEN_DRS
    where "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS = 'R'

union

--VIH 740 Materialnummern zu Reparaturteilen (Werksstatus R)
    select
    Material,
    'VIH' as LOCATION
    from MM_STAMMDATEN_VIH
    where "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS = 'R'

union

--RBG 646 Materialnummern zu Reparaturteilen (Werksstatus R)
    select
    Material,
    'RBG' as LOCATION
    from MM_STAMMDATEN_RBG
    where "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS = 'R'

union

--KLM 0  KLM nutzt Status R aktuell nicht !! Materialnummern zu Reparaturteilen (Werksstatus R)
    select
    Material,
    'KLM' as LOCATION
    from MM_STAMMDATEN_KLM
    where "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS = 'R';
