import 'dart:convert';

// To parse this JSON data, use:
// final forecast = forecastFromJson(jsonString);

Forecast forecastFromJson(String str) => Forecast.fromJson(json.decode(str));

String forecastToJson(Forecast data) => json.encode(data.toJson());

class Forecast {
  final Location location;
  final Current current;
  final ForecastClass forecast;
  final Alerts? alerts;

  Forecast({
    required this.location,
    required this.current,
    required this.forecast,
    this.alerts,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
    forecast: ForecastClass.fromJson(json["forecast"]),
    alerts: json["alerts"] != null ? Alerts.fromJson(json["alerts"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current": current.toJson(),
    "forecast": forecast.toJson(),
    "alerts": alerts?.toJson(),
  };
}

class Alerts {
  final List<Alert> alert;

  Alerts({required this.alert});

  factory Alerts.fromJson(Map<String, dynamic> json) => Alerts(
    alert: List<Alert>.from(json["alert"].map((x) => Alert.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "alert": List<dynamic>.from(alert.map((x) => x.toJson())),
  };
}

class Alert {
  final String headline;
  final String msgtype;
  final String severity;
  final String urgency;
  final String areas;
  final String category;
  final String certainty;
  final String event;
  final String note;
  final DateTime effective;
  final DateTime expires;
  final String desc;
  final String instruction;

  Alert({
    required this.headline,
    required this.msgtype,
    required this.severity,
    required this.urgency,
    required this.areas,
    required this.category,
    required this.certainty,
    required this.event,
    required this.note,
    required this.effective,
    required this.expires,
    required this.desc,
    required this.instruction,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    headline: json["headline"],
    msgtype: json["msgtype"],
    severity: json["severity"],
    urgency: json["urgency"],
    areas: json["areas"],
    category: json["category"],
    certainty: json["certainty"],
    event: json["event"],
    note: json["note"],
    effective: DateTime.parse(json["effective"]),
    expires: DateTime.parse(json["expires"]),
    desc: json["desc"],
    instruction: json["instruction"],
  );

  Map<String, dynamic> toJson() => {
    "headline": headline,
    "msgtype": msgtype,
    "severity": severity,
    "urgency": urgency,
    "areas": areas,
    "category": category,
    "certainty": certainty,
    "event": event,
    "note": note,
    "effective": effective.toIso8601String(),
    "expires": expires.toIso8601String(),
    "desc": desc,
    "instruction": instruction,
  };
}

class Current {
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double uv;

  Current({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.uv,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    tempC: json["temp_c"].toDouble(),
    tempF: json["temp_f"].toDouble(),
    isDay: json["is_day"],
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"].toDouble(),
    windKph: json["wind_kph"].toDouble(),
    windDegree: json["wind_degree"],
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"].toDouble(),
    pressureIn: json["pressure_in"].toDouble(),
    precipMm: json["precip_mm"].toDouble(),
    precipIn: json["precip_in"].toDouble(),
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"].toDouble(),
    feelslikeF: json["feelslike_f"].toDouble(),
    uv: json["uv"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "uv": uv,
  };
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
    "code": code,
  };
}

class ForecastClass {
  final List<Forecastday> forecastday;

  ForecastClass({required this.forecastday});

  factory ForecastClass.fromJson(Map<String, dynamic> json) => ForecastClass(
    forecastday: List<Forecastday>.from(
        json["forecastday"].map((x) => Forecastday.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "forecastday": List<dynamic>.from(forecastday.map((x) => x.toJson())),
  };
}

class Forecastday {
  final DateTime date;
  final Day day;

  Forecastday({
    required this.date,
    required this.day,
  });

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
    date: DateTime.parse(json["date"]),
    day: Day.fromJson(json["day"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "day": day.toJson(),
  };
}

class Day {
  final double maxtempC;
  final double mintempC;
  final Condition condition;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"].toDouble(),
    mintempC: json["mintemp_c"].toDouble(),
    condition: Condition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxtempC,
    "mintemp_c": mintempC,
    "condition": condition.toJson(),
  };
}

class Location {
  final String name;
  final String country;

  Location({
    required this.name,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "country": country,
  };
}
