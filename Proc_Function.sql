--1) Cập nhật chức vụ cho nhân viên được thăng chức
Create proc sp_CapNhat_ChucVu
@manv varchar(50), @macv varchar(50)
as
Update NhanVien
set MaCV=@macv 
where MaNV=@manv
--Test
exec sp_CapNhat_ChucVu 'NV0011','KTT'
select * from NhanVien
drop proc sp_CapNhat_ChucVu

--2) Danh sách nhiêu nhân viên được khen thưởng và nội dung khen thưởng( không có tham số truyền vào)
Create proc sp_NhanVien_Thuong
as
	select NhanVien.MaNV,HoTen,Thuong,NoiDung
	from NhanVien  inner join KhenThuongKL  on NhanVien.MaNV=KhenThuongKL.MaNV
--Test
exec sp_NhanVien_Thuong 
drop proc sp_NhanVien_Thuong
select * from KhenThuongKL


--3) Số lượng nhân viên trong từng phòng ban ( không có tham số truyền vào)  
Create proc sp_SL_NhanVien_TungPhong
as 
	select NhanVien.MaPB, Count(MaNV) as SoLuongNV
	from NhanVien inner join  PhongBan on NhanVien.MaPB =PhongBan.MaPB
	where  NhanVien.MaPB=PhongBan.MaPB
	Group by NhanVien.MaPB
--Test 
exec sp_SL_NhanVien_TungPhong
drop proc sp_SL_NhanVien_TungPhong

--4) Tổng lương công ty phải trả cho tháng 3/2021 chưa tính các chi phí khác 
Create proc sp_TongLuongCTy
@thang int, @nam int, @TongLuong int output
as 
	select @TongLuong=sum(MucLuong)
	from Luong a  inner join ThanhToanLuong b on a.MaLuong=b.MaLuong
	where Thang=@thang and Nam=@nam 
--Test
Declare @TongLuong int 
Set @TongLuong=0
Exec  sp_TongLuongCTy '3','2021', @TongLuong output 
print N'Tổng lương công ty phải trả chưa trừ các chi phí khác:' +Cast(@TongLuong as nvarchar(10))

-- 5) Danh sách nhân viên theo số ngày công
--(theo tiêu chuẩn tháng của công ty số ngày công là 26).
--Nếu số ngày công <26 hiện lý do (Nếu nghỉ hưởng lương thì ko hiện, chỉ hiện nghỉ
--không hương lương)
create proc sp_TKTNC @songaycong int
as
if @songaycong=26
select NhanVien.MaNV,HoTen
from NhanVien inner join Cong on NhanVien.MaNV=Cong.MaNV
Where SoNgayCong=@songaycong
else 
select NhanVien.MaNV,HoTen,SoNgayCong,NgayNghi,NgayDen as SoNgayNghi,LyDo
from NhanVien inner join NghiViec on NhanVien.MaNV=NghiViec.MaNV 
inner join Cong on NhanVien.MaNV=Cong.MaNV
Where SoNgayCong=@songaycong and HuongLuong=0
--Test
Exec sp_TKTNC 24
--Xóa thủ tục
Drop proc sp_TKTNC
select * from NghiViec

-- 6) Kiểm tra hạn hợp đồng của một nhân viên theo năm
create proc sp_HHD @manhanvien nchar(6)
as
select NhanVien.MaNV,HoTen,NgayKy,HanHD,
(Datediff(DAY,GETDATE(),HanHD)/365) as SoNamHetHan
from NhanVien inner join HopDong on NhanVien.MaNV=HopDong.MaNV
WHERE NhanVien.MaNV=@manhanvien
--Test
Exec sp_HHD 'NV0001'
drop proc sp_HHD

--7) Xem ngày lên lương của nhân viên (Tham số đầu vào là mã nhân viên) 
Create proc sp_NLL_NV
@manv nvarchar(6)
as 
	select NhanVien.MaNV, HoTen, NgayLenLuong
	from NhanVien inner join Luong on NhanVien.MaNV=Luong.MaNV
	where NhanVien.MaNV=@manv 
--Test
exec sp_NLL_NV 'NV0020'
drop proc sp_NLL_NV
select * from Luong

--Lệnh cấu trúc
--(Function)
--1) Xem mức lương cơ bản của 1 nhân viên
Create Function f_LNV (@ma nchar(6))
Returns int
AS
Begin
	Declare @luong int 
	set @luong= 0
	Select @luong=MucLuong 
	from NhanVien inner join Luong on NhanVien.MaNV=Luong.MaNV
	where NhanVien.MaNV=@ma
	Return @luong
End
--Chạy
print dbo.f_LNV ('NV0001')
--Xoá
drop function f_LNV

--2) Danh sách nhân viên trong 1 phòng ban
Create Function f_DSNV_PB (@maphongban nvarchar(20))
Returns Table
as
Return
select MaNV,HoTen,NgaySinh,GioiTinh,DienThoai
from NhanVien
where MaPB=@maphongban
--Chạy
select * from dbo.f_DSNV_PB ('ChuyenMon')

drop function f_DSNV_PB