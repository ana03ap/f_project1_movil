import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/constants/app_assets.dart';
import '../widgets/bottom_nav_bar.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TuBoleta'),
        centerTitle: true,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.asset(
                    AppAssets.eventImage,
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey,
                        child: const Center(child: Text('Image not found')),
                      );
                    },
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 180,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      '04 ABRIL 2025\nViernes, 10:00 AM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Voices of the Future', style: AppStyles.title),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary),
                SizedBox(width: 5),
                Text('Movistar Arena / Bogotá, Colombia', style: AppStyles.normal),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.people, color: AppColors.primary),
                SizedBox(width: 5),
                Text('Maximum number of participants: 20', style: AppStyles.normal),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Details', style: AppStyles.subtitle),
            const SizedBox(height: 8),
            const Text(
              "It's a political event focused on empowering young leaders and future changemakers. "
              "Join key debates and dynamic discussions on today's most pressing issues.",
              style: AppStyles.normal,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.buttonBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Available spots: 10', style: AppStyles.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Join!', style: AppStyles.subtitle),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
