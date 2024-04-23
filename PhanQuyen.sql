

--1) Tạo tài khoản cho giamdoc
Create login giamdoc with password = '123456', default_database = QLNSTL1
Create user giamdoc for login giamdoc
grant select, update, delete on ChucVu to giamdoc
grant select, update, delete on Cong to giamdoc
grant select, update, delete on HopDong to giamdoc
grant select, update, delete on KhenThuongKL to giamdoc
grant select, update, delete on Luong to giamdoc
grant select, update, delete on NghiViec to giamdoc
grant select, update, delete on NhanVien to giamdoc
grant select, update, delete on PhongBan to giamdoc
grant select, update, delete on ThanhToanLuong to giamdoc

--2) Tạo tài khoản cho trưởng phòng kế toán
create login truongphongkt with password = '123456', default_database = QLNSTL1
Create user truongphongkt for login truongphongkt
grant select, update, delete on ChucVu to truongphongkt
grant select, update, delete on Cong to truongphongkt
grant select, update, delete on KhenThuongKL to truongphongkt
grant select, update, delete on Luong to truongphongkt
grant select, update, delete on NghiViec to truongphongkt
grant select, update, delete on NhanVien to truongphongkt
grant select, update, delete on PhongBan to truongphongkt
grant select, update, delete on ThanhToanLuong to truongphongkt

--3) Tạo tài khoản cho các trưởng phòng hành chính, kinh doanh
create login truongphonghckd with password = '123456', default_database = QLNSTL1
Create user truongphonghckd for login truongphonghckd
grant select, update, delete on ChucVu to truongphonghckd
grant select, update, delete on NghiViec to truongphonghckd
grant select, update, delete on NhanVien to truongphonghckd
grant select, update, delete on PhongBan to truongphonghckd

--4) Tạo tài khoản cho nhân viên các phòng
create login nhanvien with password = '123456', default_database = QLNSTL1
Create user nhanvien for login nhanvien
grant select on ChucVu to nhanvien
grant select on NghiViec to nhanvien
grant select on NhanVien to nhanvien
grant select on PhongBan to nhanvien
grant select on HopDong to nhanvien




