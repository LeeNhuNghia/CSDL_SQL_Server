use QLSV2
/*Câu 1.  Xây dựng thủ  tục:  sp_BaoCao_Diem  với 1 tham số  vào là MaSV, 
dùng để  xem chi tiết điểm của sinh viên đó, thông tin gồm: MaSV, MaMon, Diem.*/
create proc sp_BaoCao_Diem
	@masv char(4)
as
	select * from ketqua where masv=@masv
----
exec sp_BaoCao_Diem 'A001'
exec sp_BaoCao_Diem 'C001'

/*Câu  2.  Xây dựng thủ  tục: sp_BaoCao_SinhVien dùng để
  xuất Điểm trung bình của 1 sinh viên, với 1 tham số vào là MaSV cần báo cáo,
  1 tham số ra là DTB là Trung bình các điểm thi của sinh viên này.
	Lưu ý: Viết lệnh gọi thủ tục và xuất giá trị DTB*/
create proc sp_BaoCao_SinhVien
	@masv char(4),
	@dtb real output
as
	set @dtb=(select AVG(diem) from ketqua where masv=@masv)
---
declare @tb real
exec sp_BaoCao_SinhVien 'A001',@tb output
print @tb

declare @tb real
exec sp_BaoCao_SinhVien 'C001',@tb output
print @tb
/*Câu 3.  Xây dựng Trigger  Tg_MONHOC_Them  khi thêm mới dữ  liệu vào bảng  MONHOC. 
Trong đó, cần kiểm tra các ràng buộc dữ liệu phải hợp lệ như sau:
	+ MaMon, TenMon: phải duy nhất, không được trùng.
	+ SoTiet: phải >=0*/
create trigger tgMonhocThem on monhoc instead of insert
as
	declare @mamon char(4),@tenmon nvarchar(100), @SoTiet int
	select @mamon=mamon,@tenmon=tenmon,@sotiet=sotiet from inserted
	if exists(select * from monhoc where mamon=@mamon)
		begin
			print 'MAMON da co'
			return
		end
	if exists(select * from monhoc where tenmon=@tenmon)
		begin
			print 'TENMON bi trung'
			return
		end
	if @sotiet <0
		begin
			print 'SOTIET phai >=0' 
			return
		end
	insert into monhoc values (@mamon,@tenmon,@sotiet)
---
insert into monhoc values ('THCB','Tin hoc co ban',-60)
insert into monhoc values ('CSDL','Tin hoc co ban',-60)
insert into monhoc values ('CSDL','Co so du lieu',-60)
insert into monhoc values ('CSDL','Co so du lieu',105)
select * from monhoc

/*Câu 4.
a - Thêm cột XepLoai nVarChar(20) trong bảng SINHVIEN.
b -  Xây dựng  Trigger Tg_KETQUA_Them  khi thêm mới vào bảng  KETQUA. Trong đó, cần thực 
hiện các tính toán như sau (dữ liệu thêm vào xem như hợp lệ)
+ Cập nhật lại cột  DiemTB  trong bảng  SINHVIEN, với DiemTB là trung bình cộng các điểm của 
sinh viên đó trong bảng KETQUA.
+ Cập nhật lại cột  TSMon  trong bảng  SINHVIEN, với TSMon là Tổng số  môn của sinh viên đó đã 
dự thi trong bảng KETQUA.
+ Cập nhật lại cột XepLoai trong bảng SINHVIEN, với cách tính như sau:
Xếp loại:	Giỏi  nếu  DiemTB>=9
			Khá  nếu  9>DiemTB>=7
			TBình  nếu  7>DiemTB>=5
			Yếu  nếu  DiemTB<5 */

--4.a
alter table SINHVIEN
add XepLoai nvarchar(20)

--4.b
create trigger Tg_KETQUA_Them on ketqua for insert
as
	declare @masv char(4), @dtb real, @tsm int, @xl nvarchar(20)
	set @masv = (select masv from inserted)
	set @dtb = (select AVG(diem) from ketqua where masv = @masv)
	set @tsm = (select count(*) from ketqua where masv = @masv)
	if @dtb >= 9
		set @xl = N'Giỏi'
	if @dtb >= 7 and @dtb <9
		set @xl = N'Khá'
	if @dtb >= 5 and @dtb <7
		set @xl = N'Trung bình Khá'
	if @dtb < 5
		set @xl = N'Yếu'
	update SINHVIEN set DiemTB = @dtb, TSMon=@tsm, XepLoai=@xl where MaSV=@masv

---
insert into KETQUA values ('A001','NLKT',6)
insert into KETQUA values ('A002', 'NLKT',0.5)
insert into KETQUA values ('A003', 'NLKT',7)

select * from KETQUA
select * from SINHVIEN