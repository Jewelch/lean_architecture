import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:lean_architecture/api/data_source.dart';

import '../../../../base/screens/exports.dart';
import '../../binding/download_screen_deps.dart';
import '../../domain/entities/download_info.dart';
import '../../domain/enums/pdf_size.dart';
import '../bloc/download_bloc.dart';
import '../bloc/events/download_events.dart';
import '../bloc/states/download_states.dart';

part 'widgets/download_completed.dart';
part 'widgets/download_failed.dart';
part 'widgets/download_progressing.dart';
part 'widgets/size_dropdown.dart';

final class DownloadScreen extends BlocProviderWidget<DownloadBloc> {
  DownloadScreen({super.key})
      : super(
          dependencies: DownloadScreenDependencies(),
        );

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.download,
        title: 'File Download',
        body: BlocBuilder<DownloadBloc, DownloadStates>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is! DownloadProgressing) _SizeDropDown<DownloadBloc>(state),
              Center(
                child: switch (state) {
                  DownloadProgressing() => _DownloadProgressing<DownloadBloc>(progress: state.progress),
                  DownloadFailed() => _DownloadFailed<DownloadBloc>(message: state.message),
                  DownloadCompleted() => _DownloadCompleted(info: state.downloadInfo),
                  _ => const SizedBox(),
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<DownloadBloc, DownloadStates>(
          builder: (context, state) => state is! DownloadProgressing
              ? FloatingActionButton.extended(
                  onPressed: () => bloc.add(const StartDownload()),
                  label: Text('Download ${bloc.selectedSize.label} File'),
                  icon: const Icon(Icons.download),
                )
              : const SizedBox(),
        ),
      );
}
