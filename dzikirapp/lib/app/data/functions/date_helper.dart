class DateHelper {
  static const List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  static const List<String> bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String getTodayDateAndMonth() {
    final now = DateTime.now();

    final day = now.day;
    final month = bulan[now.month - 1];

    return '$day $month';
  }

  static String formatFullDate(DateTime date) {
    final dayName = hari[date.weekday - 1];
    final dayNumber = date.day;
    final monthName = bulan[date.month - 1];
    final year = date.year;

    return '$dayName, $dayNumber $monthName $year';
  }

  List<Map<String, dynamic>> getNext7Days() {
    final now = DateTime.now();

    return List.generate(7, (index) {
      final date = now.add(Duration(days: index));

      return {
        'date': date,
        'dayName': hari[date.weekday - 1],
        'dayNumber': date.day,
      };
    });
  }
}
