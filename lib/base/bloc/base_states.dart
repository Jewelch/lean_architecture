// Base Enum to represent states
import '../../api/data_source.dart' show EquatableMixin;

enum BaseStateEnum { idle, loading, empty, success, error }

class BaseState<T> with EquatableMixin {
  final BaseStateEnum state;
  final T? data;
  final String? message;

  const BaseState(
    this.state, {
    this.data,
    this.message,
  });

  factory BaseState.idle() => const BaseState(BaseStateEnum.idle);
  factory BaseState.loading() => const BaseState(BaseStateEnum.loading);
  factory BaseState.empty() => const BaseState(BaseStateEnum.empty);
  factory BaseState.success(T data) => BaseState(BaseStateEnum.success, data: data);
  factory BaseState.error(String message) => BaseState(BaseStateEnum.error, message: message);

  @override
  List<Object?> get props => [state, data, message];
}
