import 'package:flutter/services.dart';

/// Bộ hàm & formatter xử lý hiển thị/nhập liệu số điện thoại (VN, 10 số).
///
/// Quy tắc chung:
/// - HIỂN THỊ (UI): dạng "xxxx.xxx.xxx". VD: 0912345678 -> "0912.345.678"
/// - LƯU DATABASE: chỉ lưu 10 chữ số gốc, KHÔNG dấu chấm.
///
/// Lưu ý: hàm chống trùng số điện thoại (kiểm tra với database) CHƯA có
/// trong file này vì cần kết nối tới tầng dữ liệu thực tế (SQLite).
/// Sẽ được viết cùng lúc với màn hình Thêm/Sửa khách hàng.
class DinhDangSoDienThoai {
  DinhDangSoDienThoai._();

  /// Chuyển số thô (chỉ chữ số, từ DB) -> chuỗi hiển thị dạng "xxxx.xxx.xxx".
  ///
  /// VD: dinhDangSoDienThoai("0912345678") -> "0912.345.678"
  /// Nếu số không đủ 10 chữ số, trả về nguyên số thô (không format).
  static String dinhDangSoDienThoai(String soTho) {
    final String so = _layChuSo(soTho);
    if (so.length != 10) return so;

    final String nhom1 = so.substring(0, 4);
    final String nhom2 = so.substring(4, 7);
    final String nhom3 = so.substring(7, 10);
    return '$nhom1.$nhom2.$nhom3';
  }

  /// Chuyển chuỗi đang hiển thị (có dấu chấm) -> số thô 10 chữ số để lưu DB.
  ///
  /// VD: laySoTho("0912.345.678") -> "0912345678"
  static String laySoTho(String chuoiHienThi) {
    return _layChuSo(chuoiHienThi);
  }

  /// Kiểm tra định dạng số điện thoại có hợp lệ không:
  /// - Đúng 10 chữ số
  /// - Bắt đầu bằng số 0
  ///
  /// Chỉ kiểm tra ĐỊNH DẠNG, KHÔNG kiểm tra trùng lặp với dữ liệu đã có.
  static bool laSoDienThoaiHopLe(String chuoi) {
    final String so = _layChuSo(chuoi);
    if (so.length != 10) return false;
    if (!so.startsWith('0')) return false;
    return RegExp(r'^[0-9]{10}$').hasMatch(so);
  }

  static String _layChuSo(String chuoi) {
    return chuoi.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

/// InputFormatter gắn vào TextField/KhungNhap để tự động format số điện
/// thoại theo dạng "xxxx.xxx.xxx" ngay khi người dùng đang gõ, giới hạn
/// tối đa 10 chữ số.
///
/// Ví dụ dùng:
/// ```dart
/// KhungNhap(
///   nhan: 'Số điện thoại',
///   kieuBanPhim: TextInputType.phone,
///   inputFormatters: [SoDienThoaiInputFormatter()],
/// )
/// ```
/// Khi cần lấy số gốc để lưu DB, dùng:
/// `DinhDangSoDienThoai.laySoTho(controller.text)`
class SoDienThoaiInputFormatter extends TextInputFormatter {
  static const int _soChuSoToiDa = 10;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String soThuan = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (soThuan.length > _soChuSoToiDa) {
      soThuan = soThuan.substring(0, _soChuSoToiDa);
    }

    if (soThuan.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < soThuan.length; i++) {
      buffer.write(soThuan[i]);
      final int viTri = i + 1;
      final bool chuaPhaiKyTuCuoi = viTri != soThuan.length;
      if (chuaPhaiKyTuCuoi && (viTri == 4 || viTri == 7)) {
        buffer.write('.');
      }
    }

    final String chuoiMoi = buffer.toString();
    return TextEditingValue(
      text: chuoiMoi,
      selection: TextSelection.collapsed(offset: chuoiMoi.length),
    );
  }
}
