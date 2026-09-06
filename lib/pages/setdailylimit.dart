import 'package:flutter/material.dart';
import 'package:refocus_v1/pages/app_state.dart';
import 'package:refocus_v1/pages/home.dart';

class SetDailyLimitPage extends StatefulWidget {
  const SetDailyLimitPage({super.key});

  @override
  State<SetDailyLimitPage> createState() => _SetDailyLimitPageState();
}

class _SetDailyLimitPageState extends State<SetDailyLimitPage> {
  // Local limits map initialized from AppState
  final Map<String, int> _limits = Map.from(AppState.appLimitsMinutes);

  // Available limit options in minutes paired with their display labels
  final List<MapEntry<int, String>> _limitOptions = const [
    MapEntry(15, '15 min'),
    MapEntry(30, '30 min'),
    MapEntry(45, '45 min'),
    MapEntry(50, '50 min'),
    MapEntry(60, '1 hour'),
    MapEntry(90, '1 h 30 min'),
    MapEntry(120, '2 hours'),
    MapEntry(180, '3 hours'),
    MapEntry(240, '4 hours'),
  ];

  void _updateLimit(String appId, int? newLimit) {
    if (newLimit != null) {
      setState(() {
        _limits[appId] = newLimit;
        AppState.appLimitsMinutes[appId] = newLimit;
      });
    }
  }

  void _handleSaveAndStart() {
    // Save to AppState
    AppState.appLimitsMinutes = _limits;

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Onboarding setup completed successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Navigate to Home Dashboard and clear all previous history
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF192557);
    const secondaryColor = Color(0xFF1E50A3);

    // Retrieve full information for selected apps
    final selectedApps = AppState.availableApps
        .where((app) => AppState.selectedAppIds.contains(app.id))
        .toList();

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
                        'assets/images/setdailylimit.png',
                        width: 114,
                        height: 121,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.hourglass_empty_rounded,
                          size: 80,
                          color: secondaryColor,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Heading
                      const Text(
                        'Set Daily Limit',
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
                        'Atur batas waktu harian Anda untuk setiap aplikasi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // List of selected apps with dropdown limits
                      if (selectedApps.isEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: const Text(
                            'No apps selected. Go back to select apps.',
                            style: TextStyle(
                              color: Color(0xFF6D6D70),
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        )
                      else
                        Column(
                          children: selectedApps.map((app) {
                            final currentLimit = _limits[app.id] ?? 30;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
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
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x1F000000),
                                      blurRadius: 4,
                                      offset: Offset(5, 5),
                                      spreadRadius: 0,
                                    )
                                  ],
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

                                    // Limit Selector Dropdown
                                    Container(
                                      width: 136,
                                      height: 39,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: secondaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: currentLimit,
                                          dropdownColor: Colors.white,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: secondaryColor,
                                            size: 20,
                                          ),
                                          style: const TextStyle(
                                            color: secondaryColor,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          onChanged: (val) => _updateLimit(app.id, val),
                                          items: _limitOptions.map((opt) {
                                            // Handle min/hour parts for Dropdown MenuItem UI
                                            final isHour = opt.key >= 60;
                                            final displayValue = opt.key == 60 
                                                ? '1' 
                                                : opt.key == 90 
                                                    ? '1 h 30' 
                                                    : opt.key == 120 
                                                        ? '2' 
                                                        : opt.key == 180 
                                                            ? '3' 
                                                            : opt.key == 240 
                                                                ? '4' 
                                                                : '${opt.key}';
                                            final displayUnit = isHour ? ' hour' : ' min';
                                            
                                            // Format text rich structure matches designs
                                            return DropdownMenuItem<int>(
                                              value: opt.key,
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: displayValue,
                                                      style: const TextStyle(
                                                        color: secondaryColor,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: displayUnit,
                                                      style: const TextStyle(
                                                        color: secondaryColor,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      const SizedBox(height: 32),

                      // Save & Start Button
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: selectedApps.isNotEmpty ? _handleSaveAndStart : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            disabledBackgroundColor: const Color(0xFFC3C6D3),
                            elevation: selectedApps.isNotEmpty ? 4 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Save & Start',
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