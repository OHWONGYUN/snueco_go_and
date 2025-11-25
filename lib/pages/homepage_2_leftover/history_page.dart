import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';

// ▼ 추가
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HistoryPageWidget extends StatelessWidget {
  const HistoryPageWidget({super.key});

  Stream<QuerySnapshot<Map<String, dynamic>>> _historyStream(String uid) {
    return FirebaseFirestore.instance
        .collectionGroup('uploads')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(100)
        .snapshots();
  }

  Future<String> _url(String storagePath) async {
    return await FirebaseStorage.instance.ref().child(storagePath).getDownloadURL();
  }

  // g 표기 시 깔끔한 포맷
  String _formatG(double grams) {
    if (grams >= 10) return grams.toStringAsFixed(1);
    return grams.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('잔반 히스토리'),
        backgroundColor: FlutterFlowTheme.of(context).primary,
      ),
      body: uid == null
          ? const Center(child: Text('로그인이 필요합니다.'))
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _historyStream(uid),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('불러오기 오류: ${snap.error}'));
                }
                if (!snap.hasData || snap.data!.docs.isEmpty) {
                  return const Center(child: Text('기록이 없습니다.'));
                }
                final docs = snap.data!.docs;

                // 썸네일 목표 사이즈 (3:4)
                const double thumbH = 120.0;
                const double thumbW = thumbH * 3 / 4;

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, i) {
                    final data = docs[i].data();
                    final storagePath = (data['storagePath'] ?? '').toString();
                    final totalEmissionKg = (data['totalEmission'] ?? 0).toDouble(); // kgCO2e
                    final totalEmissionG = totalEmissionKg * 500; // ▶ gCO2e로 변환
                    final menuDate = (data['menuDate'] ?? '').toString();

                    return FutureBuilder<String>(
                      future: _url(storagePath),
                      builder: (context, urlSnap) {
                        final imgUrl = urlSnap.data;
                        return Container(
                          height: thumbH,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                          ),
                          child: Row(
                            children: [
                              // 왼쪽: 3:4 비율 이미지 (안잘리게 영역 자체를 3:4로 고정)
                              SizedBox(
                                width: thumbW,
                                height: thumbH,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: imgUrl == null
                                      ? Container(
                                          color: FlutterFlowTheme.of(context).alternate,
                                          child: const Center(child: Icon(Icons.image, size: 36)),
                                        )
                                      : AspectRatio(
                                          aspectRatio: 3 / 4,
                                          child: Image.network(
                                            imgUrl,
                                            fit: BoxFit.cover, // 컨테이너와 이미지 비율이 같아서 크롭 없음
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // 오른쪽: 총배출량(g)
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      menuDate.isEmpty ? '—' : menuDate,
                                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text('총 탄소배출량', style: TextStyle(fontWeight: FontWeight.w600)),
                                    Text(
                                      '${_formatG(totalEmissionG)} gCO₂e',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: docs.length,
                );
              },
            ),
    );
  }
}
