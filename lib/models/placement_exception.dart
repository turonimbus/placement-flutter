class PlacementException extends Error {
  final String message;
  PlacementException(this.message);

  @override
  String toString() {
    return 'PlacementException: $message';
  }
}