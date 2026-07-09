# TÓM TẮT QUY TẮC DÙNG CHUNG (lib/quy_tac/)

> File này tóm tắt toàn bộ class/hàm/widget đã có sẵn trong `lib/quy_tac/`.
> Khi viết code mới cho app OHIDO POS, LUÔN ưu tiên dùng lại các thành phần
> dưới đây thay vì tự viết mới (màu, chữ, nút, input, validate, format...).
> Đặt tên biến/hàm bằng tiếng Việt không dấu, theo đúng phong cách đã dùng.

---

## 1. `quy_tac/giao_dien/mau_sac.dart` — class `MauSac`
Chỉ hỗ trợ Light Mode (không có dark mode).

- Thương hiệu: `mauChinh`, `mauChinhNhat`, `mauChinhDam`
- Trạng thái (mỗi loại có bản đậm + bản nhạt `...Nhat`):
  `mauThanhCong`, `mauCanhBao`, `mauLoi`, `mauThongTin`
- Chữ: `mauChuTieuDe`, `mauChuNoiDung`, `mauChuMoTa`, `mauChuGoiY`,
  `mauChuVoHieuHoa`, `mauChuTrangSang`
- Nền: `mauNen` (nền toàn trang), `mauBeMat` (nền card, trắng)
- Viền: `mauVien`, `mauPhanCach` (mảnh hơn)

## 2. `quy_tac/giao_dien/kieu_chu.dart` — class `KieuChu`
Dùng font **Be Vietnam Pro** (qua `google_fonts`), mỗi style đã có màu mặc định.

- Tiêu đề: `tieuDeLon` (24, bold), `tieuDeVua` (18, bold), `tieuDeNho` (15, w600)
- Nội dung: `noiDung` (14, normal), `noiDungDam` (14, w600)
- Phụ: `moTa` (13, nhạt), `goiY` (13, nhạt hơn — placeholder)
- Nhãn: `nhan` (14, w600), `nhanNho` (12, w600 — badge/tag)
- Số liệu: `soLieuLon` (28, bold — giá tiền nổi bật), `soLieuVua` (16, w700)

Muốn đổi màu 1 chỗ: `KieuChu.noiDung.copyWith(color: MauSac.mauLoi)`

## 3. `quy_tac/giao_dien/nut_bam.dart` — widget `NutBam`
```dart
NutBam({
  required String nhan,
  required VoidCallback? onPressed,
  KieuNutBam kieu = KieuNutBam.chinh,   // chinh | phu | nguyHiem | vanBan
  KichThuocNut kichThuoc = KichThuocNut.vua, // nho | vua | lon
  IconData? icon,
  bool dangTai = false,      // tự hiện spinner thay chữ
  bool voHieuHoa = false,
  bool chiemHetChieuRong = false,
})
```

## 4. `quy_tac/giao_dien/khung_nhap.dart` — widget `KhungNhap`
Bọc `TextFormField`, tự đổi màu viền theo trạng thái (thường/focus/lỗi/disabled).
```dart
KhungNhap({
  String? nhan,                 // label phía trên
  String? goiY,                 // hint text
  TextEditingController? controller,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  IconData? iconTruoc,
  Widget? iconSau,
  TextInputType kieuBanPhim = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
  bool laMatKhau = false,        // tự thêm icon ẩn/hiện
  bool chiDoc = false,           // dùng với onTap (chọn ngày, chọn KH)
  bool voHieuHoa = false,
  int soDong = 1,
  VoidCallback? onTap,
})
```

## 5. `quy_tac/giao_dien/nhan_trang_thai.dart` — widget `NhanTrangThai`
Badge hình viên thuốc.
```dart
NhanTrangThai({
  required String nhan,
  required LoaiTrangThai loai,  // thanhCong | canhBao | loi | thongTin | trungLap(xám)
  bool coChamTron = false,      // chấm tròn nhỏ trước chữ thay vì icon
})
```

## 6. `quy_tac/giao_dien/dang_tai.dart` — 2 widget loading
```dart
// Spinner nhỏ, lồng trong 1 khu vực (không chặn thao tác)
WidgetDangTai({String? nhan, double kichThuoc = 32})

// Overlay toàn page, CHẶN thao tác. Bọc quanh nội dung (Stack).
LopPhuDangTai({
  required Widget child,
  required bool dangXuLy,   // bật/tắt bằng setState
  String? nhan,
})
```

## 7. `quy_tac/giao_dien/bang_danh_sach.dart` — `BangDanhSach` + `HangDuLieu`
Bảng có header, dùng cho danh sách Khách hàng/Sản phẩm/Nhân viên...
```dart
BangDanhSach({
  required List<CotBang> cacCot,  // CotBang(tieuDe, flex: 1, canLe: TextAlign.left)
  required int soHang,
  required Widget Function(BuildContext, int) xayHang, // trả về HangDuLieu
  bool coCotHanhDong = true,
  Widget? khiRong,                // hiện khi soHang == 0 (mặc định: icon hộp rỗng)
})

HangDuLieu({
  required List<Widget> cacO,     // nội dung từng ô, khớp thứ tự cacCot
  List<int>? flexCacO,            // flex riêng từng ô, nên khớp cacCot
  VoidCallback? onXem,   // icon mắt, màu mauThongTin
  VoidCallback? onSua,   // icon bút, màu mauCanhBao
  VoidCallback? onXoa,   // icon thùng rác, màu mauLoi
  VoidCallback? onBam,   // bấm cả hàng (ngoài vùng nút hành động)
})
```
Xem ví dụ đầy đủ (Khách hàng + Sản phẩm) tại `quy_tac/vi_du_bang_danh_sach.dart`.

## 8. `quy_tac/dinh_dang/tien_te.dart` — class `DinhDangTien` + `TienTeInputFormatter`
Hiển thị: có dấu chấm phân cách nghìn, KHÔNG có ký hiệu đ/₫. Lưu DB: số nguyên gốc.
```dart
DinhDangTien.dinhDangTien(5000)        // -> "5.000"   (hiển thị)
DinhDangTien.phanTichTien("5.000")     // -> 5000      (lưu DB)

KhungNhap(inputFormatters: [TienTeInputFormatter()]) // tự thêm dấu chấm khi gõ
```

## 9. `quy_tac/dinh_dang/so_dien_thoai.dart` — class `DinhDangSoDienThoai` + `SoDienThoaiInputFormatter`
Hiển thị: `xxxx.xxx.xxx` (10 số). Lưu DB: chuỗi 10 số liền, không dấu chấm.
```dart
DinhDangSoDienThoai.dinhDangSoDienThoai("0912345678")  // -> "0912.345.678"
DinhDangSoDienThoai.laySoTho("0912.345.678")           // -> "0912345678" (lưu DB)
DinhDangSoDienThoai.laSoDienThoaiHopLe(chuoi)          // -> bool, CHỈ check định dạng
// Chưa có check trùng với DB — sẽ viết cùng lúc với màn hình Thêm khách hàng.

KhungNhap(inputFormatters: [SoDienThoaiInputFormatter()]) // tự format khi gõ
```

## 10. `quy_tac/dinh_dang/ngay_gio.dart` — class `DinhDangNgayGio`
```dart
DinhDangNgayGio.ngay(dt)          // "09/07/2026"
DinhDangNgayGio.gio(dt)           // "14:30"
DinhDangNgayGio.ngayGio(dt)       // "09/07/2026 14:30"
DinhDangNgayGio.ngayThang(dt)     // "09/07"
DinhDangNgayGio.thuTrongTuan(dt)  // "Thứ Năm"
DinhDangNgayGio.ngayTuongDoi(dt)  // "Hôm nay, 14:30" / "Hôm qua, ..." / ngayGio(dt)
DinhDangNgayGio.phanTichNgay("09/07/2026")  // -> DateTime? (parse ngược từ input)
DinhDangNgayGio.tinhTuoi(ngaySinh)          // -> int (tuổi hiện tại)
```
Lưu DB: dùng `DateTime.toIso8601String()`, KHÔNG lưu chuỗi đã format.
Yêu cầu: đã gọi `initializeDateFormatting('vi_VN', null)` trong `main()`.

## 11. `quy_tac/dinh_dang/kiem_tra.dart` — class `KiemTra`
Dùng cho tham số `validator` của `KhungNhap`.
```dart
KiemTra.batBuoc                          // không để trống
KiemTra.doDaiToiThieu(6, tenTruong: 'Mật khẩu')
KiemTra.doDaiToiDa(255)
KiemTra.email
KiemTra.soDienThoai                      // dùng lại DinhDangSoDienThoai
KiemTra.soTien(toiThieu: 1, tenTruong: 'Giá bán')
KiemTra.soNguyen
KiemTra.ketHop([KiemTra.batBuoc, KiemTra.soDienThoai])  // gộp nhiều, lỗi đầu tiên
```

## 12. `quy_tac/thong_bao/thong_bao.dart` — class `ThongBao`
Snackbar tự biến mất (3 giây), cần `context`.
```dart
ThongBao.thanhCong(context, 'Lưu thành công');
ThongBao.loi(context, 'Không thể kết nối');
ThongBao.canhBao(context, 'Sắp hết hàng');
ThongBao.thongTin(context, 'Đã đồng bộ dữ liệu');
```

## 13. `quy_tac/thong_bao/hop_thoai.dart` — class `HopThoai`
Dialog chặn thao tác, cần `context`, không dùng GetX.
```dart
final dongY = await HopThoai.xacNhan(
  context,
  tieuDe: 'Xóa sản phẩm?',
  noiDung: '...',
  nhanDongY: 'Đồng ý', nhanHuy: 'Hủy',
  nguyHiem: true,   // nút đồng ý màu đỏ
); // -> bool? (true nếu đồng ý)

await HopThoai.thongBao(context, tieuDe: '...', noiDung: '...', nhanDong: 'Đóng');
```

---

## Quyết định kỹ thuật đã chốt (ghi nhớ để không hỏi lại)
- KHÔNG dùng GetX / bất kỳ state management nào → dùng `StatefulWidget` + `setState`.
- KHÔNG hỗ trợ Dark Mode, chỉ Light Mode.
- Font: Be Vietnam Pro qua package `google_fonts`.
- Đặt tên biến/class/file: tiếng Việt không dấu.
- Cần các package: `google_fonts`, `intl` trong `pubspec.yaml`.
- `main.dart` cần gọi `await initializeDateFormatting('vi_VN', null);` trước `runApp`.
- Card danh sách (Khách hàng, Sản phẩm...) dùng dạng bảng danh sách dọc
  (`BangDanhSach`), KHÔNG dùng dạng lưới/card ảnh lớn.
- Khách hàng KHÔNG cần avatar/ảnh đại diện.
