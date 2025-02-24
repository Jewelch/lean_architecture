import 'package:flutter/services.dart';

import '../../../../base/screens/exports.dart';
import '../../binding/upload_screen_deps.dart';
import '../../domain/entities/upload_info.dart';
import '../../domain/enums/file_type.dart';
import '../bloc/events/upload_events.dart';
import '../bloc/states/upload_states.dart';
import '../bloc/upload_bloc.dart';

part 'widgets/type_dropdown.dart';
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
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is! UploadProgressing) _TypeDropDown<UploadBloc>(state),
              switch (state) {
                UploadProgressing() => _UploadProgressing<UploadBloc>(progress: state.progress),
                UploadFailed() => _UploadFailed<UploadBloc>(message: state.message),
                UploadCompleted() => _UploadCompleted(info: state.uploadInfo),
                _ => const SizedBox(),
              },
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<UploadBloc, UploadStates>(
          builder: (context, state) => state is! UploadProgressing
              ? FloatingActionButton.extended(
                  onPressed: () => bloc.add(const PickAndUploadFile()),
                  label: Text('Upload ${bloc.selectedType.label} File'),
                  icon: const Icon(Icons.upload),
                )
              : const SizedBox(),
        ),
      );
}
