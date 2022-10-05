-- 1.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE NUOCSX = 'Trung Quoc'
GO
-- 2.In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE DVT IN ('cay','quyen')
GO
-- 3.In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE MASP LIKE 'B%01'
GO
-- 4.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE NUOCSX = 'Trung Quoc'AND GIA BETWEEN 30000 AND 40000
GO
-- 5.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE NUOCSX = 'Trung Quoc'OR NUOCSX = 'Thai Lan'
AND GIA BETWEEN 30000 AND 40000
GO
-- 6.In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007
SELECT SOHD,TRIGIA FROM dbo.HOADON
WHERE NGHD IN ('01/01/2007','02/01/2007')
GO
-- 7.In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD,TRIGIA FROM dbo.HOADON
WHERE YEAR(NGHD) = 2007 AND MONTH(NGHD) = 01
ORDER BY TRIGIA DESC,NGHD ASC
GO
-- 8.In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007
SELECT A.MAKH , A.HOTEN 
FROM KHACHHANG A, HOADON B
WHERE A.MAKH = B.MAKH AND NGHD = '1/1/2007'
GO

SELECT KH.MAKH , KH.HOTEN
FROM dbo.KHACHHANG AS KH
 INNER JOIN dbo.HOADON AS HD ON HD.MAKH = KH.MAKH
WHERE HD.NGHD = '1/1/2007'
GO
-- 9.In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006
SELECT HD.SOHD,HD.TRIGIA
FROM dbo.HOADON AS HD
 INNER JOIN dbo.NHANVIEN AS NV ON NV.MANV = HD.MANV
WHERE NV.HOTEN = 'Nguyen Van B' AND HD.NGHD='10/28/2006'
GO
-- 10.In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT SP.MASP,SP.TENSP 
FROM dbo.KHACHHANG AS KH
 INNER JOIN dbo.HOADON AS HD ON HD.MAKH = KH.MAKH
 INNER JOIN dbo.CTHD ON CTHD.SOHD = HD.SOHD
 INNER JOIN dbo.SANPHAM AS SP ON SP.MASP = CTHD.MASP
WHERE KH.HOTEN='Nguyen Van A' AND YEAR(HD.NGHD)=2006 AND MONTH(HD.NGHD)=10
GO

SELECT SP.MASP , SP.TENSP
FROM (dbo.KHACHHANG AS KH JOIN dbo.HOADON AS HD ON KH.MAKH = HD.MAKH) JOIN ( dbo.SANPHAM AS SP JOIN CTHD ON SP.MASP = CTHD.MASP ) ON HD.SOHD = CTHD.SOHD
WHERE KH.HOTEN = 'Nguyen Van A' AND MONTH(HD.NGHD)= 10 AND YEAR(HD.NGHD) = 2006
GO
-- 11.Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”
SELECT DISTINCT SOHD FROM dbo.CTHD
WHERE MASP = 'BB01' OR MASP = 'BB02'
GO
-- 12.Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT DISTINCT SOHD FROM dbo.CTHD
WHERE (MASP = 'BB01' OR MASP = 'BB02')
AND SL BETWEEN 10 AND 20
GO
-- 13.Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD
FROM dbo.CTHD A
WHERE MASP = 'BB02' AND A.SL BETWEEN 10 AND 20 AND EXISTS (
	SELECT SOHD 
	FROM dbo.CTHD B
	WHERE MASP = 'BB01' AND A.SOHD = B.SOHD AND B.SL BETWEEN 10 AND 20
	)
GO
-- 14.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE NUOCSX = 'Trung Quoc'
UNION
SELECT SP.MASP,SP.TENSP FROM dbo.SANPHAM AS SP
 INNER JOIN dbo.CTHD ON CTHD.MASP = SP.MASP
 INNER JOIN dbo.HOADON AS HD ON HD.SOHD = CTHD.SOHD
WHERE HD.NGHD = '1/1/2007'
GO
-- 15.In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT SP.MASP,SP.TENSP FROM dbo.SANPHAM AS SP
WHERE NOT EXISTS (
 SELECT MASP FROM dbo.CTHD
 WHERE CTHD.MASP = SP.MASP
)
GO
-- 16.In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006
SELECT SP.MASP,SP.TENSP FROM dbo.SANPHAM AS SP
WHERE NOT EXISTS (
 SELECT MASP 
 FROM dbo.CTHD
  INNER JOIN dbo.HOADON AS HD ON HD.SOHD = CTHD.SOHD
 WHERE CTHD.MASP = SP.MASP AND YEAR(HD.NGHD)=2006
)
GO
-- 17.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006
SELECT SP.MASP,SP.TENSP FROM dbo.SANPHAM AS SP
WHERE SP.NUOCSX='Trung Quoc'AND NOT EXISTS (
 SELECT CTHD.MASP 
 FROM dbo.CTHD
  INNER JOIN dbo.HOADON AS HD ON HD.SOHD = CTHD.SOHD
 WHERE CTHD.MASP = SP.MASP AND YEAR(HD.NGHD)=2006 
)
GO
-- 18.Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD FROM dbo.HOADON AS HD
WHERE NOT EXISTS (
 SELECT SP.MASP FROM dbo.SANPHAM AS SP
 WHERE SP.NUOCSX = 'Singapore' AND NOT EXISTS (
  SELECT SOHD FROM dbo.CTHD
  WHERE CTHD.SOHD = HD.SOHD AND CTHD.MASP = SP.MASP
 )
)
GO
-- 19.Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*) AS SOHOADONKHONGPHAIDOTHANHVIENMUA
FROM dbo.HOADON
WHERE MAKH IS NULL
GO
-- 20.Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT CTHD.MASP)
FROM dbo.HOADON AS HD
 INNER JOIN dbo.CTHD ON CTHD.SOHD = HD.SOHD
WHERE YEAR(HD.NGHD) = 2006
GO
-- 21.Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(HD.TRIGIA) AS TRIGIACCAONHAT, MIN(HD.TRIGIA) AS TRIGIATHAPNHAT
FROM dbo.HOADON AS HD
GO
-- 22.Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(HD.TRIGIA) AS TRIGIATRUNGBINH
FROM dbo.HOADON AS HD
WHERE YEAR(HD.NGHD) = 2006
GO
-- 23.Tính doanh thu bán hàng trong năm 2006
SELECT SUM(HD.TRIGIA) AS DOANHTHU
FROM dbo.HOADON AS HD
WHERE YEAR(HD.NGHD) = 2006
GO
-- 24.Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD
FROM dbo.HOADON
WHERE TRIGIA= (SELECT MAX(TRIGIA) FROM dbo.HOADON WHERE YEAR(NGHD) =2006 )
GO
-- 25.Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006
SELECT KH.HOTEN 
FROM dbo.HOADON AS HD
 INNER JOIN dbo.KHACHHANG AS KH ON KH.MAKH = HD.MAKH
WHERE HD.TRIGIA = (SELECT MAX(TRIGIA) FROM dbo.HOADON WHERE YEAR(NGHD) =2006 )
GO
-- 26.In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP (3) MAKH,HOTEN FROM dbo.KHACHHANG 
ORDER BY DOANHSO DESC
GO
-- 27.In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE GIA IN (
 SELECT TOP (3) GIA FROM dbo.SANPHAM
 ORDER BY GIA DESC
)
GO
-- 28.In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE NUOCSX = 'Thai Lan' 
AND GIA IN (
 SELECT TOP (3) GIA FROM dbo.SANPHAM
 ORDER BY GIA DESC
)
GO
-- 29.In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất)
SELECT MASP,TENSP FROM dbo.SANPHAM
WHERE NUOCSX = 'Trung Quoc' 
AND GIA IN (
 SELECT TOP (3) GIA FROM dbo.SANPHAM
 WHERE NUOCSX = 'Trung Quoc'
 ORDER BY GIA DESC
)
GO
-- 30. In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP (3) MAKH ,HOTEN FROM dbo.KHACHHANG
ORDER BY DOANHSO DESC
GO
-- 31.Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(*) AS SOSP FROM dbo.SANPHAM
WHERE NUOCSX = 'Trung Quoc'
GO
-- 32.Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX , COUNT(*) AS SOSP 
FROM dbo.SANPHAM
GROUP BY NUOCSX
GO
-- 33.Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX , MAX(GIA) AS GIACAONHAT , MIN(GIA) AS GIATHAPNHAT , AVG(GIA) AS GIATB
FROM dbo.SANPHAM
GROUP BY NUOCSX
GO
-- 34.Tính doanh thu bán hàng mỗi ngày.
SELECT CONVERT(VARCHAR(20),NGHD,103) AS NGAY , SUM(TRIGIA) AS DOANHTHU 
FROM dbo.HOADON
GROUP BY NGHD
ORDER BY NGHD ASC
GO
-- 35.Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT CTHD.MASP , SUM(SL) AS SL
FROM dbo.HOADON AS HD
 INNER JOIN dbo.CTHD ON CTHD.SOHD = HD.SOHD
WHERE MONTH(HD.NGHD) = 10 AND YEAR(HD.NGHD) = 2006
GROUP BY CTHD.MASP
GO
-- 36.Tính doanh thu bán hàng của từng tháng trong năm 2006
SELECT MONTH(NGHD) AS THANG , SUM(TRIGIA) AS TONGDOANHTHU
FROM dbo.HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
GO
-- 37.Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau
SELECT SOHD FROM dbo.CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) > 3
GO
-- 38.Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT CTHD.SOHD 
FROM dbo.CTHD 
 JOIN dbo.SANPHAM AS SP ON CTHD.MASP = SP.MASP
WHERE SP.NUOCSX ='Viet Nam'
GROUP BY CTHD.SOHD
HAVING COUNT(DISTINCT CTHD.MASP) = 3
GO
-- 39.Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT TOP (1) KH.MAKH,KH.HOTEN
FROM dbo.HOADON AS HD 
 INNER JOIN dbo.KHACHHANG AS KH ON KH.MAKH = HD.MAKH
GROUP BY KH.MAKH , KH.HOTEN
ORDER BY COUNT(*) DESC
GO
-- 40.Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP (1) MONTH(NGHD) AS THANG FROM dbo.HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC
GO
-- 41.Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT TOP (1) SP.MASP , SP.TENSP
FROM dbo.HOADON AS HD
 INNER JOIN dbo.CTHD ON CTHD.SOHD = HD.SOHD
 INNER JOIN dbo.SANPHAM AS SP ON SP.MASP = CTHD.MASP
WHERE YEAR(HD.NGHD)= 2006
GROUP BY SP.MASP, SP.TENSP
ORDER BY SUM(CTHD.SL) ASC
GO
-- 42.*Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT NUOCSX,MASP,TENSP FROM dbo.SANPHAM
GROUP BY NUOCSX,MASP,TENSP
ORDER BY MAX(GIA) DESC
GO
-- 43.Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT NUOCSX FROM dbo.SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) >2
GO
-- 44.Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT TOP (1) MAKH ,HOTEN 
FROM (
		SELECT TOP (10) KH.MAKH , KH.HOTEN , COUNT(HD.MAKH) AS SL
		FROM  dbo.KHACHHANG AS KH 
		 JOIN dbo.HOADON AS HD ON KH.MAKH = HD.MAKH
		GROUP BY KH.MAKH , KH.DOANHSO , KH.HOTEN
		ORDER BY KH.DOANHSO DESC
		) KH
ORDER BY SL DESC
GO