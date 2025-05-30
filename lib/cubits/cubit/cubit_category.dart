import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());


  Box box = Hive.box("category_box");

  List<String> categories = [];   // User-selected categories

  Future<void> initialize() async {
    final storedCategories = await box.get("category");
      categories = List<String>.from(storedCategories ?? []);
    emit(CategoryLoaded());
  }

  void updateCategories(List<String> selected) {
    categories = selected;
    // emit(CategoryUpdated());
  }

  Future<void> saveChanges() async {
    await box.put('category', categories);
    emit(CategorySaved());
  }
}
