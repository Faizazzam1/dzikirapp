import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(anonKey: dotenv.get('KEY'), url: dotenv.get('URL'));

  runApp(
    GetMaterialApp(
      title: "Dzikir app",
      initialRoute: Supabase.instance.client.auth.currentSession == null
          ? Routes.LOGIN
          : Routes.HOME,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    ),
  );
}
