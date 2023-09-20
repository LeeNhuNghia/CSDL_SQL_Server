use QuanLyVT

CREATE trigger c45 on pnhap instead of insert
as
declare @sopn char(4),@ngaynhap datetime, @sodh char(4)
select @sopn=sopn,@ngaynhap=ngaynhap,@sodh=sodh from inserted

	if exists (select * from pnhap where @sopn=sopn)
		begin
			print 'SoNH nay da co'
			return
		end
	if not exists (select * from dondh where @sodh=sodh)
		begin
			print 'Khong co SODH nay'
			return
		end
	declare @ngaydh datetime
	set @ngaydh=(select ngaydh from dondh where @sodh=sodh)
	if @ngaynhap<=@ngaydh
		begin
			print 'Ngay nhap phai sau ngay dat: ' + convert(char(10),@ngaydh,103)
			return
		end
	insert into pnhap values (@sopn,@ngaynhap,@sodh)
----
insert into pnhap values ('N00x','1/1/2003','D004')
insert into pnhap values ('N004','1/18/2003','D002')
insert into pnhap values ('N005','1/1/2001','D002')

CREATE trigger c46 on ctpnhap instead of insert 
as
	declare @sopn char(4),@mavt char(4),@slnhap int,@dgnhap int
	select @sopn=sopn,@mavt=mavt,@slnhap=slnhap,@dgnhap=dgnhap from inserted
	
	if not exists (select * from pnhap where @sopn=sopn)
		begin
			print 'Khong co SOPN nay'
			return
		end
	if not exists (select * from ctpnhap where @mavt=mavt)
		begin
			print 'Khong co MAVT nay'
			return
		end
	if @dgnhap<=0
		begin
			print 'Don gia nhap hang >0'
			return
		end
	declare @sld int,@tsln int
	set @sld=(select sldat from ctdondh where @mavt=mavt)
	set @tsln=(select sum(slnhap) from ctpnhap where @sopn=sopn)
	if @slnhap>(@sld-@tsln)
		begin
			print 'So luong nhap khong hop le'
			return
		end
	if exists (select * from ctpnhap where @sopn=sopn and @mavt=mavt)
		begin
			print 'Dong chi tiet nay da co'
			return
		end
		
	insert into ctpnhap values (@sopn,@mavt,@slnhap,@dgnhap)
	
	insert into ctpnhap values ('N000','Gxxx',1400,-10)
	insert into ctpnhap values ('N001','Gxxx',1400,-10)
	insert into ctpnhap values ('N001','G001',1400,-10)
	insert into ctpnhap values ('N001','G001',1400,100)
	insert into ctpnhap values ('N001','G001',0,100)
	insert into ctpnhap values ('N004','G001',300,100)