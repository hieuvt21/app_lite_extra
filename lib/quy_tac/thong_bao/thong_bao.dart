import 'package:flutter/material.dart';
import '../giao_dien/mau_sac.dart';
import '../giao_dien/kieu_chu.dart';

/// Các loại thông báo (quyết định màu sắc & icon hiển thị).
enum _LoaiThongBao { thanhCong, loi, canhBao, thongTin }

/// Bộ hàm hiện thông báo dạng Snackbar (nổi lên từ dưới, tự biến mất)
/// dùng chung toàn app.
///
/// Dùng cho các thông báo ngắn, không chặn thao tác của người dùng
/// (VD: "Đã lưu sản phẩm", "Xóa thất bại").
///
/// Ví dụ dùng:
/// ```dart
/// ThongBao.thanhCong(context, 'Lưu sản phẩm thành công');
/// ThongBao.loi(context, 'Không thể kết nối tới cơ sở dữ liệu');
/// ```
class ThongBao {
  ThongBao._();

  /// Thông báo thành công (màu xanh lá). VD: lưu OK, thanh toán xong.
  static void thanhCong(BuildContext context, String noiDung) {
    _hienThi(
      context,
      noiDung: noiDung,
      loai: _LoaiThongBao.thanhCong,
    );
  }

  /// Thông báo lỗi (màu đỏ). VD: lỗi lưu DB, thao tác thất bại.
  static void loi(BuildContext context, String noiDung) {
    _hienThi(context, noiDung: noiDung, loai: _LoaiThongBao.loi);
  }

  /// Thông báo cảnh báo (màu vàng cam). VD: sắp hết hàng.
  static void canhBao(BuildContext context, String noiDung) {
    _hienThi(context, noiDung: noiDung, loai: _LoaiThongBao.canhBao);
  }

  /// Thông báo thông tin chung (màu xanh dương).
  static void thongTin(BuildContext context, String noiDung) {
    _hienThi(context, noiDung: noiDung, loai: _LoaiThongBao.thongTin);
  }

  static ({Color mauNen, IconData icon}) _theoLoai(_LoaiThongBao loai) {
    switch (loai) {
      case _LoaiThongBao.thanhCong:
        return (mauNen: MauSac.mauThanhCong, icon: Icons.check_circle_rounded);
      case _LoaiThongBao.loi:
        return (mauNen: MauSac.mauLoi, icon: Icons.error_rounded);
      case _LoaiThongBao.canhBao:
        return (mauNen: MauSac.mauCanhBao, icon: Icons.warning_rounded);
      case _LoaiThongBao.thongTin:
        return (mauNen: MauSac.mauThongTin, icon: Icons.info_rounded);
    }
  }

  static void _hienThi(
    BuildContext context, {
    required String noiDung,
    required _LoaiThongBao loai,
  }) {
    final thongTinLoai = _theoLoai(loai);

    // Ẩn thông báo cũ trước để tránh chồng chất khi bấm nhanh nhiều lần.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: thongTinLoai.mauNen,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
        content: Row(
          children: [
            Icon(thongTinLoai.icon, color: MauSac.mauChuTrangSang, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                noiDung,
                style: KieuChu.noiDungDam.copyWith(
                  color: MauSac.mauChuTrangSang,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
