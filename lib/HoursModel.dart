final String tableHours = 'hours';

class HoursFields {
  static final List<String> values = [
    /// Add all fields
    id, inTime, outTime, breakTime, totalHours, date
  ];

  static final String id = '_id';
  static final String inTime = 'inTime';
  static final String outTime = 'outTime';
  static final String breakTime = 'breakTime';
  static final String totalHours = 'totalHours';
  static final String date = 'date';
}

class Hour {
  final int? id;
  final String inTime;
  final String outTime;
  final String breakTime;
  final String totalHours;
  final DateTime date;

  const Hour({
    this.id,
    required this.inTime,
    required this.outTime,
    required this.breakTime,
    required this.totalHours,
    required this.date,
  });

  Hour copy({
    int? id,
    String? inTime,
    String? outTime,
    String? breakTime,
    String? totalHours,
    DateTime? date,
  }) =>
      Hour(
        id: id ?? this.id,
        inTime: inTime ?? this.inTime,
        outTime: outTime ?? this.outTime,
        breakTime: breakTime ?? this.breakTime,
        totalHours: totalHours ?? this.totalHours,
        date: date ?? this.date,
      );

  static Hour fromJson(Map<String, Object?> json) => Hour(
    id: json[HoursFields.id] as int?,
    inTime: json[HoursFields.inTime].toString(),
    outTime: json[HoursFields.outTime].toString(),
    breakTime: json[HoursFields.breakTime].toString(),
    totalHours: json[HoursFields.totalHours].toString(),
    date: DateTime.parse(json[HoursFields.date] as String),
  );

  Map<String, Object?> toJson() => {
    HoursFields.id: id,
    HoursFields.inTime: inTime,
    HoursFields.outTime: outTime,
    HoursFields.breakTime: breakTime,
    HoursFields.totalHours: totalHours,
    HoursFields.date: date.toIso8601String(),
  };
}