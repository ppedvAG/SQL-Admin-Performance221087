--Datenbanken

/*
trenne Daten von Log.. mit eig HDDs
Anfangsgr��e (lebenszeit)
Wachstumsrate  1000MB vor allem beim Logfile



dbcc loginfo('northwind')

--1 wieviel ist frei? 
--2. leeren des Logfiles - TP Sicherung / Wiederherstellungsmodel: einfach
--3 checkpoint
--4 Startgr��er auf deutlich kleineren Wert setzen zb 1 MB
--5: Korrekte Gr��e konfigurireren (zb 30% der Datendatei

Zeilenversionierung
--Kopie des DS in die Tempdb bevor die �nderugn stattfindet

--> ein UP hindert das Lesen nicht mehr

USE [master]
GO
ALTER DATABASE [DataWareHouse] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO
ALTER DATABASE [DataWareHouse] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
