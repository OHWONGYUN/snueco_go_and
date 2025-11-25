import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'homepage2_leftover_model.dart';
import 'history_page.dart';

// ▼ 추가
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

export 'homepage2_leftover_model.dart';

class Homepage2leftoverWidget extends StatefulWidget {
  const Homepage2leftoverWidget({super.key});

  @override
  State<Homepage2leftoverWidget> createState() =>
      _Homepage2leftoverWidgetState();
}

class _Homepage2leftoverWidgetState extends State<Homepage2leftoverWidget> {
  late Homepage2leftoverModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Homepage2leftoverModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // 최신 업로드(모든 날짜 통합) 1건을 가져오는 스트림
  Stream<QuerySnapshot<Map<String, dynamic>>> _latestUploadStream(String uid) {
    return FirebaseFirestore.instance
        .collectionGroup('uploads')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots();
  }

  // Storage path -> download URL
  Future<String> _getDownloadUrl(String storagePath) async {
    final ref = FirebaseStorage.instance.ref().child(storagePath);
    return await ref.getDownloadURL();
  }

  // regions 구조에서 메뉴별 배출량(kgCO2e)을 합산
  Map<String, double> _aggregateMenuEmissions(Map<String, dynamic> regions) {
    final Map<String, double> totals = {};
    regions.forEach((regionKey, regionVal) {
      if (regionVal is Map<String, dynamic>) {
        final menus = regionVal['menus'];
        if (menus is List) {
          for (final m in menus) {
            final name = (m['name'] ?? '').toString();
            final em = (m['emission'] ?? 0).toDouble(); // kgCO2e
            if (name.isEmpty) continue;
            totals.update(name, (v) => v + em, ifAbsent: () => em);
          }
        }
      }
    });
    // emission 내림차순 정렬된 Map 반환
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return {for (final e in entries) e.key: e.value};
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'SNU Eco',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'NotoSans',
                              color: Colors.white,
                              fontSize: 22.0,
                              useGoogleFonts: false,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HistoryPageWidget()),
            );
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.history,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: uid == null
              ? const Center(child: Text('로그인이 필요합니다.'))
              : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _latestUploadStream(uid),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snap.hasError) {
                      return Center(child: Text('불러오기 오류: ${snap.error}'));
                    }
                    if (!snap.hasData || snap.data!.docs.isEmpty) {
                      // 업로드 이력이 없을 때
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 15, 16, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: Text(
                                        '잔반 내역',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 12.0,
                                    thickness: 1.0,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              child: AspectRatio(
                                aspectRatio: 3 / 4, // ▶ 3:4 세로 사진 비율
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        'https://via.placeholder.com/600x800.png?text=No+leftover+yet',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 0, 16, 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _MenuCard(
                                      title: '메뉴 별 배출량',
                                      children: const [
                                        _MenuPair(label: '—', valueKg: null),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _TotalCard(totalKg: null),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final doc = snap.data!.docs.first.data();
                    final storagePath = (doc['storagePath'] ?? '').toString();
                    final totalEmission =
                        (doc['totalEmission'] ?? 0).toDouble(); // kgCO2e
                    final regions =
                        Map<String, dynamic>.from(doc['regions'] ?? {});
                    final perMenu = _aggregateMenuEmissions(regions);

                    return FutureBuilder<String>(
                      future: _getDownloadUrl(storagePath),
                      builder: (context, urlSnap) {
                        final imageUrl = urlSnap.data ??
                            'https://via.placeholder.com/600x800.png?text=Leftover+Photo';
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 15, 16, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: Text(
                                          '잔반 내역',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 12.0,
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  ],
                                ),
                              ),
                              // 최근 사진 (3:4)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                child: AspectRatio(
                                  aspectRatio: 3 / 4, // ▶ 3:4
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(12.0),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(imageUrl),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // 좌: 메뉴별(세로쌍), 우: 총배출량(g)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _MenuCard(
                                        title: '메뉴 별 배출량',
                                        children: perMenu.isEmpty
                                            ? const [
                                                _MenuPair(
                                                    label: '—', valueKg: null)
                                              ]
                                            : perMenu.entries
                                                .map((e) => _MenuPair(
                                                    label: e.key,
                                                    valueKg: e.value))
                                                .toList(),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _TotalCard(totalKg: totalEmission),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

// ---- 작은 위젯들 ----

// 카드: 메뉴 리스트
class _MenuCard extends StatelessWidget {
  final String title;
  final List<_MenuPair> children;
  const _MenuCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // ▶ 250 → 180
      child: Material(
        color: Colors.transparent,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 메뉴 하나: "이름" (위) / "배출량 gCO2e" (아래)
class _MenuPair extends StatelessWidget {
  final String label;
  final double? valueKg; // 서버는 kgCO2e, 표시만 gCO2e
  const _MenuPair({required this.label, required this.valueKg});

  String _formatG(double grams) {
    // 0.8 같은 소수 깔끔하게 (최대 2자리)
    if (grams >= 10) {
      return grams.toStringAsFixed(1);
    } else {
      return grams.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = valueKg != null;
    final grams = hasValue ? (valueKg! * 500) : null; // kg → g
    final valueText = hasValue ? '${_formatG(grams!)}gCO2e' : '—';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(
            valueText,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// 총 배출량 카드 (g 표기)
class _TotalCard extends StatelessWidget {
  final double? totalKg; // 서버는 kgCO2e, 표시만 gCO2e (여기서는 ×500만 유지)
  const _TotalCard({required this.totalKg});

  String _formatG(double grams) {
    if (grams >= 10) {
      return grams.toStringAsFixed(1);
    } else {
      return grams.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ★ 기존 로직 유지: kg → (여기선) ×500만 적용
    final text = totalKg == null ? '—' : '${_formatG(totalKg! * 500)} g\nCO2e';

    return SizedBox(
      height: 180, // 그대로
      child: Material(
        color: Colors.transparent,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ✅ 리스트 전체에 const 제거 (동적 text 넣어야 하므로)
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  '최근 탄소배출량',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              // ✅ 값 표시 추가
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
