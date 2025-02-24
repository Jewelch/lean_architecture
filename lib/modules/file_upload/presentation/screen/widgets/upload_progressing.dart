part of '../upload_screen.dart';

class _UploadProgressing<B extends UploadBloc> extends StatelessWidget {
  const _UploadProgressing({required this.progress});

  final (int, int) progress;

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
                  value: progress.$1 / progress.$2,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              Text(
                '${((progress.$1 / progress.$2) * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${(progress.$1 / 1024 / 1024).toStringAsFixed(1)} MB / '
            '${(progress.$2 / 1024 / 1024).toStringAsFixed(1)} MB',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          FloatingActionButton.extended(
            onPressed: () => BlocProvider.of<B>(context).add(const CancelUpload()),
            backgroundColor: AppColors.error,
            label: const Text('Cancel Upload'),
            icon: const Icon(Icons.cancel_outlined),
          ),
        ],
      );
}
