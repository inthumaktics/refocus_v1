import 'package:flutter/material.dart';
import 'package:refocus_v1/pages/home.dart';
import 'package:refocus_v1/pages/statistics.dart';
import 'package:refocus_v1/pages/challenges.dart';
import 'package:refocus_v1/pages/profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = const HomePage();
        break;
      case 1:
        nextPage = const StatisticsPage();
        break;
      case 2:
        nextPage = const ChallengesPage();
        break;
      case 3:
        nextPage = const ProfilePage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => nextPage,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF1E50A3);
    const inactiveColor = Color(0xFF192557);
    const highlightColor = Color(0xA07DADFF);

    final List<Map<String, dynamic>> items = [
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.insert_chart_rounded, 'label': 'Statistics'},
      {'icon': Icons.sports_esports_rounded, 'label': 'Challenge'},
      {'icon': Icons.person_rounded, 'label': 'Profile'},
    ];

    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          final item = items[index];

          return Expanded(
            child: GestureDetector(
              onTap: () => _onItemTapped(context, index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular background highlight for selected tab
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? highlightColor.withAlpha(160) : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: isSelected ? activeColor : inactiveColor,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: inactiveColor,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}