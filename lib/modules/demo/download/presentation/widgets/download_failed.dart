part of '../download_screen.dart';

class _DownloadFailed extends StatelessWidget {
  const _DownloadFailed({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ).overallPadding(),
          const SizedBox(height: 15),
          if (onRetry != null)
            FloatingActionButton.extended(
              onPressed: onRetry,
              backgroundColor: AppColors.warning,
              label: const Text('Retry'),
              icon: const Icon(Icons.refresh),
            ),
        ],
      );
}
