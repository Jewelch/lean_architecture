import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../base/screens/exports.dart';
import '../../binding/upload_screen_deps.dart';
import '../../domain/entities/upload_info.dart';
import '../../domain/enums/file_type.dart';
import '../bloc/events/upload_events.dart';
import '../bloc/states/upload_states.dart';
import '../bloc/upload_bloc.dart';

part 'widgets/upload_completed.dart';
part 'widgets/upload_failed.dart';
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
            _ => const SizedBox(),
          }
              .center(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<UploadBloc, UploadStates>(
          builder: (context, state) => state is! UploadProgressing
              ? FloatingActionButton.extended(
                  onPressed: () => _showPickerOptions(context),
                  label: Text('Select picking source'),
                  icon: const Icon(Icons.upload),
                )
              : const SizedBox(),
        ),
      );

  void _showPickerOptions(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Choose Upload Source'),
        message: const Text('Select where to pick the file from'),
        actions: PickerSource.values
            .map(
              (source) => CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  bloc.add(PickAndUploadFile(source));
                },
                child: Text(source.label),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
