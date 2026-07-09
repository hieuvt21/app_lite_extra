import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Bộ hàm & formatter xử lý hiển thị/nhập liệu tiền tệ (VNĐ).
///
/// Quy tắc chung:
/// - HIỂN THỊ (UI): có dấu chấm phân cách hàng nghìn. VD: 5000 -> "5.000"
/// - LƯU DATABASE: chỉ lưu số nguyên gốc, KHÔNG dấu chấm. VD: 5000
class DinhDangTien {
  DinhDangTien._();

  static final NumberFormat _boDinhDang = NumberFormat('#,###', 'vi_VN');

  /// Chuyển số nguyên (giá trị gốc) -> chuỗi hiển thị có dấu chấm.
  ///
  /// VD: dinhDangTien(5000) -> "5.000"
  static String dinhDangTien(num giaTri) {
    return _boDinhDang.format(giaTri).replaceAll(',', '.');
  }

  /// Chuyển chuỗi đang hiển thị (có dấu chấm) -> số nguyên gốc để lưu DB.
  ///
  /// VD: phanTichTien("5.000") -> 5000
  /// Chuỗi rỗng hoặc không hợp lệ -> trả về 0.
  static int phanTichTien(String chuoiHienThi) {
    final String soThuan = chuoiHienThi.replaceAll('.', '').trim();
    if (soThuan.isEmpty) return 0;
    return int.tryParse(soThuan) ?? 0;
  }
}

/// InputFormatter gắn vào TextField/KhungNhap để tự động thêm dấu chấm
/// phân cách hàng nghìn ngay khi người dùng đang gõ số tiền.
///
/// Ví dụ dùng:
/// ```dart
/// KhungNhap(
///   nhan: 'Giá bán',
///   kieuBanPhim: TextInputType.number,
///   inputFormatters: [TienTeInputFormatter()],
/// )
/// ```
/// Khi cần lấy giá trị gốc để lưu DB, dùng:
/// `DinhDangTien.phanTichTien(controller.text)`
class TienTeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Chỉ giữ lại chữ số, bỏ hết dấu chấm người dùng gõ hoặc dấu cũ.
    final String soThuan = newValue.text.replaceAll('.', '');

    if (soThuan.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final int? giaTri = int.tryParse(soThuan);
    if (giaTri == null) {
      return oldValue;
    }

    final String chuoiMoi = DinhDangTien.dinhDangTien(giaTri);

    return TextEditingValue(
      text: chuoiMoi,
      selection: TextSelection.collapsed(offset: chuoiMoi.length),
    );
  }
}
