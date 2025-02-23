import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import '../../../../api/data_source.dart' show DownloadProgress;
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

final class DownloadScreen extends BlocProviderWidget<DownloadBloc> {
  DownloadScreen({super.key})
      : super(
          dependencies: DownloadScreenDependencies(),
        );

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.pdf,
        title: 'File Download',
        body: BlocBuilder<DownloadBloc, DownloadStates>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is! DownloadProgressing) ...[
                DropdownButton<PdfSize>(
                  dropdownColor: Colors.grey.shade300,
                  isDense: true,
                  menuMaxHeight: 300,
                  value: state is DownloadSizeSelected ? state.selectedSize : bloc.selectedSize,
                  items: PdfSize.values
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text('Download ${size.label} PDF'),
                          ))
                      .toList(),
                  onChanged: (size) {
                    if (size != null) bloc.add(UpdateSelectedSize(size));
                  },
                ).overallPadding(20),
                const SizedBox(height: 20),
              ],
              Center(
                child: switch (state) {
                  DownloadInitial() => const SizedBox(),
                  DownloadSizeSelected() => const SizedBox(),
                  DownloadProgressing(progress: final progress) => _DownloadProgressing(
                      progress: progress,
                      onCancel: () => bloc.add(const CancelDownload()),
                    ),
                  DownloadFailed(message: final message) => _DownloadFailed(
                      message: message,
                      onRetry: () => bloc.add(const StartDownload()),
                    ),
                  DownloadCompleted(downloadInfo: final info) => _DownloadCompleted(info: info),
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
