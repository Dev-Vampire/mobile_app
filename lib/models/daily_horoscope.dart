class DailyHoroscope {
  String dateRange;
  String currentDate;
  String description;
  String compatibility;
  String mood;
  String color;
  String luckyNumber;
  String luckyTime;

  DailyHoroscope(
      {this.dateRange,
      this.currentDate,
      this.description,
      this.compatibility,
      this.mood,
      this.color,
      this.luckyNumber,
      this.luckyTime});

  DailyHoroscope.fromJson(Map<String, dynamic> json) {
    dateRange = json['date_range'];
    currentDate = json['current_date'];
    description = json['description'];
    compatibility = json['compatibility'];
    mood = json['mood'];
    color = json['color'];
    luckyNumber = json['lucky_number'];
    luckyTime = json['lucky_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_range'] = this.dateRange;
    data['current_date'] = this.currentDate;
    data['description'] = this.description;
    data['compatibility'] = this.compatibility;
    data['mood'] = this.mood;
    data['color'] = this.color;
    data['lucky_number'] = this.luckyNumber;
    data['lucky_time'] = this.luckyTime;
    return data;
  }
}