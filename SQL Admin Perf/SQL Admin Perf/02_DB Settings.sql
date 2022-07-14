--Datenbanken

/*
trenne Daten von Log.. mit eig HDDs
Anfangsgröße (lebenszeit)
Wachstumsrate  1000MB vor allem beim Logfile



dbcc loginfo('northwind')

--1 wieviel ist frei? 
--2. leeren des Logfiles - TP Sicherung / Wiederherstellungsmodel: einfach
--3 checkpoint
--4 Startgrößer auf deutlich kleineren Wert setzen zb 1 MB
--5: Korrekte Größe konfigurireren (zb 30% der Datendatei

Zeilenversionierung
--Kopie des DS in die Tempdb bevor die Änderugn stattfindet

--> ein UP hindert das Lesen nicht mehr

USE [master]
GO
ALTER DATABASE [DataWareHouse] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO
ALTER DATABASE [DataWareHouse] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
