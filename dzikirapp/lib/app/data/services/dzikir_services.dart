import 'package:dzikirapp/app/data/models/dzikir_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DzikirServices {
  final supabase = Supabase.instance.client.schema('dzikir');
  final userId = Supabase.instance.client.auth.currentSession?.user.id;

  Future<DzikirModel> addDzikir(String dzikir, int target) async {
    final response = await supabase
        .from('dzikir')
        .insert(
          DzikirModel(
            ucapan: dzikir,
            target: target,
            jumlah: 0,
            userId: userId,
          ).toJson(),
        )
        .select()
        .single();
    print('DZIKIR SERVICE SUCCESS');
    return DzikirModel.fromJson(response);
  }

  Future<List<DzikirModel>> getDzikir() async {
    try {
      final response = await supabase
          .from('dzikir')
          .select()
          .eq('user_id', userId!)
          .order('created_at', ascending: false);
      return response.map((e) => DzikirModel.fromJson(e)).toList();
    } catch (e) {
      print('DZIKIR SERVICE ERROR: $e');
      return [];
    }
  }

  Future<void> updateDzikir(DzikirModel data) async {
    try {
      await supabase.from('dzikir').update(data.toJson()).eq('id', data.id!);
      print('DZIKIR SERVICE SUCCESS');
    } catch (e) {
      print('DZIKIR SERVICE ERROR: $e');
    }
  }

  Future<void> updateJumlah(int id, int jumlah) async {
    await supabase.from('dzikir').update({'jumlah': jumlah}).eq('id', id);
  }

  Future<List<DzikirModel>> getHistoryDzikir() async {
    try {
      final today = DateTime.now();

      final startToday = DateTime(today.year, today.month, today.day);

      final response = await supabase
          .from('dzikir')
          .select()
          .eq('user_id', userId!)
          .lt('created_at', startToday.toIso8601String())
          .order('created_at', ascending: false);

      return response.map((e) => DzikirModel.fromJson(e)).toList();
    } catch (e) {
      print('DZIKIR SERVICE ERROR: $e');
      return [];
    }
  }
}
