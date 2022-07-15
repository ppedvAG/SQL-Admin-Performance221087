set statistics io, time on
select country, sum(unitprice *quantity) from ku
group by country option (maxdop 6)

--Table Scan.. 2 Pfeile


--4 Kerne lt den Zeiten , CPU-Zeit = 421 ms, verstrichene Zeit = 113 ms.
--hat es sich gelohnt

--auch in DB konfigurierbar

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 6;
GO

--8 Kerne: Zeit = 609 ms, verstrichene Zeit = 102 ms
--1 Kern: , CPU-Zeit = 281 ms, verstrichene Zeit = 291 ms.



EXEC sys.sp_configure N'cost threshold for parallelism', N'25'
GO
EXEC sys.sp_configure N'max degree of parallelism', N'4'
GO
RECONFIGURE WITH OVERRIDE
GO


--TIPP... Kostenschwellwert auif 25 stellen.. OLAP
---- OLTP   50