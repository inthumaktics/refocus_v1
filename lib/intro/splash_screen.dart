import 'dart:async';
import 'package:flutter/material.dart';
import 'package:refocus_v1/intro/intro_1.dart';

// TODO: Move these styling constants to a shared design system / theme file in the future.
class _IntroStyles {
  static const Color backgroundColor = Color(0xFFD8EBFA);
  static const Color textColor = Color(0xFF192557);

  static const TextStyle headingTextStyle = TextStyle(
    color: textColor,
    fontSize: 25,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    height: 1.40,
  );

  // TODO: Move these asset paths to an assets constants class in the future.
  static const String logoAssetPath = 'assets/images/logo.png';
  static const String illustrationAssetPath = 'assets/images/splashscreen.png';
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a 3-second timer and navigate to the next page
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Intro1Page(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Restricting the content to a maximum mobile-friendly width to preserve
    // the layout proportion on tablets and web screens.
    return Scaffold(
      backgroundColor: _IntroStyles.backgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenHeight = constraints.maxHeight;
                final screenWidth = constraints.maxWidth;

                // Total height of elements in Figma design:
                // Logo (57) + Heading (87) + Illustration (235) = 379
                // Minimum spacing: Top (40) + Gap 1 (20) + Gap 2 (20) + Bottom (40) = 120
                // Total minimum height required before scrolling is 499.
                const double minRequiredHeight = 499.0;

                if (screenHeight >= minRequiredHeight) {
                  // Standard layout: Fits within the screen height using proportional spacing (Spacer).
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.109, // 48 / 440 = 10.9% design padding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 242), // Proportional top spacing (242 / 956)
                        
                        // Logo Image
                        SizedBox(
                          width: screenWidth * 0.595, // 262 / 440 = 59.5%
                          child: AspectRatio(
                            aspectRatio: 262 / 57,
                            child: Image.asset(
                              _IntroStyles.logoAssetPath,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        
                        const Spacer(flex: 30), // Proportional gap between Logo and Text (30 / 956)
                        
                        // Heading Text
                        const Text(
                          'Reclaim Your Focus,\nLive Better',
                          textAlign: TextAlign.center,
                          style: _IntroStyles.headingTextStyle,
                        ),
                        
                        const Spacer(flex: 19), // Proportional gap between Text and Illustration (19 / 956)
                        
                        // Illustration Image
                        SizedBox(
                          width: screenWidth * 0.570, // 251 / 440 = 57.0%
                          child: AspectRatio(
                            aspectRatio: 251 / 235,
                            child: Image.asset(
                              _IntroStyles.illustrationAssetPath,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        
                        const Spacer(flex: 286), // Proportional bottom spacing (286 / 956)
                      ],
                    ),
                  );
                } else {
                  // Fallback layout: The screen is too short (e.g. landscape or small screen),
                  // so we make it scrollable to prevent overflow.
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.109,
                        vertical: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 32),
                          
                          // Logo Image
                          SizedBox(
                            width: screenWidth * 0.595,
                            child: AspectRatio(
                              aspectRatio: 262 / 57,
                              child: Image.asset(
                                _IntroStyles.logoAssetPath,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Heading Text
                          const Text(
                            'Reclaim Your Focus,\nLive Better',
                            textAlign: TextAlign.center,
                            style: _IntroStyles.headingTextStyle,
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Illustration Image
                          SizedBox(
                            width: screenWidth * 0.570,
                            child: AspectRatio(
                              aspectRatio: 251 / 235,
                              child: Image.asset(
                                _IntroStyles.illustrationAssetPath,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 32),
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