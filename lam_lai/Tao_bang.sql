use QL_VatTu_14
---------------
--Table VATTU
create table VATTU
(MaVT char(4), TenVT nvarchar(100), DVTinh nvarchar(10), PhanTram real
Constraint Uni_VATTU unique (TenVT),
Constraint Chk_VATTU check (PhanTram >=0 and PhanTram<=100),
Constraint Pri_VATTU primary key (MaVT),
)
select *from VATTU
--Table NHACC
create table NHACC
(MaNhaCC char(4), TenNhaCC nvarchar(100), DiaChi nvarchar(200), DienThoai Varchar(20)
Constraint Uni_NHACC unique (TenNhaCC),
Constraint Pri_NHACC primary key (MaNhaCC)
)
select *from NHACC
--Table DONDH
create table DONDH
(SoDH char(4), NgayDH Datetime, MaNhaCC char(4)
Constraint Pri_DONDH primary key (SoDH)
)
select *from DONDH

--Table CTDONDH
create table CTDONDH
(SoDH char(4), MaVT char(4), SLDat int
Constraint Pri_CTDONDH primary key(SoDH, MaVT),
Constraint Chk_CTDONDH check(SLDat >=0)
)
select *from CTDONDH

--Table PNHAP
create table PNHAP
(SoPN char(4), NgayNhap datetime, SoDH char(4)
Constraint Pri_PNHAP primary key(SoPN),
)
select *from PNHAP

--Table CTPNHAP
create table CTPNHAP
(SoPN char(4), MaVT char(4), SLNhap int, DgNhap int
Constraint Pri_CTPNHAP primary key(SoPN, MaVT),
Constraint Chk_CTPNHAP check(SLNhap >=0),
Constraint Chk_CTPNHAP check(DgNhap >=0),
)
select *from CTPNHAP