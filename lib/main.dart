import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/navigation/app_routes.dart';
import 'package:sunco_physics/presentation/screen/lesson/online_lesson/add_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/work_lesson.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });


  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
       initialRoute: AppRoutes.splash,
       onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
     // home: const AddLessonPage(),
    );
  }
}
