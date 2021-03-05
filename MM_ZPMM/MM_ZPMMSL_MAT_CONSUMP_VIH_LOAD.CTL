options (direct=TRUE, skip=3,SKIP_UNUSABLE_INDEXES=false) 

load data

characterset utf8 --WE8PC850 --utf8 --WE8ISO8859P1
INFILE '\\mucsdn31.eu.infineon.com\sapreports_drs_ux\_REPORTS\ZPMMSL_MAT_CONSUMPTION\VIH.txt' BADFILE '\\SAPreports.drs.infineon.com\SAP$\_REPORTS_MM\upload_database\MM_ZPMMSL_MAT_CONSUMPTION\LOGFILES\MM_ZPMMSL_MAT_CONSUMP_VIH_.bad' DISCARDFILE '\\SAPreports.drs.infineon.com\SAP$\_REPORTS_MM\upload_database\MM_ZPMMSL_MAT_CONSUMPTION\LOGFILES\MM_ZPMMSL_MAT_CONSUMP_VIH_.dis'   
insert --Tabelle muss vorher leer sein! Wird durch Update Prozedure gewährleistet
into table MM_DATA_ADMIN.MM_ZPMMSL_MAT_CONSUMP_VIH_LOAD
fields terminated by '|'
TRAILING NULLCOLS
(
	LEER,
	EQUIPMENT_SHORT, -- (2:42),
	TECHN_PLATZ, -- (44:71),
	AUFTRAG, -- (73:79),
	TYPE, -- (81:84),
	MATERIAL, -- (86:98),
	BEZEICHNUNG1, -- (100:139),
	BEZEICHNUNG2, -- (141:180),
	MART, -- (182:185),
	MENGE, -- (187:196),
	MENGENEINHEIT, -- (199:202),
	BETRAG_HAUSWAEHRUNG, -- (204:217),
	STD_PRICE, -- (219:231),
	BUCHUNGSDATUM_BELEG, -- (233:242),
	ENDE_GARANTIE, -- (244:253),
	BEWERTUNGSKLASSE, -- (255:259),
	KLASSE, -- (261:271),
	CLASSTYPE, -- (273:281),
	MERKMAL1, -- (283:300),
	MERKMALSWERT1, -- (302:331),
	MERKMAL2, -- (333:355),
	MERKMALSWERT2, -- (357:386),
	LIEFERANTNR, -- (388:400),
	LIEFERANTNAME, -- (402:431),
	CHARGE, -- (433:442),
	MVT, -- (444:446),
	COST_CTR, -- (448:455),
	LAST_UPDATE EXPRESSION "current_timestamp(3)"
)
