part of 'cubit_category.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryUpdated extends CategoryState {}

class CategorySaved extends CategoryState {}

class CategoryLoaded extends CategoryState {
  
  CategoryLoaded();
}

class CategoryAdded extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}