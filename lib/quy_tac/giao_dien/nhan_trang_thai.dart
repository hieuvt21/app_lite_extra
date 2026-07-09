import 'package:flutter/material.dart';
import 'mau_sac.dart';
import 'kieu_chu.dart';

/// Các loại trạng thái, quyết định màu sắc của nhãn.
enum LoaiTrangThai {
  /// Màu xanh lá. VD: "Còn hàng", "Hoàn thành", "Đang làm việc".
  thanhCong,

  /// Màu vàng cam. VD: "Sắp hết hàng", "Đang xử lý", "Chờ duyệt".
  canhBao,

  /// Màu đỏ. VD: "Hết hàng", "Đã hủy", "Nghỉ việc".
  loi,

  /// Màu xanh dương. VD: "Mới", "Đang giao".
  thongTin,

  /// Màu xám. VD: "Bản nháp", "Chưa xác định", "Vô hiệu hóa".
  trungLap,
}

/// Widget nhãn trạng thái (badge/tag) hình viên thuốc, dùng để hiển thị
/// nhanh trạng thái trong danh sách, bảng dữ liệu, card sản phẩm...
///
/// Ví dụ dùng:
/// ```dart
/// NhanTrangThai(nhan: 'Còn hàng', loai: LoaiTrangThai.thanhCong)
/// NhanTrangThai(nhan: 'Đã hủy', loai: LoaiTrangThai.loi)
/// ```
class NhanTrangThai extends StatelessWidget {
  final String nhan;
  final LoaiTrangThai loai;

  /// true để hiện 1 chấm tròn nhỏ phía trước chữ (thay vì icon).
  final bool coChamTron;

  const NhanTrangThai({
    super.key,
    required this.nhan,
    required this.loai,
    this.coChamTron = false,
  });

  ({Color mauNen, Color mauChu}) get _mauSac {
    switch (loai) {
      case LoaiTrangThai.thanhCong:
        return (mauNen: MauSac.mauThanhCongNhat, mauChu: MauSac.mauThanhCong);
      case LoaiTrangThai.canhBao:
        return (mauNen: MauSac.mauCanhBaoNhat, mauChu: MauSac.mauCanhBao);
      case LoaiTrangThai.loi:
        return (mauNen: MauSac.mauLoiNhat, mauChu: MauSac.mauLoi);
      case LoaiTrangThai.thongTin:
        return (mauNen: MauSac.mauThongTinNhat, mauChu: MauSac.mauThongTin);
      case LoaiTrangThai.trungLap:
        return (mauNen: MauSac.mauPhanCach, mauChu: MauSac.mauChuMoTa);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mau = _mauSac;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: mau.mauNen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (coChamTron) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: mau.mauChu,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            nhan,
            style: KieuChu.nhanNho.copyWith(color: mau.mauChu),
          ),
        ],
      ),
    );
  }
}
