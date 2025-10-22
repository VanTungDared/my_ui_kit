import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_ui_kit/utils/log_utils.dart';

class TriangleLoading extends StatefulWidget {
  const TriangleLoading({super.key});

  @override
  State<TriangleLoading> createState() => _TriangleLoadingState();
}

class _TriangleLoadingState extends State<TriangleLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: 50,
        height: 50,
        child: CustomPaint(painter: _TrianglePainter()),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    // Tính 3 điểm của tam giác đều
    final double r = size.width / 2.2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final List<Offset> points = List.generate(
      3,
      (i) => Offset(
        center.dx + r * cos(2 * pi * i / 3 - pi / 2),
        center.dy + r * sin(2 * pi * i / 3 - pi / 2),
      ),
    );

    for (final p in points) {
      canvas.drawCircle(p, 6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Loadding {
  static bool isLoadding = false;
  static Timer? _timer;

  static loaddingDefalult(
    bool isLoad, {
    String status = "Onpos đang xử lý...chờ xíu nhé",
    bool onlySpinner = false,
  }) {
    if (isLoad && !isLoadding) {
      isLoadding = true;

      // Hiển thị EasyLoading
      if (onlySpinner) {
        EasyLoading.instance.indicatorWidget = const TriangleLoading();
        EasyLoading.show();
      } else {
        EasyLoading.instance.indicatorWidget = null; // dùng spinner mặc định
        EasyLoading.show(status: status);
      }

      // Set timeout 7s -> auto close nếu chưa tắt
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 7), () {
        if (isLoadding) {
          isLoadding = false;
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
          Log.showTopMessage("Hệ thống bận, hãy thử lại", false);
        }
      });
    } else if (!isLoad) {
      // Nếu tắt thủ công
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
      isLoadding = false;
      _timer?.cancel();
    }
  }

  static Future<T?> runWithLoading<T>(
    Future<T> Function() task, {
    String statusLoad = "Onpos đang xử lý...chờ xíu nhé",
  }) async {
    loaddingDefalult(true, onlySpinner: true);
    try {
      final result = await task();
      return result;
    } catch (e, s) {
      Log.showLoggerD("Error in runWithLoading: $e\n$s");
      return null;
    } finally {
      loaddingDefalult(false);
    }
  }
}
