-- Materialnummern welche in RBG nicht repariert werden
select
s.MATERIAL,
s.WERKSSPEZ_MATERIALSTATUS
from MM_STAMMDATEN_RBG s
where      "LÖSCHKENNZEICHEN_WK" is null and WERKSSPEZ_MATERIALSTATUS is null
        or "LÖSCHKENNZEICHEN_WK" is null  and WERKSSPEZ_MATERIALSTATUS <>'R';
