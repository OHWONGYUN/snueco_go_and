import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snueco/pages/home_page_3_home/hippie_girl_animation.dart';
import 'package:snueco/utils/keys.dart';
import 'package:snueco/services/beacon_recorder.dart';
import 'package:snueco/pages/camera_capture_screen.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'permission_dialog.dart';
import 'home_page3_home_model.dart';
export 'home_page3_home_model.dart';
import 'dart:convert'; // for json.decode
import 'package:shared_preferences/shared_preferences.dart'; // for SharedPreferences

class HomePage3HomeWidget extends StatefulWidget {
  final Function(Function(String)) scanQR;
  const HomePage3HomeWidget({super.key, required this.scanQR});

  @override
  State<HomePage3HomeWidget> createState() => _HomePage3HomeWidgetState();
}

class _HomePage3HomeWidgetState extends State<HomePage3HomeWidget> {
  late HomePage3HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePage3HomeModel());

    () async {
      final prefs = await SharedPreferences.getInstance();
      final recorder = BeaconRecorder(prefs: prefs);
      await recorder.flushBackgroundBeacons();
    }();

    _loadStoredBeacons();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPermissionDialog();
    });
  }

  Future<void> _loadStoredBeacons() async {
    final prefs = await SharedPreferences.getInstance();
    final beaconJsonList = prefs.getStringList('detected_beacons') ?? [];
    try {
      final beacons =
          beaconJsonList.map((jsonStr) => json.decode(jsonStr)).toList();

      // 원하는 작업: 예를 들어 콘솔 출력
      print('앱 시작 시 불러온 비콘 데이터: $beacons');
    } catch (e) {
      print('❌ Error loading detected_beacons: $e');
      prefs.remove('detected_beacons');
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _showPermissionDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyShown = prefs.getBool(Keys.backgroundDialogShown) ?? false;

    if (alreadyShown) {
      print('✅ 이미 백그라운드 권한 팝업을 보여줌 (스킵)');
      return;
    }

    await Future.delayed(Duration(seconds: 2));

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const PermissionDialog(),
    );

    // 사용자가 무엇을 눌렀든 상관없이, '보여준 것'으로 처리
    await prefs.setBool(Keys.backgroundDialogShown, true);
    print('✅ 최초 1회 팝업 기록 완료');
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              15,
                              0,
                              0,
                              0,
                            ),
                            child: Container(
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/__.png',
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: GradientText(
                                      'SNU Eco',
                                      style: FlutterFlowTheme.of(
                                        context,
                                      ).bodyMedium.override(
                                            fontFamily: 'NotoSans',
                                            color: Color(0xFF343434),
                                            fontSize: 22,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w900,
                                            useGoogleFonts: false,
                                          ),
                                      colors: [
                                        FlutterFlowTheme.of(context).primary,
                                        Color(0xFF562EE8),
                                      ],
                                      gradientDirection: GradientDirection.ltr,
                                      gradientType: GradientType.linear,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                0,
                                15,
                                0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/coss.png',
                                  width: 80,
                                  height: 35,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          // context.pushNamed(Homepage5SetWidget.routeName);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  20,
                                  0,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  '안녕하세요,',
                                  style: FlutterFlowTheme.of(
                                    context,
                                  ).bodyMedium.override(
                                        fontFamily: 'NotoSans',
                                        fontSize: 20,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: false,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: AuthUserStreamWidget(
                            builder: (context) => Text(
                              currentUserDisplayName,
                              style: FlutterFlowTheme.of(
                                context,
                              ).bodyMedium.override(
                                    fontFamily: 'NotoSans',
                                    fontSize: 24,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ),
                        Text(
                          '님!',
                          style: FlutterFlowTheme.of(
                            context,
                          ).bodyMedium.override(
                                fontFamily: 'NotoSans',
                                fontSize: 20,
                                letterSpacing: 0.0,
                                useGoogleFonts: false,
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.5,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      20,
                                      40,
                                      0,
                                      0,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            10,
                                            0,
                                            0,
                                          ),
                                          child: Text(
                                            'CO2\n저감량 g',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.override(
                                                  fontFamily: 'NotoSans',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            (double var1) {
                                              return "$var1";
                                            }(
                                              valueOrDefault(
                                                currentUserDocument?.rewardWon,
                                                0,
                                              ).toDouble(),
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.override(
                                                  fontFamily: 'NotoSans',
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  useGoogleFonts: false,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      20,
                                      0,
                                      0,
                                      30,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            0,
                                            10,
                                          ),
                                          child: Container(
                                            width: MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                0.23,
                                            height: MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                0.23,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryBackground,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                0,
                                                -0.2,
                                              ),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Text(
                                                  valueOrDefault(
                                                    currentUserDocument?.steps,
                                                    0,
                                                  ).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyMedium.override(
                                                        fontFamily: 'NotoSans',
                                                        fontSize: 30,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '오늘의 계단 수',
                                          style: FlutterFlowTheme.of(
                                            context,
                                          ).bodyMedium.override(
                                                fontFamily: 'NotoSans',
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      30,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            0,
                                            10,
                                          ),
                                          child: Container(
                                            width: MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                0.23,
                                            height: MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                0.23,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryBackground,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                0,
                                                -0.2,
                                              ),
                                              child: AuthUserStreamWidget(
                                                builder: (context) => Text(
                                                  valueOrDefault(
                                                    currentUserDocument
                                                        ?.thisMonthSteps,
                                                    0,
                                                  ).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyMedium.override(
                                                        fontFamily: 'NotoSans',
                                                        fontSize: 30,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '이달의 계단 수',
                                          style: FlutterFlowTheme.of(
                                            context,
                                          ).bodyMedium.override(
                                                fontFamily: 'NotoSans',
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      20,
                                      30,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            0,
                                            0,
                                            10,
                                          ),
                                          child: Container(
                                            width: MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                0.23,
                                            height: MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                0.23,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryBackground,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                0,
                                                -0.2,
                                              ),
                                              child: AuthUserStreamWidget(
                                                builder: (
                                                  context,
                                                ) =>
                                                    FutureBuilder<int>(
                                                  future: queryUsersRecordCount(
                                                    queryBuilder: (
                                                      usersRecord,
                                                    ) =>
                                                        usersRecord
                                                            .where(
                                                              'this_month',
                                                              isEqualTo:
                                                                  dateTimeFormat(
                                                                "M/y",
                                                                dateTimeFromSecondsSinceEpoch(
                                                                  getCurrentTimestamp
                                                                      .secondsSinceEpoch,
                                                                ),
                                                              ),
                                                            )
                                                            .where(
                                                              'this_month_steps',
                                                              isGreaterThan:
                                                                  valueOrDefault(
                                                                currentUserDocument
                                                                    ?.thisMonthSteps,
                                                                0,
                                                              ),
                                                            ),
                                                  ),
                                                  builder: (
                                                    context,
                                                    snapshot,
                                                  ) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Color(
                                                                0xFF12B465,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    int textCount =
                                                        snapshot.data!;

                                                    return Text(
                                                      (int var1) {
                                                        return "${var1 + 1}위";
                                                      }(textCount),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                        context,
                                                      ).bodyMedium.override(
                                                                fontFamily:
                                                                    'NotoSans',
                                                                fontSize: 30,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                useGoogleFonts:
                                                                    false,
                                                              ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '나의 계단 랭킹',
                                          style: FlutterFlowTheme.of(
                                            context,
                                          ).bodyMedium.override(
                                                fontFamily: 'NotoSans',
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: false,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: Text(
                          '[안내] 계단수가 제대로 오르지 않는 경우, \'설정 > 애플리케이션 > SNUECO > 권한 > 근처 기기, 위치 권한 허용 \'을 설정해주세요 :)',
                          style: FlutterFlowTheme.of(
                            context,
                          ).bodyMedium.override(
                                fontFamily: 'NotoSans',
                                color: Color(0xFF424242),
                                letterSpacing: 0.0,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 1.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 15.0, 15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraCaptureScreen()),
                            );
                          },
                          child: Container(
                            width: 75.0,
                            height: 75.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF562EE8),
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.lunch_dining,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 45.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AuthUserStreamWidget(
                  builder: (context) => HippieGirlAnimation(
                    stepCount: valueOrDefault(
                      currentUserDocument?.steps,
                      0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> qrrewardaccepted(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, //바깥을 터치하면 닫힘
      builder: (BuildContext context) => AlertDialog(
        title: Text('알림'),
        content: Text('텀블러 사용 인증에 성공했어요!'),
        elevation: 3.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  Future<dynamic> qrrewardrejected(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, //바깥을 터치하면 닫힘
      builder: (BuildContext context) => AlertDialog(
        title: Text('알림'),
        content: Text('오늘 이미 텀블러를 인증했어요!'),
        elevation: 3.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  Future<dynamic> qrrewardunaccepted(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, //바깥을 터치하면 닫힘
      builder: (BuildContext context) => AlertDialog(
        title: Text('알림'),
        content: Text('텀블러 사용 인증에 실패했어요!'),
        elevation: 3.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  onRead(String scanBarcode) async {
    if (scanBarcode.contains('SNUEco')) {
      bool doNotUpdateBottle =
          valueOrDefault(currentUserDocument?.lastBottleUpdate, '') ==
              dateTimeFormat(
                'd/M/y',
                dateTimeFromSecondsSinceEpoch(
                  getCurrentTimestamp.secondsSinceEpoch,
                ),
              );

      if (doNotUpdateBottle) {
        qrrewardrejected(context);
      } else {
        qrrewardaccepted(context);
      }

      var updateBottle = doNotUpdateBottle
          ? null
          : () async {
              await currentUserReference!.update({
                ...mapToFirestore({
                  'log_bottle': FieldValue.arrayUnion([
                    getLogElementFirestoreData(
                      createLogElementStruct(
                        content: '텀블러 사용',
                        updateBottle: '+45.2',
                        date: getCurrentTimestamp.secondsSinceEpoch,
                        clearUnsetFields: false,
                      ),
                      true,
                    ),
                  ]),
                }),
              });
              // add reward_won

              await currentUserReference!.update({
                ...mapToFirestore({'reward_won': FieldValue.increment(45.2)}),
              });

              await currentUserReference!.update({
                ...mapToFirestore({'count_bottle': FieldValue.increment(1)}),
              });

              await currentUserReference!.update(
                createUsersRecordData(
                  lastBottleUpdate: dateTimeFormat(
                    'd/M/y',
                    dateTimeFromSecondsSinceEpoch(
                      getCurrentTimestamp.secondsSinceEpoch,
                    ),
                  ),
                ),
              );
            };

      await updateBottle!();
    } else {
      qrrewardunaccepted(context);
    }
  }
}
