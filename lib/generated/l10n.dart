// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Task List`
  String get appTitle {
    return Intl.message('Task List', name: 'appTitle', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Task`
  String get task {
    return Intl.message('Task', name: 'task', desc: '', args: []);
  }

  /// `categories`
  String get categories {
    return Intl.message('categories', name: 'categories', desc: '', args: []);
  }

  /// `calender`
  String get calender {
    return Intl.message('calender', name: 'calender', desc: '', args: []);
  }

  /// `Setting`
  String get setting {
    return Intl.message('Setting', name: 'setting', desc: '', args: []);
  }

  /// `What you need to do?`
  String get TaskLabel {
    return Intl.message(
      'What you need to do?',
      name: 'TaskLabel',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get DescLabel {
    return Intl.message('Description', name: 'DescLabel', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Add Task`
  String get addTask {
    return Intl.message('Add Task', name: 'addTask', desc: '', args: []);
  }

  /// `Edit Task`
  String get editTask {
    return Intl.message('Edit Task', name: 'editTask', desc: '', args: []);
  }

  /// `Update Categories`
  String get updateCategories {
    return Intl.message(
      'Update Categories',
      name: 'updateCategories',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Add new category`
  String get addCategoryHint {
    return Intl.message(
      'Add new category',
      name: 'addCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `The selected day is `
  String get selectedDay {
    return Intl.message(
      'The selected day is ',
      name: 'selectedDay',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message('Mode', name: 'mode', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Tasks not compeleted`
  String get uncompeletedTask {
    return Intl.message(
      'Tasks not compeleted',
      name: 'uncompeletedTask',
      desc: '',
      args: [],
    );
  }

  /// `Delete it`
  String get delete {
    return Intl.message('Delete it', name: 'delete', desc: '', args: []);
  }

  /// `Add it tomorrow`
  String get addTomorrow {
    return Intl.message(
      'Add it tomorrow',
      name: 'addTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `No Tasks`
  String get noTasks {
    return Intl.message('No Tasks', name: 'noTasks', desc: '', args: []);
  }

  /// `There is a task in the same time`
  String get foundTaskInSameTime {
    return Intl.message(
      'There is a task in the same time',
      name: 'foundTaskInSameTime',
      desc: '',
      args: [],
    );
  }

  /// `Task added successfully`
  String get taskAddedSuccessfully {
    return Intl.message(
      'Task added successfully',
      name: 'taskAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Task edited successfully`
  String get taskEditedSuccessfully {
    return Intl.message(
      'Task edited successfully',
      name: 'taskEditedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please select category`
  String get selectCategory {
    return Intl.message(
      'Please select category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Please select vaild time`
  String get selectTime {
    return Intl.message(
      'Please select vaild time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `No Categories selected`
  String get noSelectCategory {
    return Intl.message(
      'No Categories selected',
      name: 'noSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Categories updated successfully!`
  String get updateCategorySuccessfullu {
    return Intl.message(
      'Categories updated successfully!',
      name: 'updateCategorySuccessfullu',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message('Languages', name: 'languages', desc: '', args: []);
  }

  /// `All Tasks in`
  String get allTasksINn {
    return Intl.message(
      'All Tasks in',
      name: 'allTasksINn',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `work`
  String get work {
    return Intl.message('work', name: 'work', desc: '', args: []);
  }

  /// `personal`
  String get personal {
    return Intl.message('personal', name: 'personal', desc: '', args: []);
  }

  /// `shopping`
  String get shopping {
    return Intl.message('shopping', name: 'shopping', desc: '', args: []);
  }

  /// `health`
  String get health {
    return Intl.message('health', name: 'health', desc: '', args: []);
  }

  /// `home`
  String get homee {
    return Intl.message('home', name: 'homee', desc: '', args: []);
  }

  /// `New Category`
  String get newCategory {
    return Intl.message(
      'New Category',
      name: 'newCategory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure`
  String get areYouSure {
    return Intl.message('Are you sure', name: 'areYouSure', desc: '', args: []);
  }

  /// `This is category has tasks remove all tasks under it?`
  String get thisIsCategoryHasTasksRemoveAllTasksUnderIt {
    return Intl.message(
      'This is category has tasks remove all tasks under it?',
      name: 'thisIsCategoryHasTasksRemoveAllTasksUnderIt',
      desc: '',
      args: [],
    );
  }

  /// `Yes Delete`
  String get yesDelete {
    return Intl.message('Yes Delete', name: 'yesDelete', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete Task`
  String get deleteTask {
    return Intl.message('Delete Task', name: 'deleteTask', desc: '', args: []);
  }

  /// `Are you sure you want to delete this task?`
  String get AreYouSureYouWantToDeleteThisTask {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'AreYouSureYouWantToDeleteThisTask',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
