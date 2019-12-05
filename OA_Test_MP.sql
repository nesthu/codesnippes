select *
FROM (
        Select distinct
                UA.*,
                first_value(UA.EINKAEUFERGRUPPE) OVER (PARTITION BY UA.LIEFERANTNR  ORDER BY UA.Anzahl_Material DESC ROWS UNBOUNDED PRECEDING) AS ERGEBNIS
        from (select
                    LIEFERANTNR,
                    EINKAEUFERGRUPPE,
                    count(*) as Anzahl_Material
                    from MM_OA_LIST_DRS
                    group by LIEFERANTNR, EINKAEUFERGRUPPE
                    ORDER by LIEFERANTNR, count(*) DESC) UA
)
where EINKAEUFERGRUPPE = ERGEBNIS
order by LIEFERANTNR ASC
