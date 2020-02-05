select
   L.Material,
   L.Summe_Bestand,
   B.KONSIBESTAND_SUM
From(select
        L.MATERIAL,
        SUM(TOTAL_VALUATED_STOCK) as Summe_Bestand
        from MM_LAGERLIST_DRS L
        group by
        L.Material
        Order by
        L.Material) L
Left join MM_BESTAND_DRS B On l.material = b.material
where B.KONSIBESTAND_SUM >'0' and L.Summe_Bestand <> B.KONSIBESTAND_SUM
