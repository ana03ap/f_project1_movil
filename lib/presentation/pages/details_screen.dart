import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../widgets/bottom_nav_bar.dart';
import '../controllers/bottom_nav_controller.dart';

class EventDetailsScreen extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find();
  final EventController eventController = Get.find<EventController>();
  EventDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const purple = AppColors.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PuntoG'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
      body: Obx(() {
        final eventDetails = eventController.selectedEvent.value;

        if (eventDetails == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.asset(
                      eventDetails.path,
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: AppColors.grey,
                          child: const Center(child: Text('Image not found')),
                        );
                      },
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                    Container(
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        eventDetails.date,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                eventDetails.title,
                style: AppStyles.title.copyWith(
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, color: purple),
                  const SizedBox(width: 5),
                  Text(
                    eventDetails.location,
                    style: AppStyles.normal.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.people, color: purple),
                  const SizedBox(width: 5),
                  Text(
                    'Maximum number of participants: ${eventDetails.participants}',
                    style: AppStyles.normal.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Details',
                style: AppStyles.subtitle.copyWith(
                  color: theme.textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                eventDetails.details,
                style: AppStyles.normal.copyWith(
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Available spots: ${eventDetails.availableSpots.value}',
                      style: AppStyles.bold.copyWith(
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
              Obx(() {
                bool noSpotsAvailable =
                    eventDetails.availableSpots.value == 0;

                return Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: noSpotsAvailable
                            ? AppColors.grey
                            : (eventDetails.isJoined.value
                                ? AppColors.error
                                : purple),
                      ),
                      child: IconButton(
                        icon: Icon(
                          eventDetails.isJoined.value
                              ? Icons.remove
                              : Icons.add,
                          color: AppColors.white,
                        ),
                        onPressed: noSpotsAvailable
                            ? null
                            : () => eventController.toggleJoinEvent(eventDetails),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      eventDetails.isJoined.value ? 'Unjoin' : 'Join!',
                      style: AppStyles.subtitle.copyWith(
                        color: theme.textTheme.titleMedium?.color,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
