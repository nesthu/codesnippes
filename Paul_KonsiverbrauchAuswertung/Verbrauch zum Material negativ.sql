select
materialnr,
0-change_in_stock as consumption,
TRUNC(TO_DATE(month_year),'MM') as DATUM
from MM_ZHMDMAVL_DRS
