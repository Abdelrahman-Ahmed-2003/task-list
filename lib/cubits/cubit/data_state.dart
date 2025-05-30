part of 'data_cubit.dart';

abstract class DataState {}

final class DataInitial extends DataState {}

class DataUpdated extends DataState {}

class DataLoading extends DataState {}

class DataError extends DataState {
  final String message;
  DataError(this.message);
}

class DataSuccess extends DataState {
  final List<Task> tasks;
  DataSuccess(this.tasks);
}

class DataLoaded extends DataState {
  DataLoaded();
}


class TaskEdit extends DataState {
  TaskEdit();
}

class DataAdded extends DataState {
  DataAdded();
}


class ChangeSelCategory extends DataState {
  ChangeSelCategory();
}


class DataRemove extends DataState {
  DataRemove();
}

class ChangeSelDate extends DataState {
  ChangeSelDate();
}

class DataUpdate extends DataState {
  DataUpdate();
}

class DataTransfer extends DataState{
  DataTransfer();
}
