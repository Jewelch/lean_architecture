part of '../download_screen.dart';

class _DownloadCompleted extends StatelessWidget {
  const _DownloadCompleted({required this.info});

  final DownloadInfo info;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Downloaded: ${info.fileName}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Size: ${info.formattedSize}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SelectableText(
                  info.path,
                  style: AppStyles.indication.copyWith(color: Colors.grey),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.copy, size: 25),
                onPressed: () => Clipboard.setData(ClipboardData(text: info.path)),
                tooltip: 'Copy path',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ],
          ).overallPadding(30),
        ],
      );
}
