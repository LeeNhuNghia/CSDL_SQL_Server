--Tính tổng các số nguyên từ 1 đén 10
declare @i int, @Tong int
set @i = '1'
set @Tong ='0'
while (@i<=10)
	begin
		set @Tong= @Tong+@i
		set @i = @i+1
	end
print @Tong


--In các số Nguyên từ 1-10
declare @i int
set @i='1'
while (@i<=10)
	begin
		print @i
		set @i=@i+1
	end
	
--In các số nguyên chẵn NHỎ hơn or bằng 10
declare @i int
set @i='2'
while @i<=10
	begin
		print @i
		set @i=@i+2
	end
	
--In các số nguyên lẻ NHỎ hơn or bằng 10
declare @i int
set @i='1'
while @i<=10
	begin
		print @i
		set @i=@i+2
	end