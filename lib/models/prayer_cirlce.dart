import 'package:objectbox/objectbox.dart';
import 'package:prayer_circle/main.dart';
import 'package:prayer_circle/providers/prayer_circle_provider.dart';

// final provider = StoreProvider.provider();

@Entity()
class PrayerCircle {
  PrayerCircle({required this.name, this.id});

  @Id()
  late int? id = 0;
  final String name;

  static final box = objectbox.store.box<PrayerCircle>();

  static List<PrayerCircle> all() {
    return box.getAll();
  }

  // static Future<void> upsert(id) async {
  //   box.put(this);
  // }

  upsert() {
    box.put(this);
  }

  destroy(id) {
    box.remove(id);
  }
}
