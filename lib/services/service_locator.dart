import 'package:transelate_app/repos/transilation_repo_imp.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../services/api_service.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  getIt.registerSingleton<TranslationRepoImpl>(TranslationRepoImpl(apiService:getIt.get<ApiService>(),));

}

