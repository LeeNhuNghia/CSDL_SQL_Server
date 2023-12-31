use QuanLyVT
--C47
create trigger C47 on pxuat instead of delete
as
	declare @sopx char(4),
			@ngayxuat datetime
		select @sopx=sopx, @ngayxuat=ngayxuat from deleted
		if not exists (select * from pxuat where sopx=@sopx)
			begin
				print 'SOPX nay khong cos'
				return
			end
		if exists (SELECT * FROM tonkho where namthang=convert(char(6), @ngayxuat,112))
			begin
				print 'Du lieu da tinh ton kho. Khong xoa duoc!'
			end
		delete from ctpxuat where sopx=@sopx
		delete from pxuat where sopx=@sopx
---
delete from pxuat where sopx="Xxxx"
delete from pxuat where sopx="G001"

--C38 tự làm
--câu 49
create trigger C49 on pnhap instead of update
as
	declare @sopn char(4), @ngaynhap datetime, @sodh char(4), @ngaydh datetime
	select @sopn=sopn, @ngaynhap=ngaynhap, @sodh=sodh from inserted
	if not exists(select * from pnhap where sopn=@sopn)
		begin
			print 'SOPN này không có'
			return
		end
	set @ngaydh=(select ngaydh from dondh where sodh=@sodh)
	if @ngaynhap<=@ngaydh
		begin
			print 'Ngày nhập phải sau ngày: ' + convert(char(10), @ngaydh,103)
			return
		end
	
	update pnhap set ngaynhap=@ngaynhap where sopn=@sopn
		
---
update PNHAP set ngaynhap= '1/1/2003' where sopn='N001'
update PNHAP set ngaynhap= '8/1/2003' where sopn='N001'
update PNHAP set ngaynhap= '7/7/2003' where sopn='N002'


--c50
create trigger C50 on pxuat instead of update
as
	declare @sopx char(4), @ngayxuatnew datetime, @ngayxuatold datetime
	select @sopx=sopx, @ngayxuatnew= ngayxuat from inserted
	select @ngayxuatold = ngayxuat from deleted
	if not exists (select * from pxuat where sopx=@sopx)
		begin
			print 'SOPX nay khong co'
			return
		end
	if convert(char(6), @ngayxuatnew, 112)<> convert (char(6), @ngayxuatold,112)
		begin
			print 'NAMTHANG của ngày xuất không trùng với ngày xuất cũ'
			return
		end
	update pxuat set ngayxuat=@ngayxuatnew where sopx=@sopx
--
update pxuat set ngayxuat='3/3/2003' where sopx='X000'
update pxuat set ngayxuat='3/3/2003' where sopx='X001'
update pxuat set ngayxuat='1/19/2003' where sopx='X001'
--c51 về nhà làm(học ngày 4/10/2022)