use QuanLyVT
select VATTU.* 
into VatTu_Thung
from VATTU
where DVTinh=N'Thùng'

select * from VatTu_Thung

insert into VatTu_Thung
select VATTU.* from VATTU where DVTinh='Kg'
