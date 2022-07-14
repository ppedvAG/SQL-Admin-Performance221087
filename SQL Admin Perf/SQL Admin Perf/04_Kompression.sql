/* Kompression

seiten bzw Zeilenkompression
*/

select * into kompTab from ptab


--Auswirkung der Kompression



--NEUSTART   301 MB
--RAM des SQLServr.exe 

select * into nktab from komptab

set statistics io, time on

select * from demodb..nktab
--Seiten:  19800   CPU:  296    Dauer:  1172
--RAM:  mind +160MB







--NEUSTART   weniger oder gleich
--RAM des SQLServr.exe 

select * into nktab from komptab

set statistics io, time on

select * from demodb..komptab
--Seiten: weniger  CPU: weniger  Dauer: weniger
--RAM: weniger oder gleich

--Seiten:  33   CPU:  219   Dauer:  1172
--RAM:  mind +160MB

--wir bezahlen RAM mit CPU Leistung

select * from ptab where id = 10