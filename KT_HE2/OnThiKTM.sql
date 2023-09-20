use OnTapHetMon

-------I. VIEW
---1.
create view Vw1
as
	select CTPNhap.MaVT, TenVT, SUM(slnhap) as TongSLN
	from CTPNhap inner join VATTU on VATTU.MaVT=CTPNhap.MaVT
	group by CTPNhap.MaVT, TenVT

	select * from Vw1
---2.
create view Vw2
as
	select CTDONDH.MaVT, TenVT, sum(sldat) as TongSLDat
	from CTDonDH inner join VATTU on VATTU.MaVT=CTDonDH.MaVT
	group by CTDonDH.MaVT, TenVT
	having CTDONDH.mavt not in(select mavt from CTPNhap)

	select * from Vw2
---3.
create view Vw3
as
	select CTPXUAT.MaVT, TenVT, sum(SlXuat) as TSLXuat
	from CTPXUAT inner join VATTU on VATTU.MaVT=CTPXUAT.MaVT
	group by CTPXUAT.MaVT, TenVT

	select * from Vw3

--4.
create view Vw4
as
	select CTPNhap.MaVT, TenVT, SUM(SlNhap) as TongSLNhap
	from ((CTPNhap inner join VATTU on VATTU.MaVT=CTPNhap.MaVT)
			inner join CTPXUAT on CTPXUAT.MaVT=VATTU.MaVT)
	group by CTPNhap.MaVT, TenVT
	having CTPXUAT.MaVT not in(select mavt from CTPXUAT)
	select * from Vw4
---5.
create view Vw5
as
	select CTDONDH.MaVT, TenVT, SUM(SlDat) as TSLDat
	from CTDONDH inner join VATTU on VATTU.MaVT=CTDONDH.MaVT
	group by CTDONDH.MaVT, TenVT

	select * from Vw5

---6.
create view Vw6
as
	select CTDONDH.MaVT, TenVT, sum(sldat) as TongSLDat
	from CTDonDH inner join VATTU on VATTU.MaVT=CTDonDH.MaVT
	group by CTDonDH.MaVT, TenVT
	having CTDONDH.mavt not in(select mavt from CTPNhap)

	select * from Vw6

-------II. THỦ TUC: 
---1.
create proc SPUD_1
	@MaVTu char(4),
	@TongSLNhap int output
as
	set @TongSLNhap = (select SUM(SlNhap) from CTPNhap where MaVT=@MaVTu)
--
declare @ts int
exec SPUD_1 'SN01', @ts output
print @ts
---2.
create proc SPUD_2
	@SoDH char(4)
as
	if exists( select * from PNhap where SoDH=@SoDH)
	begin
		print N'SỐ ĐẶT HÀNG NÀY ĐÃ ĐƯỢC NHẬP HÀNG! KHÔNG XÓA ĐƯỢC'
		return
	end
