import 'package:flutter/material.dart';

class AppInfo {
  final String id;
  final String name;
  final Color primaryColor;
  final String firstLetter;

  const AppInfo({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.firstLetter,
  });
}

class AppState {
  static const List<AppInfo> availableApps = [
    AppInfo(id: 'instagram', name: 'Instagram', primaryColor: Color(0xFFE1306C), firstLetter: 'I'),
    AppInfo(id: 'tiktok', name: 'TikTok', primaryColor: Color(0xFF000000), firstLetter: 'T'),
    AppInfo(id: 'youtube', name: 'YouTube', primaryColor: Color(0xFFFF0000), firstLetter: 'Y'),
    AppInfo(id: 'facebook', name: 'Facebook', primaryColor: Color(0xFF1877F2), firstLetter: 'F'),
    AppInfo(id: 'whatsapp', name: 'WhatsApp', primaryColor: Color(0xFF25D366), firstLetter: 'W'),
    AppInfo(id: 'shopee', name: 'Shopee', primaryColor: Color(0xFFEE4D2D), firstLetter: 'S'),
  ];

  // State fields
  static Set<String> selectedAppIds = {};
  static Map<String, int> appLimitsMinutes = {};
  static bool usageAccessGranted = false;
  static bool notificationAccessGranted = false;

  // Reset helper
  static void reset() {
    selectedAppIds.clear();
    appLimitsMinutes.clear();
    usageAccessGranted = false;
    notificationAccessGranted = false;
  }
}

/// Helper widget to draw premium custom branded icons matching Figma layouts.
class BrandedAppIcon extends StatelessWidget {
  final String appId;
  final double size;

  const BrandedAppIcon({
    super.key,
    required this.appId,
    this.size = 45.0,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Replace these custom drawing widgets with actual branded SVG/PNG assets inside assets/images/ when they are exported from Figma.
    switch (appId) {
      case 'instagram':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFFCAF45),
                Color(0xFFF77737),
                Color(0xFFE1306C),
                Color(0xFFC13584),
                Color(0xFF833AB4),
              ],
            ),
          ),
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
            size: size * 0.55,
          ),
        );
      case 'tiktok':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Cyan shadow/layer offset
                Transform.translate(
                  offset: const Offset(-1.5, -1.5),
                  child: Text(
                    'd',
                    style: TextStyle(
                      color: const Color(0xFF00F2FE),
                      fontSize: size * 0.65,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ),
                // Red shadow/layer offset
                Transform.translate(
                  offset: const Offset(1.5, 1.5),
                  child: Text(
                    'd',
                    style: TextStyle(
                      color: const Color(0xFFFE2C55),
                      fontSize: size * 0.65,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ),
                // White foreground layer
                Text(
                  'd',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.65,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ],
            ),
          ),
        );
      case 'youtube':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFFFF0000),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: size * 0.7,
          ),
        );
      case 'facebook':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF1877F2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'f',
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.85,
                fontWeight: FontWeight.w900,
                fontFamily: 'serif',
                height: 1.1,
              ),
            ),
          ),
        );
      case 'whatsapp':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFF25D366),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.phone_in_talk_rounded,
            color: Colors.white,
            size: size * 0.55,
          ),
        );
      case 'shopee':
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFFEE4D2D),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: size * 0.5,
                ),
                Text(
                  'Shopee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.android,
            color: Colors.white,
            size: size * 0.6,
          ),
        );
    }
  }
}
