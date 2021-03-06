// ignore_for_file: import_of_legacy_library_into_null_safe

import "package:get_it/get_it.dart";
import "./services/rest_service.dart";
import "./services/task_service.dart";
import "./services/todo_service.dart";

GetIt service = GetIt.instance;


void init(){
  service.registerLazySingleton(() => TodoDataService());
  service.registerLazySingleton(() => TaskDataService());
  service.registerLazySingleton(() => RestService());

}




