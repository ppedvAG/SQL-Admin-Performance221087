/*Installation

MAX RAM 
	--> f�r OS vorreservieren (2 bis 10GB)


PFADE:  trenne Daten von Logfile pro DB neu �berlegen (extra HDDs)
--> Muss man sp�ter mal messen: 
			--> Perfmon (Datenr�gerwarteschlangenl�nge)


Volumemwartungstask
kein Ausnullen bei Verrg��erungen der Datendatein
aber Admin sollte auf gute Anfangsgr��en achten (lebenszeit)


TempDB
eig HDDs und trennen der Daten und Logfile

Auslagern bei RAM Mangel
#tabellen
Zeilenversionierung
IX Rebuild

--t1117   gleiches Wachstum der DAtendateien -t1118 Uniform xtents
Anz der Datendateien = Anzahl der Kerne = Max 8




MAXDOP
Anzahl der Keren , die bei einer Abfrage max eingesetzt wird
max = 8 sonst anzahl der kerne
fr�her 0 , was schlichtweg Wahnsinn ist







