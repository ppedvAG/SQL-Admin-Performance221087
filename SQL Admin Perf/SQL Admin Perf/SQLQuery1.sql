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