import 'package:flutter/material.dart'; // Acceso a widgets y materiales de Flutter.
import 'package:flutter_test/flutter_test.dart'; // Herramientas para pruebas unitarias y de widgets.
import 'package:integration_test/integration_test.dart'; // Librería para pruebas de integración completas.
import 'package:path_provider/path_provider.dart'; // Obtener ruta del sistema para guardar datos locales (usado por Hive).
import 'package:get/get.dart'; // Librería GetX para inyección de dependencias, navegación y estado.
import 'package:shared_preferences/shared_preferences.dart'; // Acceso a almacenamiento clave-valor persistente.
import 'package:hive_flutter/hive_flutter.dart'; // Integración de Hive con Flutter (persistencia local ligera).

// Importaciones del proyecto
import 'package:f_project_1/main.dart'; // Importa el widget principal MyApp.
import 'package:f_project_1/data/models/event_hive_model.dart'; // Modelo para eventos almacenados con Hive.
import 'package:f_project_1/data/datasources/local/event_local_data_source.dart'; // Fuente local de eventos (Hive).
import 'package:f_project_1/data/repositories/event_repository_impl.dart'; // Implementación del repositorio.
import 'package:f_project_1/core/network/network_info.dart'; // Verificación de conexión de red.
import 'package:f_project_1/data/usescases_impl/check_event_version_usecase_impl.dart'; // Caso de uso para verificar versión de eventos.
import 'package:f_project_1/domain/usecases/filter_events.dart'; // Caso de uso para filtrar eventos.
import 'package:f_project_1/domain/usecases/join_event.dart'; // Caso de uso para unirse a un evento.
import 'package:f_project_1/domain/usecases/unjoin_event.dart'; // Caso de uso para desunirse de un evento.
import 'package:f_project_1/presentation/controllers/home_controller.dart'; // Controlador de la pantalla Home.
import 'package:f_project_1/presentation/controllers/event_controller.dart'; // Controlador de eventos.
import 'package:f_project_1/data/models/event_model.dart'; // Modelo de evento usado por la fuente remota.
import 'package:f_project_1/domain/datasources/i_event_remote_data_source.dart'; // Interface de la fuente remota de eventos.
import 'package:f_project_1/domain/datasources/i_version_remote_data_source.dart'; // Interface para verificar versión remota.

class FakeRemoteDataSource
    implements IEventRemoteDataSource, IVersionRemoteDataSource {
  //Clases Fake para testeo sin servidor ni conexión real
  final List<EventModel> _remoteEvents = [
    //Esta clase simula una fuente remota de eventos y versión, evitando hacer llamadas HTTP reales.
    EventModel(
      id: 1,
      title: 'Charla Sexualidad',
      location: 'Auditorio A',
      details: 'Una charla educativa sobre sexualidad responsable.',
      participants: 20,
      date: '2025-05-10',
      availableSpots: 20,
      path: 'assets/bodyliteracy01.jpg',
      type: 'Charla',
    ),
  ];

  // Simula una lista de eventos "descargados" desde un servidor.
  final Map<int, Map<String, dynamic>> _feedbacks =
      {}; // Almacena retroalimentaciones dadas a eventos.
  final Set<int> _subscribedEvents =
      {}; // Eventos a los que el usuario se ha unido.
  final int _remoteVersion = 1; // Versión remota de eventos.

  @override
  Future<List<EventModel>> fetchEvents() async =>
      _remoteEvents; // Devuelve los eventos falsos.

  @override
  Future<void> subscribeToEvent(int id) async {
    _subscribedEvents.add(id); // Marca el evento como suscrito.
  }

  @override
  Future<void> sendFeedback(int id, int rating, String comment) async {
    _feedbacks[id] = {'rating': rating, 'comment': comment}; // Guarda feedback.
  }

  @override
  Future<int> fetchEventVersion() async =>
      _remoteVersion; // Devuelve la versión.
  @override
  Future<int> fetchRemoteVersion() async => _remoteVersion;

  bool hasFeedbackFor(int id) =>
      _feedbacks.containsKey(id); // Verifica si se envió feedback.
  bool isSubscribed(int id) =>
      _subscribedEvents.contains(id); // Verifica si está suscrito.
}

class FakeNetworkInfo implements NetworkInfo {
  @override
  Future<bool> isConnected() async => true; // Siempre devuelve conexión.

  @override
  Stream<bool> get stream => Stream.value(true); // Stream simulado activo.

  @override
  void openStream() {} // No hace nada, pero respeta la interface.
}

late FakeRemoteDataSource remoteDataSource; // Para inspección desde el test.

Future<Widget> createTestApp() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Requerido para inicializar bindings de Flutter.

  final dir =
      await getApplicationDocumentsDirectory(); // Ruta local del dispositivo.
  await Hive.initFlutter(dir.path); // Inicializa Hive en ese path.
  Hive.registerAdapter(
      EventHiveModelAdapter()); // Registra adaptador de modelo para Hive.
  await Hive.openBox('eventsBox'); // Abre caja de eventos.

  SharedPreferences.setMockInitialValues(
      {}); // Simula preferencias compartidas (almacenamiento local).
  await SharedPreferences.getInstance();

  final localDataSource =
      EventLocalDataSource(); // Fuente de datos local (Hive).
  remoteDataSource = FakeRemoteDataSource(); // Fuente remota falsa.
  final networkInfo = FakeNetworkInfo(); // Red simulada siempre conectada.

  final repo = EventRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo,
  );

  final checkVersionUseCase = CheckEventVersionUseCaseImpl(
    local: localDataSource,
    remote: remoteDataSource,
  );

  final joinEventUseCase = JoinEvent(repo);
  final unjoinEventUseCase = UnjoinEvent(repo);
  final filterEventsUseCase = FilterEvents();

  Get.reset(); // Limpia bindings anteriores.
  Get.put(HomeController()); // Inyecta controlador Home.
  Get.put(EventController(
    repository: repo,
    joinEventUseCase: joinEventUseCase,
    unjoinEventUseCase: unjoinEventUseCase,
    filterEventsUseCase: filterEventsUseCase,
    checkVersionUseCase: checkVersionUseCase,
  ));

  return const MyApp(
      initialRoute: '/'); // Retorna el widget principal de la app.
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test completo PuntoG con fake repos y Hive', (tester) async {
    final app = await createTestApp(); // Construye la app simulada.
    await tester.pumpWidget(app); // Lanza la app.

    await tester
        .pump(const Duration(seconds: 3)); // Simula duración del splash screen.
    await tester
        .pumpAndSettle(); // Espera a que termine cualquier animación o frame.

    // HOME
    await tester.enterText(find.byKey(const Key('name_input')), 'Juan');
    await tester.tap(find.byKey(const Key('startButton')));
    await tester.pumpAndSettle();

    // EVENTOS
    final eventCard = find.byKey(const Key('eventCard_1'));
    expect(eventCard, findsOneWidget);
    await tester.tap(eventCard);
    await tester.pumpAndSettle();

    // JOIN EVENTO
    await tester.tap(find.byKey(const Key('joinButton')));
    await tester.pumpAndSettle();
    expect(remoteDataSource.isSubscribed(1), isTrue);

    // MIS EVENTOS
    await tester.tap(find.byKey(const Key('myEventsTab')));
    await tester.pumpAndSettle();

    // FEEDBACK
    await tester.tap(find.byKey(const Key('pastEventCard_1')));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key('feedbackField')), 'Buen evento');
    await tester.tap(find.byKey(const Key('submitFeedbackButton')));
    await tester.pumpAndSettle();
    expect(remoteDataSource.hasFeedbackFor(1), isTrue);

    // PERFIL → LOGOUT
    await tester.tap(find.byKey(const Key('profileTab')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logoutButton')));
    await tester.pumpAndSettle();

    // DE VUELTA AL HOME
    expect(find.byKey(const Key('name_input')), findsOneWidget);

    await Hive.box('eventsBox').clear(); // Limpia Hive después del test.
  });
}
