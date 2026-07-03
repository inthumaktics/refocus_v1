import 'package:flutter/material.dart';
import 'package:refocus_v1/intro/intro_3.dart';

// TODO: Move these styling constants to a shared design system / theme file in the future.
class _Intro2Styles {
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
  static const String illustrationAssetPath = 'assets/images/intro2.png';
}

class Intro2Page extends StatelessWidget {
  const Intro2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Restricting the content to a maximum mobile-friendly width to preserve
    // the layout proportion on tablets and web screens.
    return Scaffold(
      backgroundColor: _Intro2Styles.backgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenHeight = constraints.maxHeight;
                final screenWidth = constraints.maxWidth;

                // Total height of elements in Figma design:
                // Title (87) + Illustration (365) + Description (~60) + Indicators (70) + Button (64) = 646
                // Minimum spacing: Top (32) + Gaps (16 * 4) + Bottom (32) = 128
                // Total minimum height required before scrolling is 774.
                const double minRequiredHeight = 774.0;

                if (screenHeight >= minRequiredHeight) {
                  // Standard layout: Fits within the screen height using proportional spacing (Spacer).
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 159), // Proportional top spacing (159 / 956)

                      // Title Text
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.184, // 81 / 440 = 18.4% design padding
                        ),
                        child: const Text(
                          'Beat Distraction with Challenges',
                          textAlign: TextAlign.center,
                          style: _Intro2Styles.titleTextStyle,
                        ),
                      ),

                      const Spacer(flex: 20), // Proportional gap between Title and Illustration (20 / 956)

                      // Illustration Image
                      SizedBox(
                        width: screenWidth * 0.584, // 257 / 440 = 58.4%
                        child: AspectRatio(
                          aspectRatio: 257 / 365,
                          child: Image.asset(
                            _Intro2Styles.illustrationAssetPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const Spacer(flex: 15), // Proportional gap between Illustration and Description (15 / 956)

                      // Description Text
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.159, // 70 / 440 = 15.9% design padding
                        ),
                        child: const Text(
                          'Selesaikan tantangan seru dan edukatif, raih kembali fokusmu, dan dapatkan hadiahnya!',
                          textAlign: TextAlign.center,
                          style: _Intro2Styles.descriptionTextStyle,
                        ),
                      ),

                      const Spacer(flex: 41), // Proportional gap between Description and Indicators (41 / 956)

                      // Custom Page Indicators
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _PageIndicator(isActive: false),
                            _PageIndicator(isActive: true),
                            _PageIndicator(isActive: false),
                          ],
                        ),
                      ),

                      const Spacer(flex: 13), // Proportional gap between Indicators and Button (13 / 956)

                      // Next Button
                      _NextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Intro3Page(),
                            ),
                          );
                        },
                      ),

                      const Spacer(flex: 62), // Proportional bottom spacing (62 / 956)
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
                            'Beat Distraction with Challenges',
                            textAlign: TextAlign.center,
                            style: _Intro2Styles.titleTextStyle,
                          ),

                          const SizedBox(height: 24),

                          // Illustration Image
                          SizedBox(
                            width: screenWidth * 0.584,
                            child: AspectRatio(
                              aspectRatio: 257 / 365,
                              child: Image.asset(
                                _Intro2Styles.illustrationAssetPath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Description Text
                          const Text(
                            'Selesaikan tantangan seru dan edukatif, raih kembali fokusmu, dan dapatkan hadiahnya!',
                            textAlign: TextAlign.center,
                            style: _Intro2Styles.descriptionTextStyle,
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
                                _PageIndicator(isActive: true),
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
                                  builder: (context) => const Intro3Page(),
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
            ? _Intro2Styles.primaryColor
            : _Intro2Styles.primaryColor.withAlpha(76),
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
          backgroundColor: _Intro2Styles.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Next',
          textAlign: TextAlign.center,
          style: _Intro2Styles.buttonTextStyle,
        ),
      ),
    );
  }
}