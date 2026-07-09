import 'package:flutter/material.dart';
import 'mau_sac.dart';
import 'kieu_chu.dart';

/// Các kiểu (biến thể) của nút bấm.
enum KieuNutBam {
  /// Nút chính: nền màu chính, chữ trắng. Dùng cho hành động chính (Lưu, Thanh toán...).
  chinh,

  /// Nút phụ: viền màu chính, nền trong suốt. Dùng cho hành động phụ (Hủy, Quay lại...).
  phu,

  /// Nút nguy hiểm: màu đỏ. Dùng cho hành động xóa/hủy đơn.
  nguyHiem,

  /// Nút dạng văn bản: không viền không nền, chỉ có chữ. Dùng cho link phụ.
  vanBan,
}

/// Kích thước nút bấm.
enum KichThuocNut { nho, vua, lon }

/// Widget nút bấm chuẩn dùng chung toàn app.
///
/// Ví dụ dùng:
/// ```dart
/// NutBam(
///   nhan: 'Lưu',
///   onPressed: () {},
///   kieu: KieuNutBam.chinh,
///   icon: Icons.save_rounded,
/// )
/// ```
class NutBam extends StatelessWidget {
  final String nhan;
  final VoidCallback? onPressed;
  final KieuNutBam kieu;
  final KichThuocNut kichThuoc;
  final IconData? icon;
  final bool dangTai;
  final bool voHieuHoa;

  /// Nếu true, nút sẽ chiếm toàn bộ chiều rộng khung chứa.
  final bool chiemHetChieuRong;

  const NutBam({
    super.key,
    required this.nhan,
    required this.onPressed,
    this.kieu = KieuNutBam.chinh,
    this.kichThuoc = KichThuocNut.vua,
    this.icon,
    this.dangTai = false,
    this.voHieuHoa = false,
    this.chiemHetChieuRong = false,
  });

  // Chiều cao theo kích thước
  double get _chieuCao {
    switch (kichThuoc) {
      case KichThuocNut.nho:
        return 36;
      case KichThuocNut.vua:
        return 46;
      case KichThuocNut.lon:
        return 54;
    }
  }

  // Padding ngang theo kích thước
  double get _paddingNgang {
    switch (kichThuoc) {
      case KichThuocNut.nho:
        return 14;
      case KichThuocNut.vua:
        return 20;
      case KichThuocNut.lon:
        return 28;
    }
  }

  // Cỡ chữ theo kích thước
  double get _coChu {
    switch (kichThuoc) {
      case KichThuocNut.nho:
        return 13;
      case KichThuocNut.vua:
        return 14;
      case KichThuocNut.lon:
        return 16;
    }
  }

  double get _coIcon => kichThuoc == KichThuocNut.nho ? 16 : 18;

  // Màu nền theo kiểu nút
  Color _mauNen(bool voHieuHoaThucTe) {
    if (voHieuHoaThucTe) return MauSac.mauChuVoHieuHoa;
    switch (kieu) {
      case KieuNutBam.chinh:
        return MauSac.mauChinh;
      case KieuNutBam.nguyHiem:
        return MauSac.mauLoi;
      case KieuNutBam.phu:
      case KieuNutBam.vanBan:
        return Colors.transparent;
    }
  }

  // Màu chữ/icon theo kiểu nút
  Color _mauChu(bool voHieuHoaThucTe) {
    if (voHieuHoaThucTe) return MauSac.mauChuGoiY;
    switch (kieu) {
      case KieuNutBam.chinh:
      case KieuNutBam.nguyHiem:
        return MauSac.mauChuTrangSang;
      case KieuNutBam.phu:
        return MauSac.mauChinh;
      case KieuNutBam.vanBan:
        return MauSac.mauChinh;
    }
  }

  // Viền theo kiểu nút
  BorderSide _vien(bool voHieuHoaThucTe) {
    if (kieu == KieuNutBam.phu) {
      return BorderSide(
        color: voHieuHoaThucTe ? MauSac.mauChuVoHieuHoa : MauSac.mauChinh,
        width: 1.5,
      );
    }
    return BorderSide.none;
  }

  @override
  Widget build(BuildContext context) {
    final bool voHieuHoaThucTe = voHieuHoa || dangTai || onPressed == null;
    final Color mauChu = _mauChu(voHieuHoaThucTe);

    final noiDungNut = dangTai
        ? SizedBox(
            width: _coIcon,
            height: _coIcon,
            child: CircularProgressIndicator(strokeWidth: 2, color: mauChu),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: _coIcon, color: mauChu),
                const SizedBox(width: 8),
              ],
              Text(
                nhan,
                style: KieuChu.nhan.copyWith(color: mauChu, fontSize: _coChu),
              ),
            ],
          );

    final nut = SizedBox(
      height: _chieuCao,
      width: chiemHetChieuRong ? double.infinity : null,
      child: ElevatedButton(
        onPressed: voHieuHoaThucTe ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _mauNen(voHieuHoaThucTe),
          disabledBackgroundColor: _mauNen(voHieuHoaThucTe),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: _paddingNgang),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: _vien(voHieuHoaThucTe),
          ),
        ),
        child: noiDungNut,
      ),
    );

    return nut;
  }
}
