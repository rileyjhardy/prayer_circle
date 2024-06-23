import 'package:flutter/material.dart';
import 'package:prayer_circle/screens/prayer_form_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prayer_circle/widgets/prayer_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_circle/providers/prayer_circle_provider.dart';

class PrayerList extends ConsumerStatefulWidget {
  const PrayerList({super.key});

  @override
  ConsumerState<PrayerList> createState() => _PrayerListState();
}

class _PrayerListState extends ConsumerState<PrayerList> {
  final _future = Supabase.instance.client.from('prayer_circles').select();

  @override
  Widget build(BuildContext context) {
    final prayerList = ref.watch(prayerCircleProvider);

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final array = ListView.builder(
                  shrinkWrap: true,
                  itemCount: prayerList.length,
                  itemBuilder: ((context, index) {
                    final prayer = prayerList[index];
                    return SizedBox(
                      height: 100,
                      child: ListTile(
                        tileColor: Colors.greenAccent,
                        leading: const Icon(Icons.circle),
                        trailing: TextButton(
                          child: const Icon(Icons.close),
                          onPressed: () => {
                            ref
                                .read(prayerCircleProvider.notifier)
                                .destroyPrayerCircle(prayer.id!),
                          },
                        ),
                        subtitle: Text(prayer.id.toString()),
                        title: Text(prayer.name),
                        splashColor: Colors.greenAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PrayerDetails(
                                  title: prayer.name,
                                  duration: 60,
                                );
                              },
                            ),
                          );
                        },
                        onLongPress: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return PrayerFormScreen(prayer: prayer);
                            },
                          ));
                        },
                      ),
                    );
                  }),
                );

                return array;
              },
            ),
          )
        ],
      ),
    );
  }
}
