import '../../../../../base/bloc/base_bloc.dart';
import '../../../../../base/screens/exports.dart';
import '../../../_classes/presentation/bloc/product_events.dart';

class ClearButton<B extends BaseBloc> extends BlocProviderWidget<B> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
        child: const Text("Clear"),
        onPressed: () => BlocProvider.of<B>(context).add(ClearProduct()),
      ).resize(width: 100, height: 45);
}
