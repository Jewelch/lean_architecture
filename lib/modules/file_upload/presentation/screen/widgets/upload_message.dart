part of '../upload_screen.dart';

class _UploadMessage extends StatelessWidget {
  const _UploadMessage(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Icon(Icons.upload_file, size: 64, color: Colors.grey),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      );
}
