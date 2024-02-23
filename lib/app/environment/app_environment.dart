import '../../helpers/debugging_printer.dart';
import 'environments.dart';

abstract final class AppEnvironment {
  static Environment current = Environment.dev;
  static bool get mocking => current == Environment.mock;
  static bool get developping => current == Environment.dev;

  static const (String, String) testAccount = ("xx@yy.com", "xxxxxx");

  static void setupEnvironment(Environment environment) => current = environment;
}

extension AppEnvironmentExt on AppEnvironment {
  static void performEnvironmentAssertions() {
    Debugger.magenta(AppEnvironment.current.baseUrl);

    switch (AppEnvironment.current) {
      case Environment.mock:
        break;

      default:
        assert(
          AppEnvironment.current.baseUrl.isNotEmpty,
          '\n[AppEnvironment] Base Url should be provided when running a non mocking mode',
        );

        assert(
          AppEnvironment.current.baseUrl.startsWith('https') || AppEnvironment.current != Environment.prod,
          '\n[AppEnvironment] <Base Url> must start with "https" in PROD mode as its mandatory to stores publishing',
        );

        break;
    }
  }
}
