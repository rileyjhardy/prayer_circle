import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_circle/models/prayer_cirlce.dart';

class PrayerCircleNotifier extends StateNotifier<List<PrayerCircle>> {
  PrayerCircleNotifier() : super(PrayerCircle.all());

  void createPrayerCircle(String name) {
    final prayerCircle = PrayerCircle(name: name);
    prayerCircle.upsert();
    state = [...state, prayerCircle];
  }

  void destroyPrayerCircle(int id) {
    PrayerCircle.box.remove(id);
    state = state.where((element) => element.id != id).toList();
  }

  void updatePrayerCircle(int id, String name) {
    PrayerCircle.box.put(PrayerCircle(id: id, name: name));

    state = PrayerCircle.all();
  }
}

final prayerCircleProvider =
    StateNotifierProvider<PrayerCircleNotifier, List<PrayerCircle>>((ref) {
  return PrayerCircleNotifier();
});
