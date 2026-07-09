import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mau_sac.dart';
import 'kieu_chu.dart';

/// Widget khung nhập liệu (input) chuẩn dùng chung toàn app.
///
/// Bọc quanh [TextFormField], tự động áp dụng màu sắc và kiểu chữ
/// theo [MauSac] và [KieuChu], có label phía trên và hiện lỗi validate.
///
/// Ví dụ dùng:
/// ```dart
/// KhungNhap(
///   nhan: 'Số điện thoại',
///   goiY: 'Nhập số điện thoại khách hàng',
///   controller: soDienThoaiController,
///   kieuBanPhim: TextInputType.phone,
/// )
/// ```
class KhungNhap extends StatefulWidget {
  /// Nhãn hiển thị phía trên ô nhập (VD: "Số điện thoại").
  final String? nhan;

  /// Chữ gợi ý hiển thị bên trong ô khi chưa nhập gì.
  final String? goiY;

  final TextEditingController? controller;

  /// Hàm validate, trả về chuỗi lỗi nếu không hợp lệ, null nếu hợp lệ.
  final String? Function(String?)? validator;

  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  final IconData? iconTruoc;
  final Widget? iconSau;

  final TextInputType kieuBanPhim;
  final List<TextInputFormatter>? inputFormatters;

  /// true nếu là ô nhập mật khẩu (tự động ẩn/hiện chữ).
  final bool laMatKhau;

  /// true nếu chỉ đọc, không cho nhập trực tiếp (VD: ô chọn ngày, chọn khách hàng).
  final bool chiDoc;

  final bool voHieuHoa;
  final int soDong;
  final VoidCallback? onTap;
  final AutovalidateMode autovalidateMode;

  const KhungNhap({
    super.key,
    this.nhan,
    this.goiY,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.iconTruoc,
    this.iconSau,
    this.kieuBanPhim = TextInputType.text,
    this.inputFormatters,
    this.laMatKhau = false,
    this.chiDoc = false,
    this.voHieuHoa = false,
    this.soDong = 1,
    this.onTap,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<KhungNhap> createState() => _KhungNhapState();
}

class _KhungNhapState extends State<KhungNhap> {
  bool _anMatKhau = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.nhan != null) ...[
          Text(widget.nhan!, style: KieuChu.nhan),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          keyboardType: widget.kieuBanPhim,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.laMatKhau && _anMatKhau,
          readOnly: widget.chiDoc,
          enabled: !widget.voHieuHoa,
          maxLines: widget.laMatKhau ? 1 : widget.soDong,
          onTap: widget.onTap,
          autovalidateMode: widget.autovalidateMode,
          style: KieuChu.noiDung,
          cursorColor: MauSac.mauChinh,
          decoration: InputDecoration(
            hintText: widget.goiY,
            hintStyle: KieuChu.goiY,
            filled: true,
            fillColor: widget.voHieuHoa
                ? MauSac.mauPhanCach
                : MauSac.mauBeMat,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            prefixIcon: widget.iconTruoc != null
                ? Icon(widget.iconTruoc, size: 20, color: MauSac.mauChuMoTa)
                : null,
            suffixIcon: widget.laMatKhau
                ? IconButton(
                    icon: Icon(
                      _anMatKhau
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: 20,
                      color: MauSac.mauChuMoTa,
                    ),
                    onPressed: () => setState(() => _anMatKhau = !_anMatKhau),
                  )
                : widget.iconSau,
            border: _taoVien(MauSac.mauVien),
            enabledBorder: _taoVien(MauSac.mauVien),
            focusedBorder: _taoVien(MauSac.mauChinh, doRong: 1.5),
            errorBorder: _taoVien(MauSac.mauLoi),
            focusedErrorBorder: _taoVien(MauSac.mauLoi, doRong: 1.5),
            disabledBorder: _taoVien(MauSac.mauPhanCach),
            errorStyle: KieuChu.moTa.copyWith(color: MauSac.mauLoi),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _taoVien(Color mau, {double doRong = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: mau, width: doRong),
    );
  }
}
