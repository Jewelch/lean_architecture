part of '../download_screen.dart';

class _DownloadFailed<B extends Bloc> extends StatelessWidget {
  const _DownloadFailed({required this.message});

  final String message;

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
          FloatingActionButton.extended(
            onPressed: () => BlocProvider.of<B>(context).add(const StartDownload()),
            backgroundColor: AppColors.warning,
            label: const Text('Retry'),
            icon: const Icon(Icons.refresh),
          ),
        ],
      );
}
