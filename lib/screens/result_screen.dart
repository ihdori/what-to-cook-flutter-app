// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:what2cooke/functions/url_launcher.dart';
import 'package:what2cooke/providers/choice_provider.dart';
import 'package:what2cooke/providers/database_provider.dart';
import 'package:what2cooke/providers/meal_time_selector_provider.dart';
import 'package:what2cooke/providers/region_provider.dart';
import 'package:what2cooke/utils/colors.dart';
import 'package:what2cooke/utils/custom_button.dart';

String selectionQuery(region, time) {
  return '''
            SELECT * 
            FROM meals
            JOIN regions on regions.id = meals.region_id
            JOIN meal_time_relations on meal_time_relations.m_id = meal_id
            JOIN times on times.time_id = meal_time_relations.t_id
            WHERE regions.id = $region
            AND meal_time_relations.t_id = $time
            ;
            ''';
}

List<Map<String, dynamic>>? myData;

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealData = ref.watch(databaseProvider);
    final region = ref.watch(regionProvider);
    final time = ref.watch(mealTimeSelectorProvider);
    final listLenght = ref.watch(listLengthProvider);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: mealData.when(
          data: (data) {
            return FutureBuilder(
                future: data.rawQuery(selectionQuery(region, time)),
                builder: (
                  context,
                  AsyncSnapshot<List<Map<String, Object?>>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Text('Error');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: orangeRed,
                    ));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    final choice = ref.watch(choiceProvider);
                    // Here I made new List from the originall data then I modifies the copied list to be in random order
                    if (myData == null ||
                        myData!.length != snapshot.data!.length) {
                      myData = List.from(
                          snapshot.data!); // Create a copy of the data
                      myData!.shuffle(); // Shuffle the copied list

                      print(
                          '+++++++++++++++++++++++++++++++++++++++++++++++++');
                    }

                    return SafeArea(
                        child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Image.asset(
                            'images/bg_pattren_1.jpg',
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.1),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'الوجبة:',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 24,
                                color: darkTurquois,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${myData![choice]['meal_name']}',
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontSize: 48,
                                color: darkTurquois,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              height: MediaQuery.of(context).size.height / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: '${myData![choice]['image_url']}',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Image.asset('images/painting.gif'),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomButton(
                              color1: turquois,
                              color2: const Color.fromARGB(255, 35, 133, 121),
                              textColor: Colors.white,
                              text: 'تم عاشت ايدك 👌',
                              icon: Ionicons.home,
                              onPressed: () {
                                ref.invalidate(regionProvider);
                                Navigator.pushReplacementNamed(context, '/');
                              },
                            ),
                            CustomButton(
                              color1: const Color.fromARGB(255, 210, 92, 63),
                              color2: orangeRed,
                              textColor: Colors.white,
                              icon: Ionicons.refresh_outline,
                              text: 'لا غيرها ما أريد 🙄',
                              onPressed: () {
                                if (choice == listLenght - 1) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'خلصن الأكلات🥲💔',
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          child: Column(
                                            children: [
                                              DialogCustomButton(
                                                onPressed: () {
                                                  ref
                                                      .read(choiceProvider
                                                          .notifier)
                                                      .update((state) => 0);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/');
                                                },
                                                text: 'ديلا رجعني😒',
                                                color1: orange,
                                                color2: orangeRed,
                                              ),
                                              DialogCustomButton(
                                                onPressed: () {
                                                  ref
                                                      .read(choiceProvider
                                                          .notifier)
                                                      .update((state) => 0);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/');
                                                },
                                                text: 'بلا زحمة عليك رجعني😊',
                                                color2: darkTurquois,
                                                color1: turquois,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (choice <= listLenght) {
                                  ref
                                      .read(listLengthProvider.notifier)
                                      .update((state) => snapshot.data!.length);
                                  ref
                                      .read(choiceProvider.notifier)
                                      .update((state) => state + 1);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            MaterialButton(
                              onPressed: () {
                                launchMyUrl(
                                    '${snapshot.data![choice]['video_url']}');
                              },
                              padding: const EdgeInsets.all(0),
                              child: DottedBorder(
                                  color: orange,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(16),
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 44,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          textDirection: TextDirection.rtl,
                                          'راويني فيديو شلون اطبخها😁',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: darkTurquois,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Ionicons.logo_youtube,
                                          color: orange,
                                          size: 32,
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ));
                  }
                  return const Text('NOT Working');
                });
          },
          error: (error, stackTrace) {
            return Center(child: Text(Exception(error).toString()));
          },
          loading: () {
            return Center(
                child: Image.asset(
              'images/page_loading.gif',
              scale: 5,
            ));
          },
        ));
  }
}

class DialogCustomButton extends StatelessWidget {
  const DialogCustomButton({
    Key? key,
    required this.onPressed,
    required this.color1,
    required this.color2,
    required this.text,
  }) : super(key: key);
  final Function onPressed;
  final Color color1;
  final Color color2;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color1,
                color2,
              ],
            ),
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          textDirection: TextDirection.rtl,
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
