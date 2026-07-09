import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mau_sac.dart';

/// Bộ kiểu chữ (typography) chuẩn dùng chung cho toàn bộ ứng dụng.
///
/// Quy tắc: mọi Text trong app nên dùng style từ đây thay vì tự khai báo
/// TextStyle(fontSize: ..., fontWeight: ...) rải rác ở từng page.
/// Đặt tên theo NGỮ CẢNH SỬ DỤNG, không đặt theo size, để khi cần chỉnh
/// (VD: đổi font toàn app) chỉ cần sửa 1 chỗ.
class KieuChu {
  KieuChu._(); // Không cho khởi tạo class này

  static TextStyle _taoKieu({
    required double size,
    required FontWeight weight,
    Color mau = MauSac.mauChuTieuDe,
    double? chieuCaoDong,
  }) {
    return GoogleFonts.beVietnamPro(
      fontSize: size,
      fontWeight: weight,
      color: mau,
      height: chieuCaoDong,
    );
  }

  // ============ TIÊU ĐỀ ============
  /// Tiêu đề lớn nhất — dùng cho tiêu đề trang chính, màn hình.
  static TextStyle tieuDeLon = _taoKieu(size: 24, weight: FontWeight.bold);

  /// Tiêu đề vừa — dùng cho tiêu đề section, card lớn.
  /// (VD: chữ "Tổng quan" ở trang chủ hiện tại)
  static TextStyle tieuDeVua = _taoKieu(size: 18, weight: FontWeight.bold);

  /// Tiêu đề nhỏ — dùng cho tiêu đề card nhỏ, mục con.
  static TextStyle tieuDeNho = _taoKieu(size: 15, weight: FontWeight.w600);

  // ============ NỘI DUNG ============
  /// Nội dung thường — dùng cho văn bản chính, mô tả dài.
  static TextStyle noiDung = _taoKieu(
    size: 14,
    weight: FontWeight.normal,
    mau: MauSac.mauChuNoiDung,
  );

  /// Nội dung đậm — nhấn mạnh trong đoạn văn, tên sản phẩm trong danh sách.
  static TextStyle noiDungDam = _taoKieu(
    size: 14,
    weight: FontWeight.w600,
    mau: MauSac.mauChuNoiDung,
  );

  // ============ MÔ TẢ / PHỤ ============
  /// Chữ mô tả nhỏ, phụ — dùng cho dòng ghi chú dưới tiêu đề.
  /// (VD: "Phân hệ đang được kết nối cấu trúc độc lập.")
  static TextStyle moTa = _taoKieu(
    size: 13,
    weight: FontWeight.normal,
    mau: MauSac.mauChuMoTa,
  );

  /// Chữ gợi ý/placeholder trong input, ô tìm kiếm.
  static TextStyle goiY = _taoKieu(
    size: 13,
    weight: FontWeight.normal,
    mau: MauSac.mauChuGoiY,
  );

  // ============ NHÃN (LABEL) ============
  /// Nhãn cho input, button, tab menu.
  static TextStyle nhan = _taoKieu(size: 14, weight: FontWeight.w600);

  /// Nhãn nhỏ — dùng cho badge, tag trạng thái.
  static TextStyle nhanNho = _taoKieu(size: 12, weight: FontWeight.w600);

  // ============ SỐ LIỆU NỔI BẬT ============
  /// Dùng riêng cho hiển thị giá tiền, số lượng lớn trong màn hình bán hàng/POS.
  static TextStyle soLieuLon = _taoKieu(size: 28, weight: FontWeight.bold);

  /// Số liệu cỡ vừa — dùng trong bảng, danh sách đơn hàng.
  static TextStyle soLieuVua = _taoKieu(size: 16, weight: FontWeight.w700);
}
