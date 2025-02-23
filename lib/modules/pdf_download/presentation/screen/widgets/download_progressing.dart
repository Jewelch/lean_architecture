part of '../download_screen.dart';

class _DownloadProgressing extends StatelessWidget {
  const _DownloadProgressing({
    required this.progress,
    required this.onCancel,
  });

  final OperationProgress progress;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.square(
                dimension: 70,
                child: CircularProgressIndicator(
                  value: progress.percentage,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              Text(
                progress.formattedPercentage,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            progress.formattedProgress,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          if (onCancel != null)
            FloatingActionButton.extended(
              onPressed: onCancel,
              backgroundColor: AppColors.error,
              label: const Text('Cancel Download'),
              icon: const Icon(Icons.cancel_outlined),
            ),
        ],
      );
}
