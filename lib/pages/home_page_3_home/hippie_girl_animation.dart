import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HippieGirlAnimation extends StatelessWidget {
  final int stepCount;

  const HippieGirlAnimation({super.key, required this.stepCount});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(1, -1),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 10, 0),
        child: SizedBox(
          width: 234.99,
          height: MediaQuery.of(context).size.height * 0.45,
          child: _AnimationSwitcher(stepCount: stepCount),
        ),
      ),
    );
  }
}

class _AnimationSwitcher extends StatefulWidget {
  final int stepCount;

  const _AnimationSwitcher({required this.stepCount});

  @override
  State<_AnimationSwitcher> createState() => _AnimationSwitcherState();
}

class _AnimationSwitcherState extends State<_AnimationSwitcher> {
  SMIInput<bool>? _isWalking;
  SMIInput<bool>? _isWhistling;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);
      _isWhistling = controller.findInput<bool>('isWhistling');
      _isWalking = controller.findInput<bool>('isWalking');

      // 최초 상태만 세팅, 이후 변경하지 않음
      if (widget.stepCount == 0) {
        _isWhistling?.value = true;
        _isWalking?.value = false;
      } else {
        _isWhistling?.value = false;
        _isWalking?.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rive_animations/hippie_girl_walkcycle.riv',
      artboard: 'Artboard',
      fit: BoxFit.cover,
      onInit: _onRiveInit,
    );
  }

  @override
  void didUpdateWidget(covariant _AnimationSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.stepCount != oldWidget.stepCount) {
      if (widget.stepCount == 0) {
        _isWhistling?.value = true;
        _isWalking?.value = false;
      } else {
        _isWhistling?.value = false;
        _isWalking?.value = true;
      }
    }
  }
}
