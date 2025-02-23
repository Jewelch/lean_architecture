import '../../../app_injections.dart';
import '../../../base/dependencies/dependencies.dart';
import 'data/datasource/download_datasource_impl.dart';
import 'domain/usecases/download_file_uc.dart';
import 'presentation/bloc/download_bloc.dart';

class DownloadScreenDependencies implements Dependencies {
  @override
  void inject() {
    // Bloc
    AppInjections.di.registerFactory(() => DownloadBloc(get()));

    // Use cases
    AppInjections.di.registerLazySingleton(() => DownloadFileUC(get()));

    // Data sources
    AppInjections.di.registerLazySingleton<DownloadDataSource>(
      () => DownloadDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );
  }
}
