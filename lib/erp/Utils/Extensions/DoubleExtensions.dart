extension RoundOffExtension on double {
  double get roundToOne {
    int no = this.toInt();

    double fraction = this - no;
    if (fraction < 0.5) {
      fraction = 0;
    } else {
      fraction = 1;
    }
    return fraction + no;
  }
}
