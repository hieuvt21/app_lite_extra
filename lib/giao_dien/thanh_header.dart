import 'package:app_lite/quy_tac/giao_dien/nut_bam.dart';
import 'package:flutter/material.dart';

class ThanhHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPosButtonPressed;

  const ThanhHeader({
    super.key,
    required this.title,
    required this.onPosButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      // YÊU CẦU 1: Xóa đường viền Border bên dưới để tạo khối liền mạch mượt mà
      decoration: BoxDecoration(color: theme.colorScheme.surface),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 12),

          // Thanh dọc phân cách tinh tế
          Container(width: 1, height: 20, color: const Color(0xFFE2E8F0)),
          const SizedBox(width: 16),

          NutBam(
            nhan: 'POS',
            onPressed: onPosButtonPressed,
            kieu: KieuNutBam.chinh,
            kichThuoc: KichThuocNut.nho,
            icon: Icons.wallet_giftcard_rounded,
          ),
        ],
      ),
    );
  }
}
