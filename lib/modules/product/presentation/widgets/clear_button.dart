import '../../../../base/bloc/base_bloc.dart';
import '../../../../base/screens/exports.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_events.dart';

//! RECOMMENDED APPROACH
/// **Strategy 1: Using `BlocProviderWidget` for Dependency Injection**
/// This approach leverages `BlocProviderWidget<B>` to inject the bloc automatically
/// into the widget, making it reusable across different `BaseBloc` types.
/// The button dispatches events dynamically without needing the bloc to be explicitly passed.
class ClearButton<B extends BaseBloc> extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ElevatedButton(
        child: const Text("Clear"),
        onPressed: () => BlocProvider.of<B>(context).add(ClearProduct()),
      ).resize(width: 100, height: 35);
}

//? ALTERNATIVE APPROACH
/// **Strategy 2: Passing the Bloc Directly to the Button**
/// In this strategy, the bloc is explicitly passed to the button, which
/// directly interacts with it. This approach is simpler but less flexible
/// and reusable as it is tightly coupled to a specific bloc type.
class ClearButton2 extends StatelessWidget {
  const ClearButton2(this.bloc);

  final ProductDetailsBloc bloc;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        child: const Text("Clear"),
        onPressed: () => bloc.add(ClearProduct()),
      ).resize(width: 100, height: 35);
}
