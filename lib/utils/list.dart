/// [List] extensions.
extension ListExtension<T> on List<T> {
  bool get isNotNullOrEmpty => this != null && isNotEmpty;
  bool get isNullOrEmpty => this == null || isEmpty;
}
