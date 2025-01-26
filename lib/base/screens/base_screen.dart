import 'package:lean_architecture/modules/product_details/dependencies/product_screen_deps.dart';

import '../bloc/base_bloc.dart';
import 'exports.dart';

abstract class BaseScreen<D extends Dependencies, B extends BaseBloc> extends StatefulWidget {
  BaseScreen({
    super.key,
    this.dependencies,
  });

  final D? dependencies;
  _BaseScreenState<BaseScreen<D, B>, D, B>? _state;

  /// Getter for `bloc`
  B get bloc {
    assert(_state != null, 'BaseScreen is not yet initialized!');
    return _state!.bloc;
  }

  @override
  createState() => _BaseScreenState<BaseScreen<D, B>, D, B>();
  @protected
  Widget build(BuildContext context);
}

class _BaseScreenState<T extends BaseScreen<D, B>, D extends Dependencies, B extends BaseBloc>
    extends State<T> {
  late B bloc;

  @override
  @protected
  void initState() {
    widget._state = this;
    widget.dependencies?.inject();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => bloc.onInit());
  }

  @override
  @protected
  void dispose() {
    widget._state = null;
    bloc.onClose();
    super.dispose();
  }

  @override
  @protected
  Widget build(BuildContext context) => BlocProvider<B>(
        create: (_) => bloc = get<B>(),
        child: widget.build(context),
      );
}
