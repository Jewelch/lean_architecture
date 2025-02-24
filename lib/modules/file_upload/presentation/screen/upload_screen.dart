import 'package:flutter/services.dart';

import '../../../../base/screens/exports.dart';
import '../../binding/upload_screen_deps.dart';
import '../../domain/entities/upload_info.dart';
import '../bloc/events/upload_events.dart';
import '../bloc/states/upload_states.dart';
import '../bloc/upload_bloc.dart';

part 'widgets/upload_completed.dart';
part 'widgets/upload_failed.dart';
part 'widgets/upload_message.dart';
part 'widgets/upload_progressing.dart';

final class UploadScreen extends BlocProviderWidget<UploadBloc> {
  UploadScreen({super.key})
      : super(
          dependencies: UploadScreenDependencies(),
        );

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.upload,
        title: 'File Upload',
        body: BlocBuilder<UploadBloc, UploadStates>(
          builder: (context, state) => switch (state) {
            UploadProgressing() => _UploadProgressing<UploadBloc>(progress: state.progress),
            UploadFailed() => _UploadFailed<UploadBloc>(message: state.message),
            UploadCompleted() => _UploadCompleted(info: state.uploadInfo),
            Idle() => const _UploadMessage(
                message: 'Click the button below to select a file source\nand start uploading',
              ),
          }
              .center(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<UploadBloc, UploadStates>(
          builder: (context, state) => state is! UploadProgressing
              ? FloatingActionButton.extended(
                  onPressed: () => bloc.add(const ShowPickerOptions()),
                  label: const Text('Select picking source'),
                  icon: const Icon(Icons.upload),
                )
              : const SizedBox(),
        ),
      );
}
