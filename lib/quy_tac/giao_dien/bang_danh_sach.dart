import 'package:flutter/material.dart';
import 'mau_sac.dart';
import 'kieu_chu.dart';

/// Định nghĩa 1 cột trong [BangDanhSach].
class CotBang {
  /// Tiêu đề cột hiển thị ở header. VD: "Tên khách hàng".
  final String tieuDe;

  /// Tỉ trọng độ rộng cột so với các cột khác (dùng trong Expanded/flex).
  /// Cột nào cần rộng hơn (VD: Tên) thì đặt flex lớn hơn.
  final int flex;

  /// Căn lề nội dung trong cột.
  final TextAlign canLe;

  const CotBang({
    required this.tieuDe,
    this.flex = 1,
    this.canLe = TextAlign.left,
  });
}

/// Widget bảng danh sách dùng chung: có header + nhiều hàng dữ liệu,
/// dùng cho danh sách Khách hàng, Sản phẩm, Nhân viên...
///
/// Mỗi hàng dữ liệu tự truyền vào dưới dạng `List<Widget>` (mỗi Widget ứng
/// với 1 cột trong [cacCot], theo đúng thứ tự), cộng thêm phần Hành động
/// (xem/sửa/xóa) hiển thị cố định bên phải cùng nếu có.
///
/// Ví dụ dùng:
/// ```dart
/// BangDanhSach(
///   cacCot: const [
///     CotBang(tieuDe: 'Tên khách hàng', flex: 2),
///     CotBang(tieuDe: 'Số điện thoại'),
///     CotBang(tieuDe: 'Địa chỉ', flex: 2),
///     CotBang(tieuDe: 'Tuổi', canLe: TextAlign.center),
///     CotBang(tieuDe: 'Ghi chú', flex: 2),
///     CotBang(tieuDe: 'Hạng thành viên'),
///   ],
///   soHang: danhSachKhachHang.length,
///   xayHang: (context, chiSo) {
///     final kh = danhSachKhachHang[chiSo];
///     return HangDuLieu(
///       cacO: [
///         Text(kh.ten, style: KieuChu.noiDungDam),
///         Text(DinhDangSoDienThoai.dinhDangSoDienThoai(kh.soDienThoai)),
///         Text(kh.diaChi, style: KieuChu.moTa),
///         Text('${DinhDangNgayGio.tinhTuoi(kh.ngaySinh)}'),
///         Text(kh.ghiChu ?? '', style: KieuChu.moTa),
///         NhanTrangThai(nhan: kh.hangThanhVien, loai: LoaiTrangThai.thongTin),
///       ],
///       onXem: () {},
///       onSua: () {},
///       onXoa: () {},
///     );
///   },
/// )
/// ```
class BangDanhSach extends StatelessWidget {
  final List<CotBang> cacCot;
  final int soHang;
  final Widget Function(BuildContext context, int chiSo) xayHang;

  /// true nếu cần cột Hành động (xem/sửa/xóa) bên phải cùng.
  final bool coCotHanhDong;

  /// Hiển thị khi [soHang] bằng 0.
  final Widget? khiRong;

  const BangDanhSach({
    super.key,
    required this.cacCot,
    required this.soHang,
    required this.xayHang,
    this.coCotHanhDong = true,
    this.khiRong,
  });

  static const double _doRongCotHanhDong = 120;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MauSac.mauBeMat,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MauSac.mauVien),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          _HeaderBang(cacCot: cacCot, coCotHanhDong: coCotHanhDong),
          if (soHang == 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: khiRong ?? _RongMacDinh(),
            )
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: soHang,
                separatorBuilder: (_, _) =>
                    Divider(height: 1, color: MauSac.mauPhanCach),
                itemBuilder: xayHang,
              ),
            ),
        ],
      ),
    );
  }
}

class _HeaderBang extends StatelessWidget {
  final List<CotBang> cacCot;
  final bool coCotHanhDong;

  const _HeaderBang({required this.cacCot, required this.coCotHanhDong});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: MauSac.mauNen,
        border: Border(bottom: BorderSide(color: MauSac.mauVien)),
      ),
      child: Row(
        children: [
          for (final cot in cacCot)
            Expanded(
              flex: cot.flex,
              child: Text(
                cot.tieuDe,
                textAlign: cot.canLe,
                style: KieuChu.nhanNho.copyWith(color: MauSac.mauChuMoTa),
              ),
            ),
          if (coCotHanhDong)
            SizedBox(
              width: BangDanhSach._doRongCotHanhDong,
              child: Text(
                'Hành động',
                textAlign: TextAlign.center,
                style: KieuChu.nhanNho.copyWith(color: MauSac.mauChuMoTa),
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget 1 hàng dữ liệu trong [BangDanhSach].
///
/// [cacO] phải có số lượng và thứ tự khớp với [BangDanhSach.cacCot].
class HangDuLieu extends StatelessWidget {
  final List<Widget> cacO;
  final List<int>? flexCacO;

  final VoidCallback? onXem;
  final VoidCallback? onSua;
  final VoidCallback? onXoa;

  /// Bấm vào bất kỳ đâu trên hàng (ngoài vùng nút hành động).
  final VoidCallback? onBam;

  const HangDuLieu({
    super.key,
    required this.cacO,
    this.flexCacO,
    this.onXem,
    this.onSua,
    this.onXoa,
    this.onBam,
  });

  bool get _coCotHanhDong => onXem != null || onSua != null || onXoa != null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBam,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            for (int i = 0; i < cacO.length; i++)
              Expanded(
                flex: flexCacO != null && i < flexCacO!.length
                    ? flexCacO![i]
                    : 1,
                child: cacO[i],
              ),
            if (_coCotHanhDong)
              SizedBox(
                width: BangDanhSach._doRongCotHanhDong,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onXem != null)
                      _NutHanhDong(
                        icon: Icons.visibility_outlined,
                        mau: MauSac.mauThongTin,
                        onTap: onXem!,
                      ),
                    if (onSua != null)
                      _NutHanhDong(
                        icon: Icons.edit_outlined,
                        mau: MauSac.mauCanhBao,
                        onTap: onSua!,
                      ),
                    if (onXoa != null)
                      _NutHanhDong(
                        icon: Icons.delete_outline_rounded,
                        mau: MauSac.mauLoi,
                        onTap: onXoa!,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NutHanhDong extends StatelessWidget {
  final IconData icon;
  final Color mau;
  final VoidCallback onTap;

  const _NutHanhDong({
    required this.icon,
    required this.mau,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: mau.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 17, color: mau),
        ),
      ),
    );
  }
}

class _RongMacDinh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 40, color: MauSac.mauChuGoiY),
          const SizedBox(height: 10),
          Text('Chưa có dữ liệu', style: KieuChu.moTa),
        ],
      ),
    );
  }
}
