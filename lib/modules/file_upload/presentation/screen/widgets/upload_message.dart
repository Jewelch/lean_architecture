part of '../upload_screen.dart';

class _UploadMessage extends StatelessWidget {
  const _UploadMessage({
    required this.message,
    this.icon = Icons.upload_file,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
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
