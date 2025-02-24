import 'package:flutter/cupertino.dart';

import '../../../domain/enums/file_type.dart';

class SourcePickerSheet extends StatelessWidget {
  const SourcePickerSheet({
    super.key,
    required this.onSourceSelected,
  });

  final void Function(PickerSource source) onSourceSelected;

  static Future<void> show(BuildContext context, void Function(PickerSource source) onSourceSelected) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => SourcePickerSheet(onSourceSelected: onSourceSelected),
    );
  }

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        title: const Text('Choose Upload Source'),
        message: const Text('Select where to pick the file from'),
        actions: PickerSource.values
            .map(
              (source) => CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  onSourceSelected(source);
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
      );
}
