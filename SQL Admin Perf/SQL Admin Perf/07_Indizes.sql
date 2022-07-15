/*---------Indizes

NON CL
Kopie der Daten
kann pro Tabelle mehrfach erstellt werden ca 1000
identische oder überlappende sollte eliminiert werden
--> Script Brent Ozar sp_blitzIndex
--Vermeide Lookup

Einsatzgebiet: bei rel geringer Ergebnismenge
--relativ: unter 1% auch 90% möglich
--was ist meist wenig:ID, PK

select * from customers
insert into customers (customerid, companyname)
values
								('ppedv', 'Fa ppedv')


CL IX
= Tabelle in sortierter Form
1 mal Tabelle
Einsatzbereich: Bereichssuchen!!! between > < A%
keine Lookups
immer zuerst CL IX festlegen, alles andere kann nur noch NON CL sein

eindeutige Indizes
ind Spalte.. Wert darf nur einmal vorkommen

zusammengesetzer IX
mehr Spalten im IX
erste Spalte ist entscheidend. Die muss in Where vorkommen

abdeckender IX
idealer IX ..reiner SEEK

COLUMNSTORE


*/
sp_blitzindex

set statistics io, time on
select * from ku where id = 10
--Table Scan mit 62000 Seiten

select id from ku where id = 10
--IX: CL IX auf orderdate
--IX: NIX_id-- 3 Seiten 0 ms

--Lookup + 1 Seiten
select id, freight from ku where id = 10

--ab ca 12500 TAB SCAN
--und bei größeren Mengen MAXDOP
select id, freight from ku where id <13000


--Zusammengestzter IX: NIX_ID_FR
select id, freight from ku where id <900000
--geht nun auch mit 90% und Seek
--abdeckender IX = idealer IX
--der zusm IX kann nur max 16 Spalten


--besser mit IX und eingeschlossen Spalten

select country, city, sum(unitprice*quantity)
from ku
where freight < 2 AND productid = 3
group by country,city


--Testtabellen .. Kopie der KU (keine IX in KU2 und KU3)
select * into KU2 from ku
select * into KU3 from ku



select top 3 * from ku2

--Where, AGG..

--Durschn Frachtkosten pro Kunde, aber nur die wo
--in Sao Paulo wohnen

select companyname, avg(freight)
from ku2
where city = 'Sao Paulo'
group by companyname
--NIX_city_incl_cnfr--> 414 Seiten  16/17ms

select companyname, avg(freight)
from ku3
where city = 'Sao Paulo'
group by companyname
--ok.. deutlich besser

select companyname, city,avg(freight)
from ku2
where shipcity = 'London'
group by companyname, city

select companyname, city,avg(freight)
from ku3
where shipcity = 'London'
group by companyname, city
