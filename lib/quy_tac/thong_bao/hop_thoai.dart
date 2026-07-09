import 'package:flutter/material.dart';
import '../giao_dien/mau_sac.dart';
import '../giao_dien/kieu_chu.dart';
import '../giao_dien/nut_bam.dart';

/// Bộ hàm hiện hộp thoại (Dialog) dùng chung toàn app.
///
/// Khác với [ThongBao] (snackbar, tự biến mất), Dialog CHẶN thao tác
/// của người dùng cho đến khi họ bấm nút — dùng cho các hành động
/// quan trọng cần xác nhận (xóa, hủy đơn) hoặc lỗi cần đọc kỹ.
class HopThoai {
  HopThoai._();

  /// Hộp thoại xác nhận có 2 lựa chọn (Hủy / Đồng ý).
  ///
  /// Trả về `true` nếu người dùng bấm nút đồng ý, `false` hoặc `null`
  /// nếu người dùng bấm Hủy hoặc bấm ra ngoài để đóng.
  ///
  /// Ví dụ dùng:
  /// ```dart
  /// final dongY = await HopThoai.xacNhan(
  ///   context,
  ///   tieuDe: 'Xóa sản phẩm?',
  ///   noiDung: 'Sản phẩm sẽ bị xóa vĩnh viễn, không thể khôi phục.',
  ///   nguyHiem: true,
  /// );
  /// if (dongY == true) {
  ///   // thực hiện xóa
  /// }
  /// ```
  static Future<bool?> xacNhan(
    BuildContext context, {
    required String tieuDe,
    required String noiDung,
    String nhanDongY = 'Đồng ý',
    String nhanHuy = 'Hủy',
    bool nguyHiem = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MauSac.mauBeMat,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(tieuDe, style: KieuChu.tieuDeNho),
        content: Text(noiDung, style: KieuChu.noiDung),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Expanded(
            child: NutBam(
              nhan: nhanHuy,
              kieu: KieuNutBam.phu,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: NutBam(
              nhan: nhanDongY,
              kieu: nguyHiem ? KieuNutBam.nguyHiem : KieuNutBam.chinh,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ),
        ],
      ),
    );
  }

  /// Hộp thoại chỉ để thông báo, có 1 nút "Đóng".
  ///
  /// Dùng khi cần người dùng đọc kỹ 1 thông tin quan trọng (khác với
  /// [ThongBao] tự biến mất sau vài giây).
  ///
  /// Ví dụ dùng:
  /// ```dart
  /// await HopThoai.thongBao(
  ///   context,
  ///   tieuDe: 'Không thể kết nối',
  ///   noiDung: 'Vui lòng kiểm tra lại kết nối máy in hóa đơn.',
  /// );
  /// ```
  static Future<void> thongBao(
    BuildContext context, {
    required String tieuDe,
    required String noiDung,
    String nhanDong = 'Đóng',
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MauSac.mauBeMat,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(tieuDe, style: KieuChu.tieuDeNho),
        content: Text(noiDung, style: KieuChu.noiDung),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          SizedBox(
            width: double.infinity,
            child: NutBam(
              nhan: nhanDong,
              kieu: KieuNutBam.chinh,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
