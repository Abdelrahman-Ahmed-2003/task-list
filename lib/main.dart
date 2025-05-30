import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:task_list/core/data/global_data.dart';
import 'package:task_list/core/notification/localNorification.dart';
import 'package:task_list/core/theme/theme.dart';
import 'package:task_list/core/utils/utils.dart';
import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/cubits/cubit/setting_cubit.dart';
import 'package:task_list/feature/pageView/views/homepage.dart';
import 'package:task_list/feature/splashScreen/views/splashPage.dart';
import 'package:task_list/core/buildTask/task.dart';
import 'package:task_list/generated/l10n.dart';
import 'package:task_list/pages/firstOpenPage.dart';
import 'package:permission_handler/permission_handler.dart';

// solve
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  //await Hive.deleteBoxFromDisk('task_box');
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>("task_box");
  await Hive.openBox("category_box");
  if (await Permission.notification.isDenied ||
      await Permission.notification.isPermanentlyDenied) {
    await Permission.notification.request();
  }
  await LocalNotification.init();
  await initTheme();

  //Bloc.observer = MyBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<DataCubit>(
        create: (context) => DataCubit(),
      ),
      BlocProvider<CategoryCubit>(
        create: (context) => CategoryCubit(),
      ),

      BlocProvider<SettingCubit>(
        create: (context) => SettingCubit(),
      ),

      // Add more BlocProviders here as needed
    ],
    child: const MyWidget(),
  ));
}

Future<void> initTheme() async {
  var box = await Hive.openBox('settings');
  String? theme = await box.get('theme');
  if (theme != null) {
    themeMode = getTheme(theme);
  } else {
    themeMode = ThemeMode.light;
    await box.put('theme', 'light');
  }
  var temp = await box.get('language');
  if (temp == null) {
    lang = 'en';
    await box.put('language', 'en');
  } else {
    lang = temp;
  }

  // temp = await box.get('notification');
  // if (temp == null) {
  //   notification = 'on';
  //   await box.put('notification', 'on');
  // } else {
  //   notification = temp;
  // }

  temp = await box.get('taskNotCompeleted');
  if (temp == null) {
    taskNotCompeleted = 'delete';
    await box.put('taskNotCompeleted', 'delete');
  } else {
    taskNotCompeleted = 'add';
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

final navKey = new GlobalKey<NavigatorState>();

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {

    context.watch<SettingCubit>();


    listenToNotifications(context);
    return MaterialApp(
      navigatorKey: navKey,
      locale: Locale(lang),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: '/',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/first': (context) => FirstOpen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
