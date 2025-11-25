import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'personal_policy_copy_model.dart';
export 'personal_policy_copy_model.dart';

class PersonalPolicyCopyWidget extends StatefulWidget {
  const PersonalPolicyCopyWidget({super.key});

  @override
  State<PersonalPolicyCopyWidget> createState() =>
      _PersonalPolicyCopyWidgetState();
}

class _PersonalPolicyCopyWidgetState extends State<PersonalPolicyCopyWidget> {
  late PersonalPolicyCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PersonalPolicyCopyModel());
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      fillColor: Colors.transparent,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('homepage_5_set');
                      },
                    ),
                    Text(
                      '개인정보 처리방침',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'NotoSans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                useGoogleFonts: false,
                              ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '어플 내에서 수집한 개인정보의 처리방침\n최초 작성일: 2024년 1월 11일',
                                style: FlutterFlowTheme.of(context).labelMedium,
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 15.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Text(
                                '1. 개인정보 수집\n\n  서비스 제공을 위해 필요한 최소한의 개인정보를 수집합니다.\n\n  회원 가입 시 또는 서비스 이용 과정에서 리워드 지급이나 랭킹 서비스를 제공하기 위해 필요한 최소한의 개인정보를 수집하고 있습니다.\n\n  서비스 제공을 위해 반드시 필요한 최소한의 정보를 필수항목으로 초기 회원가입 시 입력받고 있으며, 임의로 설정하여 이용하는 경우에도 서비스 이용 제한은 없습니다. \n\n  - 서비스: 스누에코 (SNU Eco)\n\n  - 수집하는 항목:  [필수] 서울대학교 이용자가 소속되어 있는 학과, 단과대학, 이메일, 닉네임  [선택] 프로필 사진\n2. 개인정보 이용\n\n  회원관리, 서비스 제공·개선, 신규 서비스 개발 등을 위해 이용합니다.\n\n. 회원 식별/가입의사 확인\n\n. 어플 이용자에게 계단을 오른 층수나 어플 내에서 측정된 온실가스 배출 저감량을 알리는 기능 제공\n\n· 서비스의 원활한 운영에 지장을 주는 행위(계정 도용 및 부정 이용 행위 등 포함)에 대한 방지 및 제재\n\n· 신규 서비스 개발 및 서비스 기능 개선, 개인화된 서비스 제공, 프라이버시 보호를 위한 서비스 환경 구축\n\n· 서비스 이용 기록, 접속 빈도 및 서비스 이용에 대한 통계 \n\n3. 개인정보 파기\n\n가입자가 탈퇴하는 즉시 모든 관련 정보를 파기합니다.\n\n4. 개인 활동정보의 처리\n어플 내 주요 기능을 제공하기 위해 개인의 활동정보를 보유할 수 있습니다.\n활동정보에는 다음과 같은 항목이 포함됩니다.\n\n-음수대 사용 기록\n-계단이용기록 (층수, 시간)\n\n5. 개인정보의 안전성 확보 조치에 관한 사항\n개인정보는 데이터베이스(google firebase)에 저장되고 있으며, 이에 접근할 수 있는 사람은 어플 개발 및 운영진들로 제한하고 있습니다.\n사용자의 비밀번호 등 악용하여 활용할 수 있는 정보에 대해서는 데이터베이스 내에서 암호화하여 관리하고 있습니다.\n\n최초 작성일: 2024년 1월 11일\n작성자: 류한나',
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: 'NotoSans',
                                      fontSize: 14.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
