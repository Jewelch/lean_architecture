import '../bloc/base_bloc.dart';
import '../dependencies/dependencies.dart';
import 'exports.dart';

abstract class FullBlocProvidingWidget<B extends BaseBloc> extends StatefulWidget {
  FullBlocProvidingWidget({super.key, this.dependencies});

  final Dependencies? dependencies;

  B get bloc => _state!.bloc;

  _State<FullBlocProvidingWidget, B>? _state;

  @override
  createState() => _State<FullBlocProvidingWidget, B>();

  @protected
  Widget build(BuildContext context);
}

class _State<T extends FullBlocProvidingWidget, B extends BaseBloc> extends State<T> {
  late B bloc = get<B>();

  @override
  @protected
  void initState() {
    super.initState();
    widget._state = this;
    widget.dependencies?.inject();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget._state = this;
  }

  @override
  @protected
  void dispose() {
    bloc.onClose();
    widget._state = null;
    super.dispose();
  }

  @override
  @protected
  Widget build(BuildContext context) => BlocProvider<B>(
        create: (_) => bloc,
        child: widget.build(context),
      );
}
