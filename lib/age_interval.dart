class AgeInterval {
  int years = 0;
  int months = 0;

  AgeInterval(this.years, this.months);

  AgeInterval.fromJson(Map<String, dynamic> map) {
    years = map['years'];
    months = map['months'];
  }
}
