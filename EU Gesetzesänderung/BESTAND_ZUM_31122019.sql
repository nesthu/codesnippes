select 
material,
FREI,
QM,
UNFREI,
GESPERRT,
FREI + QM + UNFREI + GESPERRT as KONSIGNMENT_STOCK,
LAST_UPDATE
from (
    select
                material,
                sum(to_number(konsibest_frei)) as FREI,
                sum(to_number(konsibest_qpruefung))as QM,
                sum(to_number(konsibest_unfrei)) as UNFREI,
                sum(to_number(konsibest_gesperrt))as GESPERRT,
                max(last_UPDATE) as LAST_UPDATE
            from mm_bestand_drs
            group by material
    )
