import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:flutter/widgets.dart' show WidgetsBinding, mustCallSuper;
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  @mustCallSuper
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
    Debugger.red("onInit");
  }

  @mustCallSuper
  void onReady() {
    Debugger.red("onReady");
  }

  @mustCallSuper
  void onClose() {
    Debugger.red("onClose");
  }
}
