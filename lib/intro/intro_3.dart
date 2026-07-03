import 'package:flutter/material.dart';
import 'package:refocus_v1/pages/auth/login.dart';

// TODO: Move these styling constants to a shared design system / theme file in the future.
class _Intro3Styles {
  static const Color backgroundColor = Colors.white;
  static const Color primaryColor = Color(0xFF192557);
  static const Color secondaryTextColor = Color(0xFF1E50A3);

  static const TextStyle titleTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 32,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    height: 1.25,
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    color: secondaryTextColor,
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 0.83,
    letterSpacing: 0.10,
  );

  // TODO: Move these asset paths to an assets constants class in the future.
  static const String illustrationAssetPath = 'assets/images/intro3.png';
}

class Intro3Page extends StatelessWidget {
  const Intro3Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Restricting the content to a maximum mobile-friendly width to preserve
    // the layout proportion on tablets and web screens.
    return Scaffold(
      backgroundColor: _Intro3Styles.backgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenHeight = constraints.maxHeight;
                final screenWidth = constraints.maxWidth;

                // Total height of elements in Figma design:
                // Title (87) + Illustration (283) + Description (~60) + Indicators (70) + Button (64) = 564
                // Minimum spacing: Top (32) + Gaps (16 * 4) + Bottom (32) = 128
                // Total minimum height required before scrolling is 692.
                const double minRequiredHeight = 692.0;

                if (screenHeight >= minRequiredHeight) {
                  // Standard layout: Fits within the screen height using proportional spacing (Spacer).
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 156), // Proportional top spacing (156 / 956)

                      // Title Text
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.184, // 81 / 440 = 18.4% design padding
                        ),
                        child: const Text(
                          'Track Progress,\nSee Results',
                          textAlign: TextAlign.center,
                          style: _Intro3Styles.titleTextStyle,
                        ),
                      ),

                      const Spacer(flex: 104), // Proportional gap between Title and Illustration (104 / 956)

                      // Illustration Image
                      SizedBox(
                        width: screenWidth * 0.630, // 277 / 440 = 63.0%
                        child: AspectRatio(
                          aspectRatio: 277 / 283,
                          child: Image.asset(
                            _Intro3Styles.illustrationAssetPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const Spacer(flex: 14), // Proportional gap between Illustration and Description (14 / 956)

                      // Description Text
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.159, // 70 / 440 = 15.9% design padding
                        ),
                        child: const Text(
                          'Pantau progresmu, bangun konsistensi, dan jadilah versi terbaikmu.',
                          textAlign: TextAlign.center,
                          style: _Intro3Styles.descriptionTextStyle,
                        ),
                      ),

                      const Spacer(flex: 43), // Proportional gap between Description and Indicators (43 / 956)

                      // Custom Page Indicators
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _PageIndicator(isActive: false),
                            _PageIndicator(isActive: false),
                            _PageIndicator(isActive: true),
                          ],
                        ),
                      ),

                      const Spacer(flex: 9), // Proportional gap between Indicators and Button (9 / 956)

                      // Next Button
                      _NextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                      ),

                      const Spacer(flex: 66), // Proportional bottom spacing (66 / 956)
                    ],
                  );
                } else {
                  // Fallback layout: The screen is too short (e.g. landscape or small screen),
                  // so we make it scrollable to prevent overflow.
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.075,
                        vertical: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),

                          // Title Text
                          const Text(
                            'Track Progress,\nSee Results',
                            textAlign: TextAlign.center,
                            style: _Intro3Styles.titleTextStyle,
                          ),

                          const SizedBox(height: 24),

                          // Illustration Image
                          SizedBox(
                            width: screenWidth * 0.630,
                            child: AspectRatio(
                              aspectRatio: 277 / 283,
                              child: Image.asset(
                                _Intro3Styles.illustrationAssetPath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Description Text
                          const Text(
                            'Pantau progresmu, bangun konsistensi, dan jadilah versi terbaikmu.',
                            textAlign: TextAlign.center,
                            style: _Intro3Styles.descriptionTextStyle,
                          ),

                          const SizedBox(height: 24),

                          // Custom Page Indicators
                          const SizedBox(
                            width: 70,
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _PageIndicator(isActive: false),
                                _PageIndicator(isActive: false),
                                _PageIndicator(isActive: true),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Next Button
                          _NextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.11,
      height: 70,
      decoration: BoxDecoration(
        color: isActive
            ? _Intro3Styles.primaryColor
            : _Intro3Styles.primaryColor.withAlpha(76),
        borderRadius: BorderRadius.circular(11),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _NextButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _Intro3Styles.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Next',
          textAlign: TextAlign.center,
          style: _Intro3Styles.buttonTextStyle,
        ),
      ),
    );
  }
}