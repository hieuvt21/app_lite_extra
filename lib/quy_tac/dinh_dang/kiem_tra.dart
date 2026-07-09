import 'so_dien_thoai.dart';

/// Kiểu hàm validator chuẩn dùng cho tham số `validator` của TextFormField
/// / KhungNhap: nhận vào giá trị đang nhập, trả về chuỗi lỗi (nếu sai)
/// hoặc null (nếu hợp lệ).
typedef HamKiemTra = String? Function(String?);

/// Bộ hàm kiểm tra (validate) dữ liệu nhập dùng chung toàn app.
///
/// Ví dụ dùng trực tiếp:
/// ```dart
/// KhungNhap(
///   nhan: 'Tên khách hàng',
///   validator: KiemTra.batBuoc,
/// )
/// ```
///
/// Ví dụ kết hợp nhiều điều kiện:
/// ```dart
/// KhungNhap(
///   nhan: 'Số điện thoại',
///   validator: KiemTra.ketHop([
///     KiemTra.batBuoc,
///     KiemTra.soDienThoai,
///   ]),
/// )
/// ```
class KiemTra {
  KiemTra._();

  // ============ CƠ BẢN ============

  /// Bắt buộc nhập, không được để trống.
  static String? batBuoc(String? giaTri, {String? tenTruong}) {
    if (giaTri == null || giaTri.trim().isEmpty) {
      return 'Vui lòng nhập ${tenTruong ?? "thông tin này"}';
    }
    return null;
  }

  /// Độ dài tối thiểu [soKyTu] ký tự.
  static HamKiemTra doDaiToiThieu(int soKyTu, {String? tenTruong}) {
    return (giaTri) {
      if (giaTri == null || giaTri.trim().length < soKyTu) {
        return '${tenTruong ?? "Nội dung"} phải có ít nhất $soKyTu ký tự';
      }
      return null;
    };
  }

  /// Độ dài tối đa [soKyTu] ký tự.
  static HamKiemTra doDaiToiDa(int soKyTu, {String? tenTruong}) {
    return (giaTri) {
      if (giaTri != null && giaTri.trim().length > soKyTu) {
        return '${tenTruong ?? "Nội dung"} không được vượt quá $soKyTu ký tự';
      }
      return null;
    };
  }

  /// Đúng định dạng email.
  static String? email(String? giaTri) {
    if (giaTri == null || giaTri.trim().isEmpty) return null;
    final regex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\.\-]+$');
    if (!regex.hasMatch(giaTri.trim())) {
      return 'Email không đúng định dạng';
    }
    return null;
  }

  // ============ ĐẶC THÙ NGHIỆP VỤ ============

  /// Số điện thoại hợp lệ (10 số, bắt đầu bằng 0).
  /// Dùng lại logic đã có trong [DinhDangSoDienThoai].
  static String? soDienThoai(String? giaTri) {
    if (giaTri == null || giaTri.trim().isEmpty) return null;
    if (!DinhDangSoDienThoai.laSoDienThoaiHopLe(giaTri)) {
      return 'Số điện thoại không hợp lệ (cần đủ 10 số)';
    }
    return null;
  }

  /// Số tiền hợp lệ, có thể yêu cầu tối thiểu (VD: giá bán phải > 0).
  static HamKiemTra soTien({int toiThieu = 0, String? tenTruong}) {
    return (giaTri) {
      if (giaTri == null || giaTri.trim().isEmpty) return null;
      final soThuan = giaTri.replaceAll('.', '');
      final so = int.tryParse(soThuan);
      if (so == null) {
        return '${tenTruong ?? "Số tiền"} không hợp lệ';
      }
      if (so < toiThieu) {
        return '${tenTruong ?? "Số tiền"} phải từ ${toiThieu.toString()} trở lên';
      }
      return null;
    };
  }

  /// Chỉ chấp nhận số nguyên (VD: số lượng tồn kho).
  static String? soNguyen(String? giaTri) {
    if (giaTri == null || giaTri.trim().isEmpty) return null;
    if (int.tryParse(giaTri.trim()) == null) {
      return 'Vui lòng chỉ nhập số';
    }
    return null;
  }

  // ============ KẾT HỢP NHIỀU ĐIỀU KIỆN ============

  /// Chạy lần lượt các validator, trả về lỗi ĐẦU TIÊN gặp phải.
  /// Nếu tất cả đều hợp lệ, trả về null.
  static HamKiemTra ketHop(List<HamKiemTra> cacHamKiemTra) {
    return (giaTri) {
      for (final ham in cacHamKiemTra) {
        final loi = ham(giaTri);
        if (loi != null) return loi;
      }
      return null;
    };
  }
}
