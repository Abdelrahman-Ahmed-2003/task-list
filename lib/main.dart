import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:task_list/core/data/global_data.dart';
import 'package:task_list/core/init/app_initializer.dart';
import 'package:task_list/core/notification/localNorification.dart';
import 'package:task_list/core/theme/theme.dart';
import 'package:task_list/core/utils/utils.dart';
import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/cubits/cubit/setting_cubit.dart';
import 'package:task_list/feature/pageView/views/homepage.dart';
import 'package:task_list/core/buildTask/task.dart';
import 'package:task_list/generated/l10n.dart';
import 'package:task_list/pages/firstOpenPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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

class _MyWidgetState extends State<MyWidget> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_initialized) {
        _initialized = true;
        String route = await AppInitializer.initialize(context);
        FlutterNativeSplash.remove();
        if (mounted) {
          navKey.currentState?.pushReplacementNamed(route);
        }
      }
    });
  }

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
      initialRoute: '/home',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routes: {
        '/home': (context) => const HomePage(),
        '/first': (context) => FirstOpen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
