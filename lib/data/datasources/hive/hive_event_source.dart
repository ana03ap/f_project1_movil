import 'package:f_project_1/data/models/event_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';

import '../../../data/models/event_model.dart';

class HiveEventSource {
  final String boxName = 'eventsBox';

  Future<HiveEventSource> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EventHiveModelAdapter());
    await Hive.openBox<EventHiveModel>(boxName);
    logInfo("✅ Hive box opened: $boxName");
    return this;
  }

  Future<List<EventModel>> loadEvents() async {
    final box = Hive.box<EventHiveModel>(boxName);
    return box.values.map((e) => EventModel.fromHive(e)).toList();
  }

  Future<void> saveEvents(List<EventModel> events) async {
    final box = Hive.box<EventHiveModel>(boxName);
    await box.clear();
    for (int i = 0; i < events.length; i++) {
      await box.put(i, events[i].toHiveModel());
    }
    logInfo("✅ ${events.length} events saved to Hive");
  }

  bool hasCachedEvents() {
    final box = Hive.box<EventHiveModel>(boxName);
    return box.isNotEmpty;
  }
}
