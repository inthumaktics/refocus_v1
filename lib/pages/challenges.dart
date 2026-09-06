import 'package:flutter/material.dart';
import 'package:refocus_v1/widgets/bottomnav.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

enum ChallengeTab { all, daily, completed }

class _ChallengesPageState extends State<ChallengesPage> {
  ChallengeTab _selectedTab = ChallengeTab.daily;

  // Local dummy data representing challenges
  final List<Map<String, dynamic>> _challenges = [
    {
      'title': 'Memory Match',
      'description': 'Train your memory and attention.',
      'points': 10,
      'icon': Icons.extension_rounded,
      'isDaily': true,
      'isCompleted': true,
      'completionDate': 'Today, 09:30 AM',
    },
    {
      'title': 'Color Focus',
      'description': 'Test your concentration with color game.',
      'points': 10,
      'icon': Icons.palette_rounded,
      'isDaily': true,
      'isCompleted': false,
    },
    {
      'title': 'Math Sprint',
      'description': 'Solve problems in limited time.',
      'points': 10,
      'icon': Icons.calculate_rounded,
      'isDaily': true,
      'isCompleted': true,
      'completionDate': 'Yesterday, 04:15 PM',
    },
    {
      'title': 'Pattern Recall',
      'description': 'Remember the pattern shown.',
      'points': 10,
      'icon': Icons.grid_view_rounded,
      'isDaily': true,
      'isCompleted': false,
    },
    {
      'title': 'Sequence Memory',
      'description': 'Memorize and repeat the sequence of tiles.',
      'points': 10,
      'icon': Icons.repeat_rounded,
      'isDaily': false,
      'isCompleted': false,
    },
    {
      'title': 'Quick Math',
      'description': 'Solve simple math equations rapidly.',
      'points': 10,
      'icon': Icons.add_rounded,
      'isDaily': false,
      'isCompleted': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF192557);
    const secondaryColor = Color(0xFF1E50A3);

    return Scaffold(
      backgroundColor: primaryColor, // Shows solid primary color behind safe area / header
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Filter challenges dynamically based on selection
                List<Map<String, dynamic>> displayedChallenges;
                switch (_selectedTab) {
                  case ChallengeTab.all:
                    displayedChallenges = _challenges;
                    break;
                  case ChallengeTab.daily:
                    displayedChallenges = _challenges.where((c) => c['isDaily'] == true).toList();
                    break;
                  case ChallengeTab.completed:
                    displayedChallenges = _challenges.where((c) => c['isCompleted'] == true).toList();
                    break;
                }

                return Column(
                  children: [
                    // Header Section
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.00, 0.49),
                          end: Alignment(1.00, 0.51),
                          colors: [Color(0xFF192557), Color(0xFF263D6C)],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Challenge',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.25,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "let's start your challenges and get the points",
                                  style: TextStyle(
                                    color: Color(0xFFB9B9B9),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Points Display Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1, color: secondaryColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '240',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'pts',
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Mascot Illustration
                          Image.asset(
                            'assets/images/permission.png',
                            width: 95,
                            height: 110,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 95,
                              height: 110,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.emoji_nature_rounded,
                                size: 55,
                                color: Color(0xFFD8EBFA),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // White Body Section containing tabs and challenges
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                // Tab Switcher
                                Row(
                                  children: [
                                    _buildTabButton(
                                      label: 'All',
                                      tab: ChallengeTab.all,
                                      isSelected: _selectedTab == ChallengeTab.all,
                                    ),
                                    const SizedBox(width: 6),
                                    _buildTabButton(
                                      label: 'Daily',
                                      tab: ChallengeTab.daily,
                                      isSelected: _selectedTab == ChallengeTab.daily,
                                    ),
                                    const SizedBox(width: 6),
                                    _buildTabButton(
                                      label: 'Completed',
                                      tab: ChallengeTab.completed,
                                      isSelected: _selectedTab == ChallengeTab.completed,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // List of Cards
                                if (displayedChallenges.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.sports_esports_outlined,
                                          size: 64,
                                          color: secondaryColor.withAlpha(80),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No challenges completed yet.',
                                          style: TextStyle(
                                            color: primaryColor.withAlpha(120),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: displayedChallenges.length,
                                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                                    itemBuilder: (context, index) {
                                      final challenge = displayedChallenges[index];
                                      return _buildChallengeCard(
                                        title: challenge['title'],
                                        description: challenge['description'],
                                        points: challenge['points'],
                                        iconData: challenge['icon'],
                                        isCompleted: challenge['isCompleted'],
                                        completionDate: challenge['completionDate'],
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildTabButton({
    required String label,
    required ChallengeTab tab,
    required bool isSelected,
  }) {
    const primaryColor = Color(0xFF192557);
    const secondaryColor = Color(0xFF1E50A3);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = tab;
          });
        },
        child: Container(
          height: 50,
          decoration: ShapeDecoration(
            color: isSelected ? primaryColor : const Color(0xFFD8EBFA),
            shape: RoundedRectangleBorder(
              side: isSelected
                  ? BorderSide.none
                  : const BorderSide(width: 1, color: secondaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : secondaryColor,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String description,
    required int points,
    required IconData iconData,
    required bool isCompleted,
    String? completionDate,
  }) {
    const primaryColor = Color(0xFF192557);
    const secondaryColor = Color(0xFF1E50A3);

    return Container(
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        color: const Color(0xFFD8EBFA),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left details: Title, description, and points
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: const TextStyle(
                        color: secondaryColor,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      isCompleted ? '✓' : '+$points',
                      style: TextStyle(
                        color: isCompleted ? secondaryColor : const Color(0xFFFF6B00),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isCompleted ? 'Completed' : 'pts',
                      style: const TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right details: Illustration icon and Action Button / Completed Badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 71,
                height: 74,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: secondaryColor.withAlpha(40), width: 1),
                ),
                child: Icon(
                  iconData,
                  size: 36,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(height: 8),
              if (isCompleted)
                Container(
                  width: 122,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: secondaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+$points pts earned',
                        style: const TextStyle(
                          color: Color(0xFFFF6B00),
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (completionDate != null)
                        Text(
                          completionDate,
                          style: const TextStyle(
                            color: Color(0xFF6D6D70),
                            fontSize: 8,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                )
              else
                SizedBox(
                  width: 122,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Starting $title challenge!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}