import 'package:flutter/material.dart';
import 'package:refocus_v1/intro/intro_2.dart';

// TODO: Move these styling constants to a shared design system / theme file in the future.
class _Intro1Styles {
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
  static const String illustrationAssetPath = 'assets/images/intro1.png';
}

class Intro1Page extends StatelessWidget {
  const Intro1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Restricting the content to a maximum mobile-friendly width to preserve
    // the layout proportion on tablets and web screens.
    return Scaffold(
      backgroundColor: _Intro1Styles.backgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenHeight = constraints.maxHeight;
                final screenWidth = constraints.maxWidth;

                // Total height of elements in Figma design:
                // Title (87) + Illustration (294) + Description (~60) + Indicators (70) + Button (64) = 575
                // Minimum spacing: Top (32) + Gaps (16 * 4) + Bottom (32) = 128
                // Total minimum height required before scrolling is 703.
                const double minRequiredHeight = 703.0;

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
                          'Stay Focused, \nAchieve More',
                          textAlign: TextAlign.center,
                          style: _Intro1Styles.titleTextStyle,
                        ),
                      ),

                      const Spacer(flex: 93), // Proportional gap between Title and Illustration (93 / 956)

                      // Illustration Image
                      SizedBox(
                        width: screenWidth * 0.593, // 261 / 440 = 59.3%
                        child: AspectRatio(
                          aspectRatio: 261 / 294,
                          child: Image.asset(
                            _Intro1Styles.illustrationAssetPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const Spacer(flex: 15), // Proportional gap between Illustration and Description (15 / 956)

                      // Description Text
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.075, // 33 / 440 = 7.5% design padding
                        ),
                        child: const Text(
                          'ReFocus membantu Anda melacak waktu layar, mengurangi gangguan, dan membangun kebiasaan yang lebih baik',
                          textAlign: TextAlign.center,
                          style: _Intro1Styles.descriptionTextStyle,
                        ),
                      ),

                      const Spacer(flex: 62), // Proportional gap between Description and Indicators (62 / 956)

                      // Custom Page Indicators
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _PageIndicator(isActive: true),
                            _PageIndicator(isActive: false),
                            _PageIndicator(isActive: false),
                          ],
                        ),
                      ),

                      const Spacer(flex: 11), // Proportional gap between Indicators and Button (11 / 956)

                      // Next Button
                      _NextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Intro2Page(),
                            ),
                          );
                        },
                      ),

                      const Spacer(flex: 64), // Proportional bottom spacing (64 / 956)
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
                            'Stay Focused, \nAchieve More',
                            textAlign: TextAlign.center,
                            style: _Intro1Styles.titleTextStyle,
                          ),

                          const SizedBox(height: 24),

                          // Illustration Image
                          SizedBox(
                            width: screenWidth * 0.593,
                            child: AspectRatio(
                              aspectRatio: 261 / 294,
                              child: Image.asset(
                                _Intro1Styles.illustrationAssetPath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Description Text
                          const Text(
                            'ReFocus membantu Anda melacak waktu layar, mengurangi gangguan, dan membangun kebiasaan yang lebih baik',
                            textAlign: TextAlign.center,
                            style: _Intro1Styles.descriptionTextStyle,
                          ),

                          const SizedBox(height: 24),

                          // Custom Page Indicators
                          const SizedBox(
                            width: 70,
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _PageIndicator(isActive: true),
                                _PageIndicator(isActive: false),
                                _PageIndicator(isActive: false),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Next Button
                          _NextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Intro2Page(),
                                ),
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
            ? _Intro1Styles.primaryColor
            : _Intro1Styles.primaryColor.withAlpha(76),
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
          backgroundColor: _Intro1Styles.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Next',
          textAlign: TextAlign.center,
          style: _Intro1Styles.buttonTextStyle,
        ),
      ),
    );
  }
}