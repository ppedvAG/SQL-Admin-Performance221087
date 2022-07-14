/*

DATEIGRUPPE

Dateigruppe = Pfad und Datei 
PRIMARY (Systemtabellen)

*/

create table test(id int) ---> mdf

create table test(id int) on 'c.\prgam files\msssqlserver\15\data\hotdata.ndf'


create table testxy(id int) on ARCHIV


---UMSATZ
--A    B
--sind total gleich
--A 1000    B 100000
--Abfrage liefert auf A und auf B 10 Zeilen
--Welche Tabelle liefert schneller Ergebnisse: 


---aus UMSATZ --> u2022  u2021  u2020  u2019...

---Abfrage auf UMSATZ?

select * from umsatz where jahr = 2021

create view umsatz
as
select * from u2022
UNION ALL--keine Suche nach doppelten
select * from u2021
UNION ALL
select * from u2020
UNION  ALL
select * from u2019

select * from umsatz

ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019_1 CHECK (jahr=2022)

select * from umsatz where jahr = 2020
select * from umsatz where id = 2020


--SELECT ..cool
--INS UP DEL: kein identity, der PK muss eindeutig über die Sicht werden

--Besser : PARTITIONIERUNG

CREATE DATABASE [DEMODB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DEMODB', FILENAME = N'D:\_SQLDBDATA\DEMODB.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB ), 
 FILEGROUP [bis100] 
( NAME = N'd_bis100', FILENAME = N'D:\_SQLDBDATA\d_bis100.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB ), 
 FILEGROUP [bis200] 
( NAME = N'd_bis200', FILENAME = N'D:\_SQLDBDATA\d_bis200.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB ), 
 FILEGROUP [bis5000] 
( NAME = N'd_bis5000', FILENAME = N'D:\_SQLDBDATA\d_bis5000.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB ), 
 FILEGROUP [Rest] 
( NAME = N'd_rest', FILENAME = N'D:\_SQLDBDATA\d_rest.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DEMODB_log', FILENAME = N'D:\_SQLDBLOG\DEMODB_log.ldf' , SIZE = 8192KB , FILEGROWTH = 1024KB )
GO


use demodb

---------100----------------200------------------------

create partition function fzahl(int)
as
RANGE  LEFT FOR VALUES(100,200)


select $partition.fzahl(117)--2


--Part Schem

create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
---                             1            2      3


create table ptab
		(id int identity, nummer int, spx char(4100)) ON schZahl(nummer)


declare @i as int = 1

while @i<=20000
	begin
			insert into ptab (nummer, spx) values (@i, 'XY')
			set @i+=1
	end


--Hat sich das gelohnt?????
set statistics io, time on --Seitenzahl, CPU ms  Dauer ms
select * from ptab where nummer = 1170
select * from ptab where id = 117


--Part hat sich leider als nicht besonders ausgewogen erwiesen
--daher neuer Grenze 5000
--TAB,		DGR,				F(),            Scheme
--  nie    neue Dgr          5000           neue DGr
--zuerst DGruppe
--Schema
--f()

select			$partition.fzahl(nummer) , 
					min(nummer), max(nummer),count(*)  
from ptab group by $partition.fzahl(nummer)

alter partition scheme schZahl next used bis5000

alter partition function fzahl() split range (5000)

select * from ptab where nummer = 1117

--Grenze weg: 100 

--TAB          DGR         f()             scheme
--neee        nööö         jupp         nee

alter partition function fzahl()  merge range (100)


select * from ptab

--SCAN: alles lesen  a bis z
--SEEK:  herauspicken anhand eines Verzeichnisses
--HEAP = unsortierte Tabelle

select * from ptab
select * from ptab where nummer = 6137

select * from ptab where id = 10


--Archivierung
--Archivtabellen muss das absolut gleiche Design haben
--also auch not und null, aber kein identity
create table archiv(id int not null, nummer int, spx char(4100)) 
on bis200

alter table ptab switch partition 1 to archiv

select * from archiv
select * from ptab

--MUSS: Archiv und Partition müssen auf derselben Dateigruppe sein
select * from ptab where id =1117



-----FRAGEN

--Jahresweise
create partition function fDatum(datetime) --varchar ja  XML  nein
as
RANGE  LEFT FOR VALUES('','31.12.2020 23:59:59.997',''......)


--JKunden von a bis M   n bis R    s bis Z
create partition function fBuchstaben(varchar(50)) --varchar ja  
as
RANGE  LEFT FOR VALUES('N','S')

--Part Schem

create partition scheme schZahl
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])


create partition scheme schZahl
as
partition fzahl all to ([PRIMARY])
1            2      3