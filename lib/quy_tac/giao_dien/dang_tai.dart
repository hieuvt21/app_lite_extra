import 'package:flutter/material.dart';
import 'mau_sac.dart';
import 'kieu_chu.dart';

/// Spinner loading nhỏ, dùng lồng trong 1 khu vực nhỏ (VD: giữa 1 card
/// đang tải dữ liệu), KHÔNG chặn toàn màn hình.
///
/// Ví dụ dùng:
/// ```dart
/// dangTaiDuLieu ? const WidgetDangTai() : DanhSachSanPham(...)
/// ```
class WidgetDangTai extends StatelessWidget {
  /// Chữ hiển thị phía dưới spinner (tùy chọn). VD: "Đang tải dữ liệu...".
  final String? nhan;
  final double kichThuoc;

  const WidgetDangTai({super.key, this.nhan, this.kichThuoc = 32});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: kichThuoc,
            height: kichThuoc,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: MauSac.mauChinh,
            ),
          ),
          if (nhan != null) ...[
            const SizedBox(height: 12),
            Text(nhan!, style: KieuChu.moTa),
          ],
        ],
      ),
    );
  }
}

/// Lớp phủ đang tải toàn màn hình/toàn khu vực, CHẶN người dùng thao
/// tác trong lúc chờ xử lý (VD: đang lưu đơn hàng vào database).
///
/// Bọc quanh widget nội dung của page, bật/tắt bằng cờ [dangXuLy].
///
/// Ví dụ dùng:
/// ```dart
/// class _TrangThanhToanState extends State<TrangThanhToan> {
///   bool _dangXuLy = false;
///
///   Future<void> _luuDonHang() async {
///     setState(() => _dangXuLy = true);
///     await luuVaoDatabase();
///     setState(() => _dangXuLy = false);
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return LopPhuDangTai(
///       dangXuLy: _dangXuLy,
///       nhan: 'Đang xử lý thanh toán...',
///       child: NoiDungTrang(...),
///     );
///   }
/// }
/// ```
class LopPhuDangTai extends StatelessWidget {
  final Widget child;
  final bool dangXuLy;

  /// Chữ hiển thị dưới spinner khi đang xử lý.
  final String? nhan;

  const LopPhuDangTai({
    super.key,
    required this.child,
    required this.dangXuLy,
    this.nhan,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (dangXuLy)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: MauSac.mauBeMat,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: MauSac.mauChinh,
                          ),
                        ),
                        if (nhan != null) ...[
                          const SizedBox(height: 14),
                          Text(nhan!, style: KieuChu.noiDungDam),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
