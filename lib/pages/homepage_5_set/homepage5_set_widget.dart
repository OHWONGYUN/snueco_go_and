import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'homepage5_set_model.dart';
export 'homepage5_set_model.dart';

class Homepage5SetWidget extends StatefulWidget {
  const Homepage5SetWidget({super.key});

  @override
  State<Homepage5SetWidget> createState() => _Homepage5SetWidgetState();
}

class _Homepage5SetWidgetState extends State<Homepage5SetWidget> {
  late Homepage5SetModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isServiceOn = false; // 비콘 서비스 상태 토글용
  static const platform =
      MethodChannel('com.example.my_project/beacon'); // 메서드 채널

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Homepage5SetModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 46.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24.0,
          ),
          onPressed: () async {
            context.pushNamed('HomePage_3_Home');
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: Text(
                    '계정 및 환경설정',
                    style: FlutterFlowTheme.of(context).headlineSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 0.0),
                  child: Text(
                    '당신에게 꼭 맞는 SNU Eco가 될게요',
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    width: 374.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        12.0,
                        0.0,
                        12.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              0.0,
                              16.0,
                              0.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0,
                                    0.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: Text(
                                    '유저 정보',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(
                                      context,
                                    ).labelMedium.override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              12.0,
                              8.0,
                              12.0,
                              8.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    12.0,
                                    0.0,
                                  ),
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x4C4B39EF),
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Color(0xFF4B39EF),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              currentUserPhoto,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/snueco-nay7gk/assets/aolabbkn1id7/%EB%A1%9C%EA%B7%B8%EB%A7%81.png',
                                            ),
                                            width: 36.0,
                                            height: 36.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0,
                                    0.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          currentUserDisplayName,
                                          style: FlutterFlowTheme.of(
                                            context,
                                          ).bodyMedium.override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0xFF14181B),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          4.0,
                                          0.0,
                                          0.0,
                                        ),
                                        child: Text(
                                          currentUserEmail,
                                          style: FlutterFlowTheme.of(
                                            context,
                                          ).bodySmall.override(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0xFF4B39EF),
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1.0, color: Color(0xFFE0E3E7)),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              12.0,
                              0.0,
                              12.0,
                              4.0,
                            ),
                            child: MouseRegion(
                              opaque: false,
                              cursor: MouseCursor.defer ?? MouseCursor.defer,
                              onEnter: ((event) async {
                                setState(
                                  () => _model.mouseRegionHovered = true,
                                );
                              }),
                              onExit: ((event) async {
                                setState(
                                  () => _model.mouseRegionHovered = false,
                                );
                              }),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('homepage_1_reward');
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.easeInOut,
                                  width: double.infinity,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    color: _model.mouseRegionHovered
                                        ? Color(0xFFF1F4F8)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0,
                                        8.0,
                                        0.0,
                                        8.0,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                              0.0,
                                              0.0,
                                            ),
                                            child: FaIcon(
                                              FontAwesomeIcons.cannabis,
                                              color: Color(0xFF14181B),
                                              size: 40.0,
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                0.0,
                                                0.0,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                      -1.0,
                                                      0.0,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                        12.0,
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                      child: Text(
                                                        '이산화탄소 저감량',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                          context,
                                                        )
                                                                .headlineSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  color: Color(
                                                                    0xFF14181B,
                                                                  ),
                                                                  fontSize:
                                                                      24.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                      -1.0,
                                                      0.0,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                        12.0,
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                      child:
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Text(
                                                          (int var1) {
                                                            return "${var1}g CO2-Eq";
                                                          }(
                                                            valueOrDefault(
                                                              currentUserDocument
                                                                  ?.rewardWon,
                                                              0,
                                                            ),
                                                          ),
                                                          style:
                                                              FlutterFlowTheme
                                                                      .of(
                                                            context,
                                                          ).bodyMedium.override(
                                                                    fontFamily:
                                                                        'Plus Jakarta Sans',
                                                                    color:
                                                                        Color(
                                                                      0xFF14181B,
                                                                    ),
                                                                    fontSize:
                                                                        14.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                      -1.0,
                                                      0.0,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                        12.0,
                                                        0.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                      child: Text(
                                                        '지금까지 저감한 이산화탄소양을\n한번에 관리할 수 있어요',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                          context,
                                                        ).bodyMedium.override(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  color: Color(
                                                                    0xFF14181B,
                                                                  ),
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('notification');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '알림',
                                      style: FlutterFlowTheme.of(
                                        context,
                                      ).titleLarge,
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryText,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('request');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '문의사항',
                                      style: FlutterFlowTheme.of(
                                        context,
                                      ).titleLarge,
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryText,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('personal_policy');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '개인정보 처리방침',
                                      style: FlutterFlowTheme.of(
                                        context,
                                      ).titleLarge,
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryText,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('personal_policy');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  5.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          GoRouter.of(
                                            context,
                                          ).prepareAuthEvent();
                                          await authManager.signOut();
                                          GoRouter.of(
                                            context,
                                          ).clearRedirectLocation();

                                          context.goNamedAuth(
                                            'mainlogin',
                                            context.mounted,
                                          );
                                        },
                                        text: 'Log Out',
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                            24.0,
                                            0.0,
                                            24.0,
                                            0.0,
                                          ),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).secondaryBackground,
                                          textStyle: FlutterFlowTheme.of(
                                            context,
                                          ).labelMedium,
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).alternate,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          16.0,
                                          0.0,
                                        ),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            Navigator.pop(context);

                                            context.pushNamed('mainlogin');
                                            await authManager.deleteUser(
                                              context,
                                            );
                                          },
                                          text: '탈퇴하기',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                              24.0,
                                              0.0,
                                              24.0,
                                              0.0,
                                            ),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                              0.0,
                                              0.0,
                                              0.0,
                                              0.0,
                                            ),
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                            textStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium,
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              50.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('personal_policy');
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  20.0,
                                  5.0,
                                  2.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      child: Text(
                                        'App Versions v0.0.1',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).titleLarge.override(
                                              fontFamily: 'NotoSans',
                                              color: Color(0xFF656565),
                                              fontSize: 12.0,
                                              useGoogleFonts: false,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SwitchListTile(
                            title: Text(
                              '백그라운드 비콘 감지',
                              style: FlutterFlowTheme.of(context).titleLarge,
                            ),
                            value: isServiceOn,
                            onChanged: (bool value) async {
                              try {
                                if (value) {
                                  await platform.invokeMethod(
                                    'startBeaconService',
                                  );
                                } else {
                                  await platform.invokeMethod(
                                    'stopBeaconService',
                                  );
                                }
                                setState(() {
                                  isServiceOn = value;
                                });
                              } catch (e) {
                                print('비콘 토글 에러: $e');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ].addToEnd(SizedBox(height: 64.0)),
        ),
      ),
    );
  }
}
