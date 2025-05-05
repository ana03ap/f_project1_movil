import 'package:f_project_1/data/models/event_hive_model.dart';
import 'package:f_project_1/data/models/event_model.dart';
import 'package:f_project_1/domain/datasources/i_event_local_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventLocalDataSource implements IEventLocalDataSource {
  static const _boxName = 'eventsBox';
  static const _versionKey = 'events_version';

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EventHiveModelAdapter());
    }
    await Hive.openBox<EventHiveModel>(_boxName);
    logInfo("Hive box opened: $_boxName");
  }

  @override
  Future<List<EventModel>> getSavedEvents() async {
    final box = Hive.box<EventHiveModel>(_boxName);
    return box.values.map((e) => EventModel.fromHive(e)).toList();
  }

  @override
  Future<void> saveEvents(List<EventModel> events) async {
    
    final box = Hive.box<EventHiveModel>(_boxName);
    await box.clear();
    for (int i = 0; i < events.length; i++) {
      await box.put(i, events[i].toHiveModel());
    }
    logInfo("✅ ${events.length} events saved to Hive");
  }

  @override
  Future<int> getLocalVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_versionKey) ?? 0;
  }

  @override
  Future<void> setLocalVersion(int version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_versionKey, version);
  }

  @override
  bool hasCachedEvents() {
    final box = Hive.box<EventHiveModel>(_boxName);
    return box.isNotEmpty;
  }
}
