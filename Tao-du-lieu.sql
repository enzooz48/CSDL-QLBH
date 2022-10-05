-- 1. Tạo dữ liệu
-- Tạo và sử dụng database
CREATE DATABASE QLBANHANG2
GO
USE QLBANHANG2
GO
SET DATEFORMAT DMY
GO
-- Tạo các table + Khoá chính

-- Tạo table khách hàng
CREATE TABLE KHACHHANG (
 MAKH CHAR(4),
 HOTEN VARCHAR(40),
 DCHI VARCHAR(50),
 SODT VARCHAR(20),
 NGSINH SMALLDATETIME,
 NGDK SMALLDATETIME,
 DOANHSO MONEY,
 CONSTRAINT PK_KH PRIMARY KEY(MAKH)
)
GO

-- Tạo table Nhân viên
CREATE TABLE NHANVIEN (
 MANV CHAR(4),
 HOTEN VARCHAR(40),
 SODT VARCHAR(20),
 NGVL SMALLDATETIME,
 CONSTRAINT PK_NV PRIMARY KEY(MANV)
)
GO

-- Tạo table sản phẩm
CREATE TABLE SANPHAM (
 MASP CHAR(4),
 TENSP VARCHAR(40),
 DVT VARCHAR(20),
 NUOCSX VARCHAR(40),
 GIA MONEY,
 CONSTRAINT PK_SP PRIMARY KEY(MASP)
)
GO

-- tạo table Hoá đơn
CREATE TABLE HOADON (
 SOHD INT,
 NGHD SMALLDATETIME,
 MAKH CHAR(4),
 MANV CHAR(4),
 TRIGIA MONEY,
 CONSTRAINT PK_HD PRIMARY KEY (SOHD)
)
GO

-- Taọ table Chi tiết Hoá đơn
CREATE TABLE CTHD (
 SOHD INT,
 MASP CHAR(4),
 SL INT
)
GO

-- Tạo khoá ngoại

-- Tạo khoá ngoại ở bảng hoá đơn
ALTER TABLE dbo.HOADON
 ADD CONSTRAINT FK_HD01
 FOREIGN KEY (MAKH)
 REFERENCES dbo.KHACHHANG (MAKH)
 GO

ALTER TABLE dbo.HOADON
 ADD CONSTRAINT FK_HD02
 FOREIGN KEY (MANV)
 REFERENCES dbo.NHANVIEN (MANV)
 GO

-- Tạo khoá ngoại ở bảng Chi tiết hoá đơn
ALTER TABLE dbo.CTHD
 ADD CONSTRAINT FK_CTHD01
 FOREIGN KEY (SOHD)
 REFERENCES dbo.HOADON (SOHD)
 GO

-- NHập Data 

-- NHập data cho bảng Nhân viên
INSERT INTO dbo.NHANVIEN
VALUES 
 ('NV01','Nguyen Nhu Nhut','0927345678','13/04/2006'),
 ('NV02','Le Thi Phi Yen','0987567390','21/04/2006'),
 ('NV03','Nguyen Van B','0997047382','27/04/2006'),
 ('NV04','Ngo Thanh Tuan','0913758498','24/06/2006'),
 ('NV05','Nguyen Thi Truc Thanh','0918590387','20/07/2006')
 GO

-- NHập data cho bảng khâchs hàng
INSERT INTO dbo.KHACHHANG
VALUES
 ('KH01','Nguyen Van A','731,Tran Hung Dao, Q 5 ,Tp HCM','08823451','22/10/1960','22/10/2006',13000000),
 ('KH02','Tran Ngoc Han','23/5, Nguyen Trai, Q 5, Tp HCM','0908256478','03/04/1974','30/07/2006',280000),
 ('KH03','Tran Ngoc Linh','45, Nguyen Canh Chan, Q 1, Tp HCM','0938776266','12/06/1980','05/08/2006',3860000),
 ('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q 10, Tp HCM','0917325476','09/03/1965','02/10/2006',250000),
 ('KH05','Le Nhat Minh','34, Truong Dinh, Q 3, Tp HCM','08246108','10/03/1950','28/10/2006',21000),
 ('KH06','Le Hoai Thuong','227, Nguyen Van Cu, Q 5, Tp HCM','08631738','31/12/1981','24/11/2006',915000),
 ('KH07','Nguyen Van Tam','32/3, Tran Binh Trong, Q 5, Tp HCM','0916783565','06/04/1971','01/12/2006',12500),
 ('KH08','Phan Thi Thanh','45/2, An Duong Vuong, Q 5, Tp HCM','0938435756','10/01/1971','13/12/2006',365000),
 ('KH09','Le Ha Vinh','873, Le Hong Phong, Q 5, Tp HCM','08654763','03/09/1979','14/01/2007',70000),
 ('KH10','Ha Duy Lap','34/34B, Nguyen Trai, Q 1, Tp HCM','08768904','02/05/1983','16/01/2007',67500)
 GO

-- Nhập Data cho bảng Sản phẩm
INSERT INTO dbo.SANPHAM
VALUES 
 ('BC01','But chi','cay','Singapore',3000),
 ('BC02','But chi','cay','Singapore',5000),
 ('BC03','But chi','cay','Viet Nam',3500),
 ('BC04','But chi','hop','Viet Nam',30000),
 ('BB01','But bi','cay','Viet Nam',5000),
 ('BB02','But bi','cay','Trung Quoc',7000),
 ('BB03','But bi','hop','Thai Lan',100000),
 ('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500),
 ('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500),
 ('TV03','Tap 100 giay tot','quyen','Viet Nam',3000),
 ('TV04','Tap 200 giay tot','quyen','Viet Nam',5500),
 ('TV05','Tap 100 trang','chuc','Viet Nam',23000),
 ('TV06','Tap 200 trang','chuc','Viet Nam',53000),
 ('TV07','Tap 100 trang','chuc','Trung Quoc',34000),
 ('ST01','So tay 500 trang','quyen','Trung Quoc',40000),
 ('ST02','So tay loai 1','quyen','Viet Nam',55000),
 ('ST03','So tay loai 2','quyen','Viet Nam',51000),
 ('ST04','So tay ','quyen','Thai Lan',55000),
 ('ST05','So tay mong','quyen','Thai Lan',20000),
 ('ST06','Phan viet bang','hop','Viet Nam',5000),
 ('ST07','Phan khong bui','hop','Viet Nam',7000),
 ('ST08','Bong bang','cai','Viet Nam',1000),
 ('ST09','But long','cay','Viet Nam',5000),
 ('ST10','But long','cay','Trung Quoc',7000)
 GO

-- NHập Data cho bảng Hoá đơn

insert into HOADON values (1001,'23/07/2006','KH01','NV01',320000)
insert into HOADON values (1002,'12/08/2006','KH01','NV02',840000)
insert into HOADON values (1003,'23/08/2006','KH02','NV01',100000)
insert into HOADON values (1004,'01/09/2006','KH02','NV01',180000)
insert into HOADON values (1005,'20/10/2006','KH01','NV02',3800000)
insert into HOADON values (1006,'16/10/2006','KH01','NV03',2430000)
insert into HOADON values (1007,'28/10/2006','KH03','NV03',510000)
insert into HOADON values (1008,'28/10/2006','KH01','NV03',440000)
insert into HOADON values (1009,'28/10/2006','KH03','NV04',200000)
insert into HOADON values (1010,'01/11/2006','KH01','NV01',5200000)
insert into HOADON values (1011,'04/11/2006','KH04','NV03',250000)
insert into HOADON values (1012,'30/11/2006','KH05','NV03',21000)
insert into HOADON values (1013,'12/12/2006','KH06','NV01',5000)
insert into HOADON values (1014,'31/12/2006','KH03','NV02',3150000)
insert into HOADON values (1015,'01/01/2007','KH06','NV01',910000)
insert into HOADON values (1016,'01/01/2007','KH07','NV02',12500)
insert into HOADON values (1017,'02/01/2007','KH08','NV03',35000)
insert into HOADON values (1018,'13/01/2007','KH08','NV03',330000)
insert into HOADON values (1019,'13/01/2007','KH01','NV03',30000)
insert into HOADON values (1020,'14/01/2007','KH09','NV04',70000)
insert into HOADON values (1021,'16/01/2007','KH10','NV03',67500)
insert into HOADON values (1022,'16/01/2007',null,'NV03',7000)
insert into HOADON values (1023,'17/01/2007',null,'NV01',330000)
 GO

-- NHập Data cho bảng Chi tiết hoá đơn
insert into CTHD values (1001,'TV02',10)
insert into CTHD values (1001,'ST01',5)
insert into CTHD values (1001,'BC01',5)
insert into CTHD values (1001,'BC02',10)
insert into CTHD values (1001,'ST08',10)
insert into CTHD values (1002,'BC04',20)
insert into CTHD values (1002,'BB01',20)
insert into CTHD values (1002,'BB02',20)
insert into CTHD values (1003,'BB03',10)
insert into CTHD values (1004,'TV01',20)
insert into CTHD values (1004,'TV02',20)
insert into CTHD values (1004,'TV03',20)
insert into CTHD values (1004,'TV04',20)
insert into CTHD values (1005,'TV05',50)
insert into CTHD values (1005,'TV06',50)
insert into CTHD values (1006,'TV07',20)
insert into CTHD values (1006,'ST01',30)
insert into CTHD values (1006,'ST02',10)
insert into CTHD values (1007,'ST03',10)
insert into CTHD values (1008,'ST04',8)
insert into CTHD values (1009,'ST05',10)
insert into CTHD values (1010,'TV07',50)
insert into CTHD values (1010,'ST07',50)
insert into CTHD values (1010,'ST08',100)
insert into CTHD values (1010,'ST04',50)
insert into CTHD values (1010,'TV03',100)
insert into CTHD values (1011,'ST06',50)
insert into CTHD values (1012,'ST07',3)
insert into CTHD values (1013,'ST08',5)
insert into CTHD values (1014,'BC02',80)
insert into CTHD values (1014,'BB02',100)
insert into CTHD values (1014,'BC04',60)
insert into CTHD values (1014,'BB01',50)
insert into CTHD values (1015,'BB02',30)
insert into CTHD values (1015,'BB03',7)
insert into CTHD values (1016,'TV01',5)
insert into CTHD values (1017,'TV02',1)
insert into CTHD values (1017,'TV03',1)
insert into CTHD values (1017,'TV04',5)
insert into CTHD values (1018,'ST04',6)
insert into CTHD values (1019,'ST05',1)
insert into CTHD values (1019,'ST06',2)
insert into CTHD values (1020,'ST07',10)
insert into CTHD values (1021,'ST08',5)
insert into CTHD values (1021,'TV01',7)
insert into CTHD values (1021,'TV02',10)
insert into CTHD values (1022,'ST07',1)
insert into CTHD values (1023,'ST04',6)
 GO

 -- 2.Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
ALTER TABLE dbo.SANPHAM ADD GHICHU VARCHAR(10)
GO
-- 3.Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
ALTER TABLE dbo.KHACHHANG ADD LOAIKH TINYINT
GO
-- 4.Cập nhật tên “Nguyễn Văn B” cho dữ liệu Khách Hàng có mã là KH01
UPDATE dbo.KHACHHANG
SET HOTEN='Nguyễn Văn B'
WHERE MAKH='KH01'
GO
-- 5.Cập nhật tên “Nguyễn Văn Hoan” cho dữ liệu Khách Hàng có mã là KH09 và năm đăng ký là 2007
UPDATE dbo.KHACHHANG
SET HOTEN='Nguyễn Văn Hoan'
WHERE MAKH='KH09' AND YEAR(NGDK)=2007
GO
-- 6.Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100)
ALTER TABLE dbo.SANPHAM
 ALTER COLUMN GHICHU VARCHAR(100)
GO
-- 7.Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
ALTER TABLE dbo.SANPHAM
 DROP COLUMN GHICHU
GO
--8.Xoá tất cả dữ liệu khách hàng có năm sinh 1971
DELETE FROM dbo.KHACHHANG
WHERE YEAR(NGSINH) = 1971
GO
-- 9.Xoá tất cả dữ liệu khách hàng có năm sinh 1971 và năm đăng ký 2006
DELETE FROM dbo.KHACHHANG
WHERE YEAR(NGSINH) = 1971 AND YEAR(NGDK) = 2006
GO
-- 10.Xoá tất hoá đơn có mã KH = KH01
DELETE FROM dbo.HOADON
WHERE MAKH = 'KH01'
GO