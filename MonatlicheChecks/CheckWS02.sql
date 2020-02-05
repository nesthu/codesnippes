select  s.MATERIAL,
        s.MATERIALKURZTEXTDE,
        s.DISPONENT,
        d.EMPFAENGER as Disponent_Name,
        s.MELDEBESTAND,
        s.EIGENBESTAND,
        UA_1.Letzte_Bewegung,
        s.Hinweis
From (select
            MATERIAL,
            MATERIALKURZTEXTDE,
            DISPONENT,
            EIGENBESTAND,
            MELDEBESTAND,
            Case
               WHEN (MELDEBESTAND - EIGENBESTAND) < 1
                Then 'Erstbefüllung erfolgt, Bitte Status 02 entfernen / prüfen'
                WHEN M0 > 0 and (MELDEBESTAND - EIGENBESTAND) > 0
                Then '!! Bewegungen vorhanden, Bitte Status 02 entfernen / prüfen'
                WHEN M1 > 0 and (MELDEBESTAND - EIGENBESTAND) > 0
                Then '!! Bewegungen vorhanden, Bitte Status 02 entfernen / prüfen'
                Else ''
            End as HINWEIS
        From MM_MATERIAL_VIEW_DRS
        where WERKSSPEZ_MATERIALSTATUS = '02') S
Left Join (select
                Max (MATERIALNUMMER)as MATERIALNUMMER,
                Max(BUCHUNGSDATUM_BELEG) As Letzte_Bewegung
                From MM_MSEG_MATBELEG_12M_DRS
            Group by MATERIALNUMMER) UA_1 ON UA_1.MATERIALNUMMER = S.MATERIAL
left join MM_DISPONENTEN_DRS d on d.DIPONENTENNR = S.DISPONENT
where s.HINWEIS is not null
Order by
S.Disponent
