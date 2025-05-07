import 'package:f_project_1/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastEventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  const PastEventCard({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        width: 370,
        height: 130,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.grey,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  event.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 6, top: 1),
                                  child: Text(
                                    "Event ended",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 60, 31, 110),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Obx(() => Text(
                                        event.averageRating.value
                                            .toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black87,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.asset(
                          event.path,
                          width: 120,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: 120,
                          height: 70,
                          color: Colors.black.withOpacity(0.4),
                        ),
                        Container(
                          width: 120,
                          height: 70,
                          alignment: Alignment.center,
                          child: Text(
                            event.date,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.add_comment, color: Colors.purple),
                    const SizedBox(width: 5),
                    Text(
                      "Give a feedback!",
                      style: TextStyle(
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
