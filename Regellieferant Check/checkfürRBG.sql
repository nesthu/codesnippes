-- selektierung der Materialen aus Stammdaten welche einen Regellieferant haben sollen
select
s.material,
s.materialkurztextde,
s.disponent,
mrp.EMPFAENGER,
s.dispomerkmal,
s.mart,
s.werksspez_materialstatus,
r.LIEFERANTNAME,
s.standort
from MM_STAMMDATEN_ALLE_WERKE s
    left join mm_disponenten_alle_werke mrp on s.standort = mrp.standort and s.disponent = mrp.DIPONENTENNR --21389
    left join (
                select material, lieferantname
                from mm_infosatz_alle_werke
                where regellieferant = 'X' and standort = 'RBG' and typ_infosatz = '0') r on r.material = s.material
where   s."LÖSCHKENNZEICHEN_WK" is null  and s.standort = 'RBG' and s.dispomerkmal in ('VB','ZK') and s.WERKSSPEZ_MATERIALSTATUS <> '05' or
        s."LÖSCHKENNZEICHEN_WK" is null  and s.standort = 'RBG' and s.dispomerkmal in ('VB','ZK') and s.WERKSSPEZ_MATERIALSTATUS is null

-- Materialien ohne aktiven Infosatz sollten auf 05 gestellt werden
-- Regellierant kann nur ein Normaler Infosatz sein -> zu jeden Konsi-Infosatz muss es auch einen Normalen Infosatz geben !!
-- gilt es noch weiter zu prüfen
  -- es erscheinen alle Stammdaten welche auch noch keinen Infosatz haben und WS noch nicht auf 05
-- Emde Stammdaten selektierung
