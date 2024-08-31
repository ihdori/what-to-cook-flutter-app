import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:what2cocke/providers/choise_provider.dart';
import 'package:what2cocke/providers/meal_provider.dart';
import 'package:what2cocke/providers/region_provider.dart';
import 'package:what2cocke/utils/colors.dart';
import 'package:what2cocke/utils/custom_button.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealData = ref.watch(mealProvider);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: mealData.when(
          data: (data) {
            final choice = ref.watch(choiceProvider(data));

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
                      ' ${data[choice]['meal_name']}',
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
                          child: FadeInImage.assetNetwork(
                            placeholder: "images/painting.gif",
                            placeholderFit: BoxFit.contain,
                            image: '${data[choice]['image']}',
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Text(
                              'حدث خطأ ما 🥲 تأكد من اتصالك بالانترنت',
                              textAlign: TextAlign.center,
                            ),
                          )),
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
                        ref.refresh(choiceProvider(data));
                      },
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Future<void> lunchYoutubeVideo() async {
                          if (!await launchUrl(
                              Uri.parse('${data[choice]['video_link']}'))) {
                            throw Exception('Could not launch url');
                          }
                        }

                        lunchYoutubeVideo();
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
                            width: MediaQuery.of(context).size.width - 44,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
