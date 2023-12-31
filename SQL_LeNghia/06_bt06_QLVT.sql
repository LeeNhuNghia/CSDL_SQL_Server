use QuanLyVT

/*24.  Cho  biết  đơn  giá  xuất  trung  bình  của  vật  tư  G001  trong  bảng  CTPXUAT  hiện  giờ  là  bao 
nhiêu? Nếu lớn hơn 900 thì in ra "không nên thay  đổi giá bán", ngược lại in ra "đã  đến lúc 
tăng giá bán".*/
declare @DGTB real
set @DGTB = (select AVG(DgXuat) from CTPXUAT where MaVT='G001')
if @DGTB>900
	print N'Không nên thay đổi giá bán'
else
	print N'Đã đến lúc tăng giá bán'

/*25.  Sử  dụng  hàm  DATENAME  với  cú  pháp  DATENAME(datepart,  date)  để  lấy  
được  chuỗi  đại diện cho một phần của ngày chỉ định. Sử dụng hàm này  để tính xem 
có đơn đặt hàng nào đã  được  lập  vào  ngày  chủ  nhật  không?  
Nếu  có  thì  in  ra  danh  sách  các  đơn  đặt  hàng  đó, ngược lại thì in ra chuỗi 
các "Ngày lập các đơn đặt hàng đều hợp lệ". 
Thí  dụ:  DATENAME(dw,  GETDATE()) sẽ  trả  về  chuỗi  ngày  hiện  hành  trong  
tuần (Tuesday), hoặc DATENAME (month,GETDATE()) sẽ trả về Septemper (thí dụ này đúng 
khi ngày hiện hành là 18/09/2001).*/
--declare @dem int
--set @dem=(select COUNT(*) from DONDH where DATENAME(dw, Ngaythang)='Sunday'

/*26.    Hãy cho biết có bao nhiêu số nhập hàng cho đơn đặt hàng D001, nếu có thì in ra "Có xx số 
phiếu nhập hàng cho đơn đặt hàng D001", ngược lại thì in ra " Chưa có nhập hàng nào cho 
D001*/
declare @dem int
set @dem = (select COUNT(*) from PNHAP where SoDH='D001')
if @dem>0
	print N'Có ' + cast(@dem as char(1)) + N' số phiếu nhập cho đơn đặt hàng D001'
else
	print 'Chưa có nhập hàng nào cho D001'
