import 'package:flutter/material.dart';
import 'package:refocus_v1/pages/app_state.dart';
import 'package:refocus_v1/pages/setdailylimit.dart';

class SelectAppPage extends StatefulWidget {
  const SelectAppPage({super.key});

  @override
  State<SelectAppPage> createState() => _SelectAppPageState();
}

class _SelectAppPageState extends State<SelectAppPage> {
  // Local state reference to selected app IDs (initialized from AppState)
  final Set<String> _selectedAppIds = Set.from(AppState.selectedAppIds);

  void _toggleApp(String appId) {
    setState(() {
      if (_selectedAppIds.contains(appId)) {
        _selectedAppIds.remove(appId);
      } else {
        _selectedAppIds.add(appId);
      }
      AppState.selectedAppIds = _selectedAppIds;
    });
  }

  void _handleContinue() {
    if (_selectedAppIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one application to continue.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    // Seed default limits (30 minutes) for newly selected apps if not already configured
    for (var appId in _selectedAppIds) {
      AppState.appLimitsMinutes.putIfAbsent(appId, () => 30);
    }
    
    // Clean up limits for apps that were unselected
    AppState.appLimitsMinutes.removeWhere((key, value) => !_selectedAppIds.contains(key));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetDailyLimitPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF192557);
    const secondaryColor = Color(0xFF1E50A3);

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
                    horizontal: screenWidth * 0.08,
                    vertical: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),

                      // Mascot Illustration
                      Image.asset(
                        'assets/images/selectapp.png',
                        width: 88,
                        height: 105,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.apps_rounded,
                          size: 80,
                          color: secondaryColor,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Heading
                      const Text(
                        'Select Apps',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        'Pilih sosial media atau aplikasi yang anda ingin kelola',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // App List
                      Column(
                        children: AppState.availableApps.map((app) {
                          final isSelected = _selectedAppIds.contains(app.id);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: GestureDetector(
                              onTap: () => _toggleApp(app.id),
                              child: Container(
                                width: double.infinity,
                                height: 76,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.5,
                                    color: const Color(0xFF003983),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: secondaryColor.withAlpha(40),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          )
                                        ]
                                      : null,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    // Custom Branded App Icon
                                    BrandedAppIcon(
                                      appId: app.id,
                                      size: 45,
                                    ),

                                    const SizedBox(width: 16),

                                    // App Name
                                    Text(
                                      app.name,
                                      style: const TextStyle(
                                        color: secondaryColor,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    const Spacer(),

                                    // Custom Checkbox
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 150),
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: isSelected ? secondaryColor : Colors.white,
                                        border: Border.all(
                                          width: 2,
                                          color: const Color(0xFF003983),
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 18,
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 32),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: _handleContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
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
}