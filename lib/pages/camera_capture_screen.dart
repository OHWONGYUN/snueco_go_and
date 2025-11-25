import 'dart:async';
import 'dart:convert'; // JSON 처리를 위해 추가
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http; // 서버 통신을 위해 추가
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ← 추가: uid 전송용

// ---------------------------------------------------------------
// ▼▼▼ 서버 주소 최종 버전으로 수정 ▼▼▼
// ---------------------------------------------------------------
const String kServerBaseUrl = 'https://my-carbon-check-server.vercel.app';
// ---------------------------------------------------------------

// (상수 정의 부분은 기존과 동일)
const String kMenusRoot = 'menus';
const String kCafeId = 'duremidam';
const double kUnitW = 40.8;
const double kUnitH = 29.8;
const double kTopRowH = 23.0;
const double kBottomRowH = 8.8;
const double kTopW1 = 8.5;
const double kTopW2 = 7.0;
const double kTopW3 = 7.0;
const double kTopW4 = 8.26;
const double kBotW1 = 17.6;
const double kBotW2 = 14.7;
const double _x2 = kTopW1;
const double _x3 = kTopW1 + kTopW2;
const double _x4 = kTopW1 + kTopW2 + kTopW3;
const double _xBot2 = kBotW1;

class PlacedMenu {
  final String slotId;
  final String menuItem;
  PlacedMenu(this.slotId, this.menuItem);
}

class CameraCaptureScreen extends StatefulWidget {
  const CameraCaptureScreen({super.key});
  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  String? _shotPath;
  bool _review = false;
  bool _loadingMenus = false;
  bool _showMenuPanel = false;

  // ▼▼▼ 서버 전송 중 로딩 상태를 위한 변수 추가 ▼▼▼
  bool _isUploading = false;
  // ▲▲▲ 변수 추가 ▲▲▲

  List<String> _draggableMenuItems = [];
  Map<String, List<String>> _placedMenus = {};

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _controller = CameraController(
        back,
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      _initializeControllerFuture = _controller.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('카메라 초기화 실패: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------
  // ▼▼▼ 서버 통신을 위한 함수 전체 구현 ▼▼▼
  // ---------------------------------------------------------------
  Future<void> _uploadAndCheckCarbon() async {
    if (_shotPath == null || _shotPath!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('먼저 사진을 촬영해주세요.')),
      );
      return;
    }
    if (_placedMenus.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('메뉴를 하나 이상 배치해주세요.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final url = Uri.parse('$kServerBaseUrl/api/meal/upload');
      var request = http.MultipartRequest('POST', url);

      final Map<String, String> menuFields = {};
      _placedMenus.forEach((slotId, menuList) {
        String serverKey;
        switch (slotId) {
          case '반찬1':
            serverKey = 'region1';
            break;
          case '반찬2':
            serverKey = 'region2';
            break;
          case '반찬3':
            serverKey = 'region3';
            break;
          case '반찬4':
            serverKey = 'region4';
            break;
          case '밥':
            serverKey = 'rice';
            break;
          case '국':
            serverKey = 'soup';
            break;
          default:
            return;
        }
        if (menuList.isNotEmpty) {
          menuFields[serverKey] = menuList.join(',');
        }
      });

      // 메뉴 CSV 필드
      request.fields.addAll(menuFields);

      // ✅ 추가: userId, menuDate만 전송
      final uid = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';
      final now = DateTime.now();
      final menuDate =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      request.fields.addAll({
        'userId': uid,
        'menuDate': menuDate,
      });

      // 이미지 파일
      request.files.add(await http.MultipartFile.fromPath('image', _shotPath!));

      debugPrint("서버로 데이터 전송 시작...");
      debugPrint("메뉴 데이터: $menuFields, userId: $uid, menuDate: $menuDate");

      var streamedResponse =
          await request.send().timeout(const Duration(seconds: 30));

      if (streamedResponse.statusCode == 200) {
        final response = await http.Response.fromStream(streamedResponse);
        final responseData = jsonDecode(response.body);
        debugPrint('업로드 성공: $responseData');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('잔반 내역란에서 확인해보세요!')),
          );
        }
      } else {
        final errorBody = await streamedResponse.stream.bytesToString();
        debugPrint('업로드 실패: ${streamedResponse.reasonPhrase}');
        debugPrint('에러 내용: $errorBody');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('서버 통신에 실패했습니다: ${streamedResponse.reasonPhrase}')),
          );
        }
      }
    } catch (e) {
      debugPrint('오류 발생: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }
  // ---------------------------------------------------------------
  // ▲▲▲ 서버 통신 함수 끝 ▲▲▲
  // ---------------------------------------------------------------

  Future<void> _shoot() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      if (!mounted) return;
      setState(() {
        _shotPath = image.path;
        _review = true;
        _showMenuPanel = false;
        _draggableMenuItems = [];
        _placedMenus = {};
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('촬영 실패: $e')),
      );
    }
  }

  Future<List<String>> _fetchMenusForToday() async {
    final now = DateTime.now();
    final isDinner = now.hour >= 16;
    final date =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    try {
      final ref = FirebaseDatabase.instance
          .ref()
          .child(kMenusRoot)
          .child(date)
          .child(kCafeId);
      final snapshot = await ref.get().timeout(const Duration(seconds: 8));
      if (!snapshot.exists || snapshot.value == null) return [];
      final data = snapshot.value as Map<dynamic, dynamic>;
      final List<dynamic> raw =
          (isDinner ? data['dinner'] : data['lunch']) ?? [];
      return raw.map((e) => e.toString()).where((s) => s.isNotEmpty).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _onMenuSelectPressed() async {
    setState(() {
      _loadingMenus = true;
      _showMenuPanel = true;
      _placedMenus = {};
    });
    try {
      final items = await _fetchMenusForToday();
      if (!mounted) return;
      setState(() {
        _draggableMenuItems = items;
      });
    } finally {
      if (mounted) setState(() => _loadingMenus = false);
    }
  }

  // [수정] 메뉴 재사용을 위해 목록에서 메뉴를 제거하는 코드를 삭제하고, 같은 칸에 중복 추가되는 것을 방지합니다.
  void _onMenuItemDrop(String slotId, String menuItem) {
    setState(() {
      final currentSlotItems = _placedMenus[slotId] ?? [];
      // 같은 칸에 동일 메뉴가 중복으로 들어가는 것을 방지
      if (!currentSlotItems.contains(menuItem)) {
        if (_placedMenus.containsKey(slotId)) {
          _placedMenus[slotId]!.add(menuItem);
        } else {
          _placedMenus[slotId] = [menuItem];
        }
      }
      // _draggableMenuItems.remove(menuItem); // 이 줄을 삭제하여 메뉴가 목록에 남도록 함
    });
  }

  // [수정] 메뉴 재사용을 위해, 되돌린 메뉴를 목록에 다시 추가하는 코드를 삭제합니다.
  void _onReturnMenuItem(PlacedMenu returnedMenu) {
    setState(() {
      _placedMenus[returnedMenu.slotId]?.remove(returnedMenu.menuItem);
      if (_placedMenus[returnedMenu.slotId]?.isEmpty ?? false) {
        _placedMenus.remove(returnedMenu.slotId);
      }
      // _draggableMenuItems.add(returnedMenu.menuItem); // 이 줄을 삭제하여 메뉴가 목록에 중복 추가되지 않도록 함
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            fit: StackFit.expand,
            children: [
              _review && _shotPath != null
                  ? Image.file(File(_shotPath!), fit: BoxFit.cover)
                  : Center(child: CameraPreview(_controller)),
              Positioned.fill(
                child: _TrayOverlay(
                  placedMenus: _placedMenus,
                  onAccept: _onMenuItemDrop,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomPanel(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    final bool hasShot = _review && _shotPath != null;
    final double panelHeight =
        hasShot ? (_showMenuPanel ? 160.0 : 140.0) : 120.0;

    return DragTarget<PlacedMenu>(
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          height: panelHeight,
          decoration: BoxDecoration(
            color: isHovering
                ? Colors.blue.withOpacity(0.5)
                : Colors.black.withOpacity(0.4),
            border:
                isHovering ? Border.all(color: Colors.white, width: 2) : null,
          ),
          child: Column(
            children: [
              if (_showMenuPanel && hasShot)
                Expanded(
                  child: _loadingMenus
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : _MenuGrid(items: _draggableMenuItems),
                ),
              Row(
                children: [
                  if (!hasShot) ...[
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _shoot,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('촬영'),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          _review = false;
                          _shotPath = null;
                          _showMenuPanel = false;
                          _draggableMenuItems = [];
                          _placedMenus = {};
                        }),
                        child: const Text('다시 찍기'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _showMenuPanel
                          ? FilledButton(
                              onPressed:
                                  _isUploading ? null : _uploadAndCheckCarbon,
                              child: _isUploading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.white),
                                    )
                                  : const Text('탄소량 체크'),
                            )
                          : ElevatedButton(
                              onPressed:
                                  _loadingMenus ? null : _onMenuSelectPressed,
                              child: const Text('메뉴 입력'),
                            ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) => _onReturnMenuItem(details.data),
    );
  }
}

// ---------------------------------------------------------------
// 이 밑으로는 기존과 동일한 _TrayOverlay, _MenuGrid 위젯 코드입니다.
// ---------------------------------------------------------------

class _TrayOverlay extends StatelessWidget {
  final Map<String, List<String>> placedMenus;
  final void Function(String slotId, String menuItem) onAccept;

  const _TrayOverlay({required this.placedMenus, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    const rotAspect = kUnitH / kUnitW;
    final screen = MediaQuery.of(context).size;
    final targetH = screen.height * 0.90;
    const hMargin = 16.0;
    final maxW = screen.width - hMargin * 2;
    double h = targetH;
    double w = h * rotAspect;
    if (w > maxW) {
      w = maxW;
      h = w / rotAspect;
    }
    final innerW = h;
    final innerH = w;
    final sx = innerW / kUnitW;
    final sy = innerH / kUnitH;

    Widget box({
      required String id,
      required double ux,
      required double uy,
      required double uw,
      required double uh,
    }) {
      final menuItemsInSlot = placedMenus[id] ?? [];

      return Positioned(
        left: ux * sx,
        top: uy * sy,
        width: uw * sx,
        height: uh * sy,
        child: DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            final isHovering = candidateData.isNotEmpty;
            return Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isHovering ? Colors.yellowAccent : Colors.green,
                  width: isHovering ? 4 : 2,
                ),
                color: isHovering
                    ? Colors.green.withOpacity(0.4)
                    : Colors.green.withOpacity(0.1),
              ),
              child: menuItemsInSlot.isEmpty
                  ? Text(
                      id,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  : ListView(
                      children: menuItemsInSlot.map((menuItem) {
                        final child = Text(
                          menuItem,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        );
                        return Draggable<PlacedMenu>(
                          data: PlacedMenu(id, menuItem),
                          feedback:
                              Material(color: Colors.transparent, child: child),
                          childWhenDragging:
                              Opacity(opacity: 0.4, child: child),
                          child: child,
                        );
                      }).toList(),
                    ),
            );
          },
          onWillAcceptWithDetails: (details) => true,
          onAcceptWithDetails: (details) => onAccept(id, details.data),
        ),
      );
    }

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: w,
        height: h,
        child: RotatedBox(
          quarterTurns: 1,
          child: SizedBox(
            width: innerW,
            height: innerH,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 4),
                      borderRadius: BorderRadius.circular(innerH * 0.02),
                    ),
                  ),
                ),
                box(id: '반찬1', ux: 0.0, uy: 0.0, uw: kTopW1, uh: kTopRowH),
                box(id: '반찬2', ux: _x2, uy: 0.0, uw: kTopW2, uh: kTopRowH),
                box(id: '반찬3', ux: _x3, uy: 0.0, uw: kTopW3, uh: kTopRowH),
                box(id: '반찬4', ux: _x4, uy: 0.0, uw: kTopW4, uh: kTopRowH),
                box(
                    id: '밥',
                    ux: 0.0,
                    uy: kTopRowH,
                    uw: kBotW1,
                    uh: kBottomRowH),
                box(
                    id: '국',
                    ux: _xBot2,
                    uy: kTopRowH,
                    uw: kBotW2,
                    uh: kBottomRowH),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuGrid extends StatelessWidget {
  final List<String> items;
  const _MenuGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          '메뉴 정보가 없거나 모두 배치했습니다.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 48,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final text = items[i];
        final childWidget = Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        );

        return Draggable<String>(
          data: text,
          feedback: Material(
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.4),
              child: childWidget,
            ),
          ),
          childWhenDragging: Opacity(opacity: 0.4, child: childWidget),
          child: childWidget,
        );
      },
    );
  }
}
