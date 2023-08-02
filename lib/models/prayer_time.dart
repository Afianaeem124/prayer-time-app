class PrayerTime {
  String? city;
  String? date;
  Today? today;
  Today? tomorrow;

  PrayerTime({this.city, this.date, this.today, this.tomorrow});

  PrayerTime.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    date = json['date'];
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    tomorrow =
        json['tomorrow'] != null ? new Today.fromJson(json['tomorrow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['date'] = this.date;
    if (this.today != null) {
      data['today'] = this.today!.toJson();
    }
    if (this.tomorrow != null) {
      data['tomorrow'] = this.tomorrow!.toJson();
    }
    return data;
  }
}

class Today {
  String? asr;
  String? dhuhr;
  String? fajr;
  String? ishaA;
  String? maghrib;
  String? sunrise;

  Today(
      {this.asr,
      this.dhuhr,
      this.fajr,
      this.ishaA,
      this.maghrib,
      this.sunrise});

  Today.fromJson(Map<String, dynamic> json) {
    asr = json['Asr'];
    dhuhr = json['Dhuhr'];
    fajr = json['Fajr'];
    ishaA = json['Isha\'a'];
    maghrib = json['Maghrib'];
    sunrise = json['Sunrise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Asr'] = this.asr;
    data['Dhuhr'] = this.dhuhr;
    data['Fajr'] = this.fajr;
    data['Isha\'a'] = this.ishaA;
    data['Maghrib'] = this.maghrib;
    data['Sunrise'] = this.sunrise;
    return data;
  }
}
