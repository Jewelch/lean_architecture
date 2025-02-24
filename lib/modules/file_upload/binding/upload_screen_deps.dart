import '../../../app_injections.dart';
import '../../../base/dependencies/dependencies.dart';
import '../data/definition/upload_datasource.dart';
import '../domain/usecases/upload_file_uc.dart';
import '../presentation/bloc/upload_bloc.dart';

class UploadScreenDependencies implements Dependencies {
  @override
  void inject() {
    // Bloc
    AppInjections.di.registerFactory(() => UploadBloc(get()));

    // Use cases
    AppInjections.di.registerLazySingleton(() => UploadFileUC(get()));

    // Data sources
    AppInjections.di.registerLazySingleton<UploadDataSource>(
      () => UploadDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );
  }
}
