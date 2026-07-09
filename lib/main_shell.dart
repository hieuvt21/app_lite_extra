import 'package:flutter/material.dart';
import 'giao_dien/thanh_dieu_huong.dart';
import 'giao_dien/thanh_header.dart';

import 'pages/tong_quan/tong_quan_page.dart';
import 'pages/ban_hang/ban_hang_page.dart';
import 'pages/san_pham/san_pham_page.dart';
import 'pages/dich_vu/dich_vu_page.dart';
import 'pages/khach_hang/khach_hang_page.dart';
import 'pages/nhan_vien/nhan_vien_page.dart';
import 'pages/cai_dat/cai_dat_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  bool isSidebarExpanded = false;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Tổng quan', 'icon': Icons.space_dashboard_rounded},
    {'title': 'Bán hàng', 'icon': Icons.shopping_bag_rounded},
    {'title': 'Sản phẩm', 'icon': Icons.inventory_2_rounded},
    {'title': 'Dịch vụ', 'icon': Icons.medical_services_rounded},
    {'title': 'Khách hàng', 'icon': Icons.people_rounded},
    {'title': 'Nhân viên', 'icon': Icons.person_rounded},
    {'title': 'Cài đặt', 'icon': Icons.settings_suggest_rounded},
  ];

  Widget _buildPageContent() {
    switch (selectedIndex) {
      case 0:
        return const TongQuanPage();
      case 1:
        return const BanHangPage();
      case 2:
        return const SanPhamPage();
      case 3:
        return const DichVuPage();
      case 4:
        return const KhachHangPage();
      case 5:
        return const NhanVienPage();
      case 6:
        return const CaiDatPage();
      default:
        return const TongQuanPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar phẳng không viền phân cách
          ThanhDieuHuong(
            selectedIndex: selectedIndex,
            isSidebarExpanded: isSidebarExpanded,
            menuItems: menuItems,
            onHoverChanged: (hovered) {
              setState(() => isSidebarExpanded = hovered);
            },
            onIndexChanged: (index) {
              setState(() => selectedIndex = index);
            },
          ),

          // Vùng nội dung bên phải liền khối
          Expanded(
            child: Column(
              children: [
                // Header phẳng không viền phân cách dưới
                ThanhHeader(
                  title: menuItems[selectedIndex]['title'],
                  onPosButtonPressed: () {
                    setState(() => selectedIndex = 1);
                  },
                ),

                // Content hiển thị các page con
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8FAFC),
                    child: _buildPageContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
