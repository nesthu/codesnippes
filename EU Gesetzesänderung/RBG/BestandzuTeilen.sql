select
lr.Material,
lr.Konsibestand,
vb.konsibestand as MEINKONSIBESTAND,
vb.konsi_gesperrt
from CHECK_MAT_EU_STEUER_RBGCN lr
  left outer join (
                select
                material,
                konsibestand,
                konsi_gesperrt
                from MM_BESTAND_HISTORIE_ALLE_WERKE
                where standort = 'RBG' and last_update like '%01.01.19%'
                ) vb on vb.material = lr.Material
