import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:prayer_circle/widgets/prayer_details.dart';

class PrayerList extends StatefulWidget {
  const PrayerList({super.key});

  @override
  State<PrayerList> createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  final _future = Supabase.instance.client.from('prayer_circles').select();

  @override
  Widget build(BuildContext context) {
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
                final data = snapshot.data!;

                final array = ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final prayer = data[index];
                    return SizedBox(
                      height: 100,
                      child: ListTile(
                        tileColor: Colors.purpleAccent,
                        leading: const Icon(Icons.circle),
                        subtitle: const Text('Monday'),
                        title: Text(prayer['name']),
                        splashColor: Colors.greenAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PrayerDetails(
                                  title: prayer['name'],
                                  duration: prayer['duration'],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }),
                );

                return array;
              },
            ),
          ),
          const Material(
            color: Colors.purpleAccent,
            child: Text('Prayer Circle'),
          )
        ],
      ),
    );
  }
}
