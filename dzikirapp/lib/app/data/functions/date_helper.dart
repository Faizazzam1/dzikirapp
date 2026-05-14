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
