--Tao bang
use QLSV2
--Bang LOPHOC
create table LOPHOC
(MaLop Char(4), TenLop NvarChar(100), 
 SiSo Int constraint Def_siso default 0,
 constraint Pri_LopHoc primary key (malop),
 constraint Uni_tenlop unique (tenlop),
 constraint Chk_siso check (siso>=0)
)
--Bang MONHOC
create table MONHOC
(MaMon Char(4), TenMon NvarChar(100), SoTiet Int, 
 constraint Pri_MonHoc primary key (mamon),
 constraint Uni_tenmon unique (tenmon),
 constraint Chk_sotiet check (sotiet>=0)
)
--Bang SINHVIEN
create table SINHVIEN
(MaSV Char(4), Hotensv NvarChar(50), NgaySinh DateTime, Phai Bit, 
 MaLop Char(4), DiemTB Real, TSMon Int,
 constraint Pri_sinhvien primary key (masv),
 constraint For_sinhvien_lophoc foreign key (malop) references lophoc(malop)
)
--Bang KETQUA
create table KETQUA
(MaSV Char(4), MaMon Char(4), Diem Real,
 constraint Pri_ketqua primary key (masv,mamon),
 constraint Chk_diem check (diem>=0 and diem<=10),
 constraint For_ketqua_sinhvien foreign key (masv) references sinhvien(masv),
 constraint For_ketqua_monhoc foreign key (mamon) references monhoc(mamon)
)
