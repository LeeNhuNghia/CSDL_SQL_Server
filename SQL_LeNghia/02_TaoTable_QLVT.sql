use QuanLyVT
------------------------------------
Create Table VATTU
(MaVT char(4), TenVT NVarChar(100), DVTinh Nvarchar(10), PhanTram Real,
Constraint Pri_Vattu primary key(mavt),
Constraint Uni_Tenvt unique(tenvt),
Constraint Chk_PhanTram check (phantram >=0 and phantram<=100)
) 

create Table TONKHO
(NamThang char(6), MaVT char(4), SLDau int, TongSLN int, TongSLX int, SLCuoi int,
Constraint NamThang_MaVT primary key(NamThang, MaVT),
Constraint For_TONKHO_VATTU Foreign key (mavt) references vattu(mavt)
)
--alter table TONKHO
--Add Constraint For_TONKHO_VATTU Foreign key (mavt) references vattu(mavt)

create Table NHACC
(MaNhaCC char(4), TenNhaCC Nvarchar(100), DiaChi Nvarchar(200), DienThoai Varchar(20),
Constraint Pri_MaNhaCC primary key(manhacc),
Constraint Uni_TenNhaCC Unique(TenNhaCC)
)

create Table DONDH
(SoDH char(4),NgayDH Datetime, MaNhaCC char(4),
 Constraint Pri_SoDH primary key(sodh),
 Constraint For_DONDH_NHACC Foreign key(manhacc) references nhacc(manhacc)
)

create Table CTDONDH
(SoDH char(4), MaVT char(4), SlDat int,
 Constraint Pri_SoDH_MaVT primary key(sodh, mavt),
 Constraint For_CTDONDH_DONDH Foreign key(sodh) references dondh(sodh),
 Constraint For_VATTU_CTDONDH Foreign key(mavt) references vattu(mavt),
 Constraint Chk_SlDat check(SlDat>0)
)

create Table PNHAP
(SoPN char(4), NgayNhap Datetime, SoDH char(4),
Constraint Pri_SoPN primary key(SoPN)
)

create Table CTPNhap
(SoPN char(4), MaVT char(4), SlNhap int, DgNhap int,
 Constraint Pri_SoPN_MaVT primary key(sopn, mavt),
 Constraint For_CTPNHAP_PNhap Foreign key(sopn) references PNhap(sopn),
 Constraint For_CTPNHAP_VATTU Foreign key(mavt) references vattu(mavt),
 Constraint Chk_SlNhap check(SlNhap>0),
 Constraint Chk_DgNhap check(DgNhap>0)
)

create Table PXUAT
(SoPX char(4), NgayXuat Datetime, TenKH Varchar(100),
Constraint Pri_SoPX primary key(SoPX)
)


create Table CTPXUAT
(SoPX char(4), MaVT char(4), SlXuat int, DgXuat int,
 Constraint Pri_SoPX_MaVT primary key(sopx, mavt),
 Constraint For_CTPXUAT_PXUAT Foreign key(SoPX) references PXuat(SoPX),
 Constraint For_CTPXUAT_VATTU Foreign key(mavt) references vattu(mavt),
 Constraint Chk_SlXuat check(SlXuat>0),
 Constraint Chk_DgXuat check(DgXuat>0)
)