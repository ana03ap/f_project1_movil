import 'package:f_web_service_random_user_template/core/network_info.dart';
import 'package:f_web_service_random_user_template/domain/entities/random_user.dart';
import 'package:f_web_service_random_user_template/domain/use_case/user_use_case.dart';
import 'package:f_web_service_random_user_template/ui/controllers/connectivity_controller.dart';
import 'package:f_web_service_random_user_template/ui/controllers/user_controller.dart';
import 'package:f_web_service_random_user_template/ui/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockNetworkInfo with Mock implements NetworkInfo {}

class MockGets with Mock implements UserUseCase {}

class MockHomeController extends GetxService
    with Mock
    implements ConnectivityController {
  final _connection = true.obs;
  @override
  Future onInit() {
    super.onInit();
    return Future.value(true);
  }

  @override
  bool get connection => _connection.value;
}

class MockUserController extends GetxService
    with Mock
    implements UserController {
  final _users = <RandomUser>[].obs;
  int cont = 0;
  @override
  List<RandomUser> get users => _users;

  @override
  Future onInit() {
    super.onInit();
    return Future.value(true);
  }

  @override
  Future<void> deleteUser(id) {
    logInfo("local deleteUser $id");
    _users.removeAt(id);
    return Future.value();
  }

  @override
  Future<void> deleteAll() {
    _users.clear();
    return Future.value();
  }

  @override
  Future<void> addUser() async {
    logInfo("local addUser");
    if (cont == 0) {
      RandomUser user = RandomUser(
          id: 0,
          city: 'Barranquilla',
          gender: 'Masculino',
          email: 'reyesjd@mail.com',
          name: 'Jesus Reyes',
          picture: 'https://randomuser.me/api/portraits/thumb/men/75.jpg');
      _users.add(user);
      cont++;
    } else {
      RandomUser user = RandomUser(
          id: 1,
          city: 'Barranquilla',
          gender: 'Masculino',
          email: 'jhanu@mail.com',
          name: 'Jhan Utria',
          picture: 'https://randomuser.me/api/portraits/thumb/men/75.jpg');
      _users.add(user);
      cont = 0;
    }
  }
}

void main() {
  setUp(() {
    final MockNetworkInfo _mockNetworkInfo = MockNetworkInfo();
    Get.put<NetworkInfo>(_mockNetworkInfo);

    final MockHomeController _mockHome = MockHomeController();
    Get.put<ConnectivityController>(_mockHome);

    final MockGets _mockGets = MockGets();
    Get.put<UserUseCase>(_mockGets);

    final MockUserController _mockUser = MockUserController();
    Get.put<UserController>(_mockUser);
  });

  testWidgets('Connection ok', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: UserListPage(),
      ),
    );
    await tester.pump();

    expect(find.byKey(const Key('addUserButton')), findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Add one, delete with swipe', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    // Build our app and trigger a frame.
    // https://pub.dev/packages/network_image_mock/example
    await tester.pumpWidget(
      MaterialApp(
        home: mockNetworkImagesFor(() => UserListPage()),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('addUserButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('addUserButton')));

    await tester.pump();

    expect(find.byType(Dismissible), findsOneWidget);

    await tester.drag(
        find.byKey(const Key('userItem0')), const Offset(500.0, 0.0));

    await tester.pumpAndSettle();

    expect(find.byType(Dismissible), findsNothing);
  });

  testWidgets('Add two, delete one with swipe', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    // Build our app and trigger a frame.
    // https://pub.dev/packages/network_image_mock/example
    await tester.pumpWidget(
      MaterialApp(
        home: mockNetworkImagesFor(() => UserListPage()),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('addUserButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('addUserButton')));

    await tester.pump();

    await tester.tap(find.byKey(const Key('addUserButton')));

    await tester.pump();

    expect(find.byType(Dismissible), findsNWidgets(2));

    await tester.drag(
        find.byKey(const Key('userItem0')), const Offset(500.0, 0.0));

    await tester.pumpAndSettle();

    expect(find.byType(Dismissible), findsOneWidget);
  });

  testWidgets('Add one, delete all', (WidgetTester tester) async {
// Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();

    // Build our app and trigger a frame.
    // https://pub.dev/packages/network_image_mock/example
    await tester.pumpWidget(
      MaterialApp(
        home: mockNetworkImagesFor(() => UserListPage()),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('addUserButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('addUserButton')));

    await tester.pump();

    expect(find.byKey(const Key('userItem0')), findsOneWidget);

    await tester.tap(find.byKey(const Key('deleteAllButton')));

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('userItem')), findsNothing);
  });
}
