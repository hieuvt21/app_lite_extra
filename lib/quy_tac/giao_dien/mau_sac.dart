import 'package:flutter/material.dart';

/// Bộ màu sắc chuẩn dùng chung cho toàn bộ ứng dụng.
///
/// Quy tắc: mọi nơi trong app cần dùng màu thì lấy từ đây,
/// KHÔNG khai báo Color(0x...) trực tiếp trong widget nữa.
/// Nếu sau này cần đổi màu thương hiệu, chỉ cần sửa 1 chỗ duy nhất.
class MauSac {
  MauSac._(); // Không cho khởi tạo class này

  // ============ MÀU THƯƠNG HIỆU (BRAND) ============
  /// Màu chính của thương hiệu, dùng cho nút bấm chính, icon active, highlight.
  static const Color mauChinh = Color(0xFF6366F1);

  /// Sắc độ nhạt hơn của màu chính, dùng cho nền hover, badge, icon background.
  static const Color mauChinhNhat = Color(0xFFE0E7FF);

  /// Sắc độ đậm hơn của màu chính, dùng cho trạng thái pressed/active đậm.
  static const Color mauChinhDam = Color(0xFF4F46E5);

  // ============ MÀU TRẠNG THÁI (STATUS) ============
  /// Thành công: thanh toán OK, còn hàng, hoàn tất đơn.
  static const Color mauThanhCong = Color(0xFF22C55E);
  static const Color mauThanhCongNhat = Color(0xFFDCFCE7);

  /// Cảnh báo: sắp hết hàng, chờ xử lý, cần chú ý.
  static const Color mauCanhBao = Color(0xFFF59E0B);
  static const Color mauCanhBaoNhat = Color(0xFFFEF3C7);

  /// Lỗi: hết hàng, hủy đơn, lỗi thao tác, xóa.
  static const Color mauLoi = Color(0xFFEF4444);
  static const Color mauLoiNhat = Color(0xFFFEE2E2);

  /// Thông tin: thông báo chung, gợi ý.
  static const Color mauThongTin = Color(0xFF3B82F6);
  static const Color mauThongTinNhat = Color(0xFFDBEAFE);

  // ============ MÀU CHỮ (TEXT) ============
  /// Chữ tiêu đề, đậm nhất, độ tương phản cao nhất.
  static const Color mauChuTieuDe = Color(0xFF1E293B);

  /// Chữ nội dung thường.
  static const Color mauChuNoiDung = Color(0xFF334155);

  /// Chữ mô tả/phụ, nhạt hơn (VD: dòng mô tả dưới tiêu đề).
  static const Color mauChuMoTa = Color(0xFF64748B);

  /// Chữ gợi ý/placeholder, nhạt nhất.
  static const Color mauChuGoiY = Color(0xFF94A3B8);

  /// Chữ trạng thái vô hiệu hóa (disabled).
  static const Color mauChuVoHieuHoa = Color(0xFFCBD5E1);

  /// Chữ màu trắng, dùng trên nền màu đậm (nút bấm, badge).
  static const Color mauChuTrangSang = Colors.white;

  // ============ MÀU NỀN & BỀ MẶT (BACKGROUND/SURFACE) ============
  /// Nền chính của toàn app (phía sau các card).
  static const Color mauNen = Color(0xFFF8FAFC);

  /// Nền bề mặt card/khối nội dung (thường là trắng).
  static const Color mauBeMat = Colors.white;

  // ============ MÀU VIỀN & PHÂN CÁCH (BORDER/DIVIDER) ============
  /// Viền input, card, đường phân cách rõ.
  static const Color mauVien = Color(0xFFE2E8F0);

  /// Đường phân cách mảnh, tinh tế hơn viền.
  static const Color mauPhanCach = Color(0xFFF1F5F9);
}
