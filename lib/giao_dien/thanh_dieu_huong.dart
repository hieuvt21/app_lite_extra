import 'package:flutter/material.dart';

class ThanhDieuHuong extends StatelessWidget {
  final int selectedIndex;
  final bool isSidebarExpanded;
  final ValueChanged<bool> onHoverChanged;
  final Function(int) onIndexChanged;
  final List<Map<String, dynamic>> menuItems;

  const ThanhDieuHuong({
    super.key,
    required this.selectedIndex,
    required this.isSidebarExpanded,
    required this.onHoverChanged,
    required this.onIndexChanged,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dynamicThemeColor = theme.colorScheme.primary;

    const double kExpandedWidth = 240.0;
    const double kCollapsedWidth = 75.0;

    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: isSidebarExpanded ? kExpandedWidth : kCollapsedWidth,
        // YÊU CẦU 1: Xóa đường viền Border để tạo khối liền mạch
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            // LOGO & TIÊU ĐỀ ỨNG DỤNG
            SizedBox(
              height: 65,
              child: OverflowBox(
                maxWidth: kExpandedWidth,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    children: [
                      Icon(
                        Icons.storefront_rounded,
                        color: dynamicThemeColor,
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      AnimatedOpacity(
                        opacity: isSidebarExpanded ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 150),
                        child: Text(
                          'OHIDO POS',
                          style: TextStyle(
                            color: const Color(0xFF1E293B),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // DANH SÁCH MENU CHÍNH
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final bool isSelected = selectedIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: InkWell(
                      onTap: () => onIndexChanged(index),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? dynamicThemeColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: OverflowBox(
                          minWidth: 0,
                          maxWidth: kExpandedWidth,
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: kExpandedWidth,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: kCollapsedWidth - 20,
                                  child: Icon(
                                    item['icon'],
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF64748B),
                                    size: 22,
                                  ),
                                ),
                                if (isSidebarExpanded)
                                  Expanded(
                                    child: AnimatedOpacity(
                                      opacity: isSidebarExpanded ? 1.0 : 0.0,
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      child: Text(
                                        item['title'],
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF334155),
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
