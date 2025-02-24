part of '../upload_screen.dart';

class _UploadCompleted extends StatelessWidget {
  const _UploadCompleted({required this.info});

  final UploadInfo info;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 64),
          Text(
            'Uploaded: ${info.filename}',
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Flexible(
                child: SelectableText(
                  info.location,
                  style: AppStyles.indication.copyWith(color: Colors.grey),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 25),
                onPressed: () => Clipboard.setData(ClipboardData(text: info.location)),
                tooltip: 'Copy URL',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ],
          ).overallPadding(30),
        ],
      );
}
