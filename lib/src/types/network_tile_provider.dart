part of yandex_mapkit;

class NetworkTileProvider {
  final String baseUrl;
  final Map<String, String> headers;

  NetworkTileProvider({required this.baseUrl, this.headers = const {}});

  Map<String, dynamic> toJson() {
    return {'baseUrl': baseUrl, 'headers': headers};
  }
}
