class PlacementException implements Exception {
  final String message;
  PlacementException(this.message);

  @override
  String toString() {
    return 'PlacementException: $message';
  }
}