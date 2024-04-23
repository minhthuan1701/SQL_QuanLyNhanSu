-------TABLE-------
--Liệt kê danh sách nhân viên phòng kế toán
select MaNV, HoTen, NgaySinh, GioiTinh, CMNN, BHYT, DiaChi, DienThoai, MaCV
from NhanVien
where MaPB='KeToan'

--Tên những nhân viên khen thưởng kỷ luật
select NhanVien.MaNV, HoTen
from NhanVien, KhenThuongKL
where NhanVien.MaNV=KhenThuongKL.MaNV

--Danh sách nhân viên ký hợp đồng vào tháng 5 năm 2019
select NhanVien.MaNV, HoTen
from NhanVien, HopDong
where NhanVien.MaNV=HopDong.MaNV
and MONTH(NgayKy)=5 and YEAR(NgayKy)=2019

-- Danh sách các nhân viên nghỉ việc trong tháng và số ngày nghỉ của từng nhân viên
select NhanVien.MaNV,HoTen,LyDo,Day(NgayDen)-Day(NgayNghi) as SoNgayNghi
from NhanVien,NghiViec
where NhanVien.MaNV=NghiViec.MaNV

--Số lượng nhân viên trong từng phòng ban
select NhanVien.MaPB,Count(MaNV) as SoLuongNV
from NhanVien, PhongBan
where NhanVien.MaPB=PhongBan.MaPB
Group by NhanVien.MaPB

--Phòng ban có nhiều nhân viên nhất
select PhongBan.MaPB, Count (MaNV) as SoLuongNV
from PhongBan,NhanVien
where PhongBan.MaPB=NhanVien.MaPB
Group by PhongBan.MaPB
Having count(MaNV)>=ALL( select count (MaNV)
						from NhanVien
						Group by MaPB)

--Tính tiền lương cho nhân viên
select NhanVien.MaNV,HoTen, (((MucLuong)/26*SoNgayCong)+Thuong-KhauTruBH) as ThucLinh
from NhanVien,Luong,Cong,ThanhToanLuong
where NhanVien.MaNV=Luong.MaNV and Cong.MaNV=NhanVien.MaNV and ThanhToanLuong.MaNV=NhanVien.MaNV
and ThanhToanLuong.MaLuong=Luong.MaLuong and Cong.MaCong=ThanhToanLuong.MaCong

select * from ThanhToanLuong
select * from NghiViec
select * from KhenThuongKL
-------SYNONYM-------
--1) 
create synonym db for sys.databases

select*
from db

select*
from sys.databases
--2)
create synonym TTL for ThanhToanLuong
select*
from TTL
drop synonym TTL
--3)
create synonym KTKL for KhenThuongKL

select*
from KTKL

-------VIEW--------

1--Liệt kê danh sách nhân viên phòng kế toán
select MaNV, HoTen, NgaySinh, GioiTinh, CMNN, BHYT, DiaChi, DienThoai, MaCV
from NhanVien
where MaPB='KeToan'
select * from PhongBan

1--Tên những nhân viên khen thưởng kỷ luật
select NhanVien.MaNV, HoTen
from NhanVien, KhenThuongKL
where NhanVien.MaNV=KhenThuongKL.MaNV

1--Danh sách nhân viên ký hợp đồng vào tháng 5 năm 2019                
select NhanVien.MaNV, HoTen
from NhanVien, HopDong
where NhanVien.MaNV=HopDong.MaNV
and MONTH(NgayKy)=5 and YEAR(NgayKy)=2019

select * from HopDong
-- Danh sách các nhân viên nghỉ việc trong tháng và số ngày nghỉ của từng nhân viên
select NhanVien.MaNV,HoTen,LyDo,Day(NgayDen)-Day(NgayNghi) as SoNgayNghi
from NhanVien,NghiViec
where NhanVien.MaNV=NghiViec.MaNV

1--Số lượng nhân viên trong từng phòng ban
select NhanVien.MaPB,Count(MaNV) as SoLuongNV
from NhanVien, PhongBan
where NhanVien.MaPB=PhongBan.MaPB
Group by NhanVien.MaPB

1--Phòng ban có nhiều nhân viên nhất
select PhongBan.MaPB, Count (MaNV) as SoLuongNV
from PhongBan,NhanVien
where PhongBan.MaPB=NhanVien.MaPB
Group by PhongBan.MaPB
Having count(MaNV)>=ALL( select count (MaNV)
						from NhanVien
						Group by MaPB)

1--Tính tiền lương cho nhân viên
select NhanVien.MaNV,HoTen, (((MucLuong)/26*SoNgayCong)+Thuong-KhauTruBH) as ThucLinh
from NhanVien,Luong,Cong,ThanhToanLuong
where NhanVien.MaNV=Luong.MaNV and Cong.MaNV=NhanVien.MaNV and ThanhToanLuong.MaNV=NhanVien.MaNV
and ThanhToanLuong.MaLuong=Luong.MaLuong and Cong.MaCong=ThanhToanLuong.MaCong

select * from ThanhToanLuong
-------INDEX-------

--1)Tạo Index cho tên nhân viên trong bảng NhanVien
create index Index_TenNV on NhanVien (HoTen)
Select*
From NhanVien 
with(index(Index_TenNV))
Where HoTen LIKE N'Nguyễn%'
--2)Tạo Index ngày kí hợp đồng của nhân viên
Create Index Index_NgayKy on HopDong (NgayKy)
Select*
From HopDong
with(index(Index_NgayKy))
Where month(NgayKy)=8 and year(NgayKy)=2020
--3)Tạo index mã chức vụ
Create Index Index_MaCV on NhanVien (MaCV)
select*
From NhanVien 
with (index(Index_MaCV))
Where MaCV='TL'

