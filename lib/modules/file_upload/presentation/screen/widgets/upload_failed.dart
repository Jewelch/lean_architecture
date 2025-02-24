part of '../upload_screen.dart';

class _UploadFailed<B extends UploadBloc> extends StatelessWidget {
  const _UploadFailed({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 64),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ).overallPadding(),
          const SizedBox(height: 15),
          FloatingActionButton.extended(
            onPressed: () => BlocProvider.of<B>(context).add(const CancelUpload()),
            backgroundColor: AppColors.warning,
            label: const Text('Retry'),
            icon: const Icon(Icons.refresh),
          ),
        ],
      );
}
