import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:flutter/widgets.dart' show WidgetsBinding, mustCallSuper;
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState) {
    onInit();
  }

  @mustCallSuper
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
    Debugger.yellow("$runtimeType initialized");
  }

  @mustCallSuper
  void onReady() {
    Debugger.green("$runtimeType ready");
  }

  @mustCallSuper
  void onClose() {
    Debugger.red("$runtimeType closed");
  }
}
