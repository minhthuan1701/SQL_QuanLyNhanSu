
--1) Cập nhật ngày công khi nhân viên nghỉ việc trong tháng
Create trigger Trig_uNgayCong
on NghiViec
for INSERT
as
	Declare @manv nvarchar(6), @songaynghi int,@hl int
	select @songaynghi=Day((NgayDen))-Day(NgayNghi), @manv=MaNV, @hl=HuongLuong from inserted
	Begin
	if(@hl=0)	
		Update Cong
		Set SoNgayCong=SoNgayCong-@songaynghi
		where MaNV=@manv
		Print N'Dữ liệu được cập nhật'		
	End
--Test
Insert into NghiViec
values ('MNV007',Convert(datetime,'2021/3/12'),Convert(datetime,'2021/3/14'),N'Bệnh',0,'NV0001')
select * from NghiViec
select * from Cong
--Xóa trigger
drop trigger  Trig_uNgayCong
select * from NghiViec
select * from Cong

-- 2)Khi xóa mã nghỉ việc 1 nhân viên mà hưởng lương là 1 thì số ngày công 
-- giữ nguyên còn hưởng lương là 0 thì số ngày công tăng (Cập nhật ngày công)
Create trigger Trig_dNgayCong
on NghiViec
for delete, update
as
	Declare @manghiviec nvarchar(6), @songaynghi int,@hl int,
	@manhanvien nvarchar(6)
	select @songaynghi=Day((NgayDen))-Day(NgayNghi),
	@manghiviec=MaNGHI, @hl=HuongLuong,@manhanvien=MaNV from deleted
	Begin
	if(@hl=0)
		
		Update Cong
		Set SoNgayCong=SoNgayCong+@songaynghi
		where MaNV=@manhanvien
		Print N'Dữ liệu được cập nhật'	
	end
--Test
Delete from NghiViec
where MaNghi='MNV004'

select * from NghiViec 
where MaNghi='MNV004'

select * from Cong
where MaNV='NV0017'
drop trigger Trig_dNgayCong

insert into NghiViec
values('MNV004',Convert(datetime,'2021/3/18'),Convert(datetime,'2021/3/19'),null,0,'NV0017')

		
-- 3)Hợp đồng được kí ít nhất là 1 năm ngày (hạnhd-ngayki>= 1 năm (365 ngày)
create trigger Trig_uHanHd
on HopDong
for Update
as
	Declare @ngayhd float, @mahd nvarchar(6)
	select @ngayhd=Datediff(Day,(NgayKy),(HanHD)), @mahd=MaHD from inserted
	if(@ngayhd<365)
		Begin
		Print N'Ngày hợp đồng phải lớn hơn hoặc bằng 365 ngày (>= 365 ngày)'
		print @ngayhd
		ROLLBACK
		End
--Test
Update HopDong
set NgayKy=Convert(datetime,'09/09/2020'),HanHD=Convert(datetime,'05/01/2021')
where MaHD='HD0001'
--Bảng HopDong
select *
from HopDong
--Drop trigger Trig_uHanHd
Drop trigger Trig_uHanHd

Declare @ngay int
select Datediff(Day,(NgayKy),(HanHD))as songaylam
from HopDong
where MaHD='HD0015'
--Drop trigger Trig_iHanHd
Drop trigger Trig_iHanHd

