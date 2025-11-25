import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:snueco/controller/beacon_controller.dart';
import 'package:snueco/services/beacon_recorder.dart';
import 'package:snueco/services/beacon_scanner.dart';
import 'package:snueco/services/i_beacon_service.dart';

import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

// ✅ 카메라 캡처 화면(우리가 만든 화면) 임시 푸시용
import 'package:snueco/pages/camera_capture_screen.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'
    as barcode_scanner;

late final BeaconController beaconController;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ 세로 고정(오버레이 비율 유지)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final iBeaconService = IBeaconService(
    scanner: BeaconScanner(),
    recorder: BeaconRecorder(prefs: prefs),
  );
  beaconController = BeaconController(iBeaconService: iBeaconService);

  runApp(const MyApp());

  // ✅ 로그인 상태에 따라 비콘 제어(기존 로직 유지)
  FirebaseAuth.instance.authStateChanges().listen((user) async {
    if (user != null) {
      final ok =
          await iBeaconService.checkAndRequestForegroundLocationPermission();
      if (ok) {
        await iBeaconService.initializeIfNeeded();
        await iBeaconService.flushBackgroundBeacons();
        await beaconController.start();
        // ignore: avoid_print
        print('✅ 로그인 + 위치권한 OK: 비콘 감지 시작');
      } else {
        // ignore: avoid_print
        print('❌ 위치권한 없음: 비콘 감지하지 않음');
      }
    } else {
      beaconController.stop();
      // ignore: avoid_print
      print('🚫 로그아웃: 비콘 감지 중단');
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late Stream<BaseAuthUser> userStream;
  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = snuecoFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    beaconController.dispose();
    super.dispose();
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SNUECO',
      // ✅ 한국어 로캘 추가
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ko', ''), // ← 추가
      ],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});
  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage_3_Home';
  late Widget? _currentPage;

  // ✅ 어디서든 QR 스캔을 호출할 수 있게 헬퍼 유지(기존 로직)
  Future<void> scanQR(Function(String) onRead) async {
    String result;
    try {
      result = await barcode_scanner.FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        barcode_scanner.ScanMode.QR,
      );
      // ignore: avoid_print
      print(result);
    } on PlatformException {
      result = 'Failed to get platform version.';
    }
    if (!mounted) return;
    onRead(result);
  }

  // ✅ 카메라 캡처 화면으로 진입(GoRouter에 등록 전 임시 사용 가능)
  void openCameraCapture() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CameraCaptureScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'homepage_2_stair': Homepage2StairWidget(),
      'homepage_2_leftover': Homepage2leftoverWidget(),
      'HomePage_3_Home': HomePage3HomeWidget(scanQR: scanQR),
      'homepage_4_news': Homepage4NewsWidget(),
      'homepage_5_set': Homepage5SetWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: const Color(0x8A000000),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.stairs_sharp, size: 24.0),
            label: 'Stair up',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_sharp, size: 24.0),
            label: 'leftovers',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 24.0),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper, size: 24.0),
            label: 'News',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_sharp, size: 24.0),
            label: 'setting',
            tooltip: '',
          )
        ],
      ),

      // ✅ 예시: 홈에서 플로팅 버튼으로 카메라 캡처 화면을 띄우고 싶다면 이렇게.
      //    (필요 없으면 제거)
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: openCameraCapture,
      //   icon: const Icon(Icons.photo_camera),
      //   label: const Text('촬영'),
      // ),
    );
  }
}
