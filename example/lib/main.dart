import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ui_kit/my_ui_kit.dart'; // ✅ import UI kit bạn export

void main() {
  runApp(const MyUiKitDemoApp());
}

class MyUiKitDemoApp extends StatelessWidget {
  const MyUiKitDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Kích thước gốc thiết kế
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My UI Kit Demo',
          theme: ThemeData(primarySwatch: Colors.orange),
          home: const UiKitPreviewPage(),
        );
      },
    );
  }
}

class UiKitPreviewPage extends StatefulWidget {
  const UiKitPreviewPage({super.key});

  @override
  State<UiKitPreviewPage> createState() => _UiKitPreviewPageState();
}

class _UiKitPreviewPageState extends State<UiKitPreviewPage> {
  final TextEditingController nameCtrl = TextEditingController();
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My UI Kit Preview")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledTextField(
              label: "Tên người dùng",
              hintText: "Nhập tên...",
              controller: nameCtrl,
              isRequired: true,
            ),
            SizedBox(height: 16.h),

            SizedBox(height: 24.h),

            PrimaryButton(
              text: "Xác nhận",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đã nhấn nút xác nhận")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
