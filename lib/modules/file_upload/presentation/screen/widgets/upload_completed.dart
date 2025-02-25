part of '../upload_screen.dart';

class _UploadCompleted extends StatelessWidget {
  const _UploadCompleted({required this.info});

  final UploadInfo info;

  Future<void> _launchUrl() async {
    final url = Uri.parse(info.location);
    if (!(await canLaunchUrl(url))) {
      throw Exception('Could not launch $url');
    }
    await launchUrl(url);
  }

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
                child: GestureDetector(
                  onTap: _launchUrl,
                  child: Text(
                    info.location,
                    style: AppStyles.indication.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 25),
                onPressed: () => Clipboard.setData(ClipboardData(text: info.location)),
                tooltip: 'Copy URL',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
              IconButton(
                icon: const Icon(Icons.open_in_browser, size: 25),
                onPressed: _launchUrl,
                tooltip: 'Open in browser',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ],
          ).overallPadding(30),
        ],
      );
}
