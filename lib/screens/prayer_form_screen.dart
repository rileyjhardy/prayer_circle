import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:prayer_circle/providers/prayer_circle_provider.dart';
import 'package:prayer_circle/models/prayer_cirlce.dart';

class PrayerFormScreen extends ConsumerWidget {
  PrayerFormScreen({this.prayer, super.key});

  final PrayerCircle? prayer;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: prayer?.name);

    final bool isEditing =
        prayer != null && prayer!.id != null && prayer!.id != 0;

    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Prayer Name',
                  ),
                  // controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a prayer name';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: GFBorder(
                          color: Theme.of(context).colorScheme.secondary,
                          dashedLine: const [10, 2],
                          type: GFBorderType.rect,
                          child: TextButton(
                            child: const Text('Tap to add prayer session'),
                            onPressed: () => {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = nameController.text;
                      if (isEditing) {
                        ref
                            .read(prayerCircleProvider.notifier)
                            .updatePrayerCircle(prayer!.id!, name);
                      } else {
                        ref
                            .read(prayerCircleProvider.notifier)
                            .createPrayerCircle(name);
                      }

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
