import 'package:intl/intl.dart';

/// Bộ hàm xử lý hiển thị ngày giờ dùng chung toàn app.
///
/// Quy tắc chung:
/// - HIỂN THỊ (UI): dạng "dd/MM/yyyy" hoặc "dd/MM/yyyy HH:mm".
/// - LƯU DATABASE: khuyến nghị lưu dạng ISO8601 (DateTime.toIso8601String())
///   hoặc epoch (millisecondsSinceEpoch) tùy schema, KHÔNG lưu chuỗi đã format.
class DinhDangNgayGio {
  DinhDangNgayGio._();

  static final DateFormat _ngay = DateFormat('dd/MM/yyyy', 'vi_VN');
  static final DateFormat _gio = DateFormat('HH:mm', 'vi_VN');
  static final DateFormat _ngayGio = DateFormat('dd/MM/yyyy HH:mm', 'vi_VN');
  static final DateFormat _thu = DateFormat('EEEE', 'vi_VN');
  static final DateFormat _ngayThang = DateFormat('dd/MM', 'vi_VN');

  /// VD: 09/07/2026
  static String ngay(DateTime thoiGian) => _ngay.format(thoiGian);

  /// VD: 14:30
  static String gio(DateTime thoiGian) => _gio.format(thoiGian);

  /// VD: 09/07/2026 14:30
  static String ngayGio(DateTime thoiGian) => _ngayGio.format(thoiGian);

  /// VD: 09/07
  static String ngayThang(DateTime thoiGian) => _ngayThang.format(thoiGian);

  /// VD: Thứ Năm
  static String thuTrongTuan(DateTime thoiGian) => _thu.format(thoiGian);

  /// Hiển thị dạng tương đối, thân thiện: "Hôm nay", "Hôm qua", hoặc dd/MM/yyyy.
  /// Hữu ích cho danh sách đơn hàng/hóa đơn gần đây.
  static String ngayTuongDoi(DateTime thoiGian) {
    final DateTime bayGio = DateTime.now();
    final DateTime homNay = DateTime(bayGio.year, bayGio.month, bayGio.day);
    final DateTime ngayCanSo = DateTime(
      thoiGian.year,
      thoiGian.month,
      thoiGian.day,
    );
    final int soNgayChenhLech = homNay.difference(ngayCanSo).inDays;

    if (soNgayChenhLech == 0) return 'Hôm nay, ${gio(thoiGian)}';
    if (soNgayChenhLech == 1) return 'Hôm qua, ${gio(thoiGian)}';
    return ngayGio(thoiGian);
  }

  /// Parse chuỗi "dd/MM/yyyy" (do người dùng nhập) -> DateTime.
  /// Trả về null nếu chuỗi không hợp lệ.
  static DateTime? phanTichNgay(String chuoi) {
    try {
      return _ngay.parseStrict(chuoi);
    } catch (_) {
      return null;
    }
  }

  /// Tính tuổi (số nguyên) từ ngày sinh, so với ngày hiện tại.
  ///
  /// VD: ngaySinh = 15/03/2000, hôm nay = 09/07/2026 -> trả về 26
  /// (đã trừ trường hợp chưa tới sinh nhật trong năm nay).
  static int tinhTuoi(DateTime ngaySinh) {
    final DateTime homNay = DateTime.now();
    int tuoi = homNay.year - ngaySinh.year;

    final bool chuaToiSinhNhatNamNay =
        homNay.month < ngaySinh.month ||
        (homNay.month == ngaySinh.month && homNay.day < ngaySinh.day);

    if (chuaToiSinhNhatNamNay) tuoi--;
    return tuoi < 0 ? 0 : tuoi;
  }
}
