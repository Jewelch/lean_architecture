// ignore_for_file: unused_element

enum Environment {
  mock(),
  dev(
    baseUrl: "https://dummyjson.com/",
  ),
  preprod(
    baseUrl: "https://dummyjson.com/",
  ),
  prod(
    baseUrl: "https://dummyjson.com/",
  );

  final String baseUrl;
  final int connectTimeout;
  final int sendTimeout;
  final int receiveTimeout;

  const Environment({
    this.baseUrl = "",
    this.connectTimeout = 20000,
    this.sendTimeout = 30000,
    this.receiveTimeout = 25000,
  });
}
