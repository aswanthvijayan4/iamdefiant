extension CapExtension on String {
  
  
  String get inCaps =>
      '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  String get allInCaps => this.toUpperCase();

  String toTitleCase() {
    if (this == null) throw ArgumentError("string: $this");

    if (this.isEmpty) return this;

    /// If you are careful you could use only this part of the code as shown in the second option.
    return this
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
