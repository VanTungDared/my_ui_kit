import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

class Log {
  static final logger = Logger(printer: PrettyPrinter());
  static final loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

  static showDefaultDialogSimple({String title = "", String middleText = ""}) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar(); // Đóng snackbar hiện tại trước
    }
    Get.defaultDialog(title: title, middleText: middleText);
  }

  showSnackbarSimple(String title, String message) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar(); // Đóng snackbar hiện tại trước
    }
    Get.showSnackbar(GetSnackBar(title: title, message: message));
  }

  /// ✅ Hiển thị snackbar trạng thái (thành công/thất bại)
  static showSnackbarStatus({
    required String message,
    required bool isSuccess,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar(); // Đóng snackbar hiện tại trước
    }
    Get.snackbar(
      isSuccess ? "Thành công" : "Thất bại",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      icon: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        color: isSuccess ? Colors.green : Colors.red,
      ),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeInOut, // Fade in/out
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      isDismissible: false,
      borderColor: Colors.grey.shade300,
      borderWidth: 1.0,
      // 👇 Ngăn nhảy/sliding bất thường khi dùng SnackbarPosition.TOP
      overlayBlur: 0, // tùy chọn nếu bạn muốn mờ nền
    );
  }

  static void showTopMessage(String message, bool isSuccess) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar(); // Đóng snackbar hiện tại trước
    }

    Get.rawSnackbar(
      messageText: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.cancel,
              color: isSuccess ? Colors.green : Colors.red,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      borderRadius: 0.0,
      isDismissible: true,
      animationDuration: Duration.zero,
      duration: const Duration(seconds: 2),
    );
  }

  static void showTopMessageWithAction({
    required String message,
    required bool isSuccess,
    required String actionLabel,
    required VoidCallback onActionPressed,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.rawSnackbar(
      messageText: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.cancel,
              color: isSuccess ? Colors.green : Colors.red,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.black)),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: () {
                Get.closeCurrentSnackbar(); // đóng snackbar trước khi chuyển tiếp
                onActionPressed(); // gọi hành động chuyển tiếp
              },
              child: Text(
                actionLabel,
                style: TextStyle(
                  color: isSuccess ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      borderRadius: 0.0,
      isDismissible: true,
      animationDuration: Duration.zero,
      duration: const Duration(seconds: 4), // thời gian dài hơn
    );
  }

  static void showConfirmDialog({
    required String message,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tiêu đề
              const Text(
                "Thông báo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 12),

              // Nội dung
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 24),

              // Nút
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (Get.isDialogOpen ?? false) {
                          Get.close(1); // Đóng dialog mà không ảnh hưởng stack
                        }
                        onCancel?.call();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.orange,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Huỷ",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (Get.isDialogOpen ?? false) {
                          Get.close(1);
                        }
                        onConfirm?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 2,
                      ),
                      child: const Text(
                        "Xác Nhận",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showDualConfirmDialog({
    required String message,
    required String leftText,
    required String rightText,
    VoidCallback? onLeftPressed,
    VoidCallback? onRightPressed,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tiêu đề
              const Text(
                "Thông báo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 12),

              // Nội dung
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 24),

              // Nút
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (Get.isDialogOpen ?? false) {
                          Get.close(1);
                        }
                        onLeftPressed?.call();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.orange,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        leftText,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (Get.isDialogOpen ?? false) {
                          Get.close(1);
                        }
                        onRightPressed?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 2,
                      ),
                      child: Text(
                        rightText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static showLoggerMapList(data) {
    loggerNoStack.t(data);
  }

  static showLoggerInfo(data) {
    loggerNoStack.i(data);
  }

  static showLoggerD(data) {
    logger.d(data);
  }
}
