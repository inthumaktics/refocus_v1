import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refocus_v1/pages/app_state.dart';
import 'package:refocus_v1/pages/selectapp.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  // Local state to track permissions (backed by AppState)
  bool _usageGranted = AppState.usageAccessGranted;
  bool _notificationGranted = AppState.notificationAccessGranted;

  void _toggleUsage() {
    setState(() {
      _usageGranted = !_usageGranted;
      AppState.usageAccessGranted = _usageGranted;
    });

    if (_usageGranted) {
      // TODO: Implement actual Android native Usage Access Permission request here using standard Flutter packages (e.g. android_intent_plus or custom platform channel).
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usage Access Permission Simulated!'),
          duration: Duration(milliseconds: 800),
          backgroundColor: Color(0xFF1E50A3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _toggleNotification() {
    setState(() {
      _notificationGranted = !_notificationGranted;
      AppState.notificationAccessGranted = _notificationGranted;
    });

    if (_notificationGranted) {
      // TODO: Implement actual Android native Notification Permission request here using permission_handler or local_notifications.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification Permission Simulated!'),
          duration: Duration(milliseconds: 800),
          backgroundColor: Color(0xFF1E50A3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF192557);
    const secondaryColor = Color(0xFF1E50A3);

    final isBothGranted = _usageGranted && _notificationGranted;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08, // Proportional padding
                    vertical: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      
                      // Mascot Illustration
                      Image.asset(
                        'assets/images/permission.png',
                        width: 144,
                        height: 133,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.security_rounded,
                            size: 100,
                            color: secondaryColor,
                          );
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Heading
                      const Text(
                        'Almost there!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Subtitle
                      const Text(
                        'Untuk mempersonalisasi pengalaman Anda, kami membutuhkan beberapa izin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Permission Card 1: Usage Access
                      _buildPermissionCard(
                        title: 'Usage Access',
                        description: 'Allow to track app usage and screen time.',
                        iconPath: 'assets/icons/Stopwatch.png',
                        isGranted: _usageGranted,
                        onTap: _toggleUsage,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Permission Card 2: Notification
                      _buildPermissionCard(
                        title: 'Notification',
                        description: 'Allow to remind you about limits and challenges.',
                        iconPath: 'assets/icons/Notification.png',
                        isGranted: _notificationGranted,
                        onTap: _toggleNotification,
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: isBothGranted
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SelectAppPage(),
                                    ),
                                  );
                                }
                              : null, // Disabled if not both granted
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            disabledBackgroundColor: const Color(0xFFC3C6D3),
                            elevation: isBothGranted ? 4 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: isBothGranted ? Colors.white : const Color(0xFF737783),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Footer Text
                      const Text(
                        'You can change this later',
                        style: TextStyle(
                          color: Color(0xFF434752),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionCard({
    required String title,
    required String description,
    required String iconPath,
    required bool isGranted,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color(0x7F737783),
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 4,
              offset: Offset(5, 5),
              spreadRadius: 0,
            )
          ],
        ),
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              width: 75,
              height: 75,
              decoration: ShapeDecoration(
                color: const Color(0xFFAFC6FF).withAlpha(128),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    color: Color(0xFF1E50A3),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 42,
                  height: 42,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported_outlined,
                    color: Color(0xFF1E50A3),
                    size: 30,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF1E50A3),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Custom circular Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isGranted ? const Color(0xFF1E50A3) : Colors.white,
                border: Border.all(
                  width: 2,
                  color: const Color(0xFF1E50A3),
                ),
              ),
              child: isGranted
                  ? Center(
                      child: SvgPicture.asset(
                        'assets/icons/checkcircle.svg',
                        width: 14,
                        height: 14,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}