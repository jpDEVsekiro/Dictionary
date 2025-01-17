import 'package:dic/src/application/controllers/home_controller.dart';
import 'package:dic/src/application/controllers/word_details_controller.dart';
import 'package:dic/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordDetails extends GetView<WordDetailsController> {
  const WordDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDictionary(
      body: Obx(
        () => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF465275)),
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02,
                                  vertical: Get.height * 0.01),
                              child: Row(
                                children: [
                                  InkWell(
                                      key: const Key('close_button'),
                                      child: Icon(Icons.close,
                                          color: const Color(0xFF465275),
                                          size: Get.width * 0.1),
                                      onTap: () => Get.back()),
                                  const Spacer(),
                                  InkWell(
                                      key: const Key('favorite_button'),
                                      child: Obx(
                                        () => Get.find<HomeController>()
                                                .favoriteWords
                                                .any((element) =>
                                                    element == controller.word)
                                            ? Icon(
                                                key: Key('star'),
                                                Icons.star,
                                                color: const Color(0xFF465275),
                                                size: Get.width * 0.1)
                                            : Icon(
                                                key: Key('empty_star'),
                                                Icons.star_border,
                                                color: const Color(0xFF465275),
                                                size: Get.width * 0.1),
                                      ),
                                      onTap: () =>
                                          controller.saveFavoriteWord()),
                                ],
                              ),
                            ),
                            Container(
                              height: Get.height * 0.3,
                              width: Get.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02),
                              child: Card(
                                key: const Key('word_card'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Get.height * 0.05),
                                            child: Text(
                                              controller.word,
                                              style: TextStyle(
                                                fontSize: Get.width * 0.1,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Text(
                                            controller.wordDetails
                                                    ?.pronunciation?.all ??
                                                '',
                                            style: TextStyle(
                                              fontSize: Get.width * 0.09,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.75,
                                          bottom: Get.height * 0.01),
                                      child: InkWell(
                                          child: Obx(
                                            () => Icon(
                                                key: Key('play_audio'),
                                                controller.isPlaying.value
                                                    ? Icons.pause
                                                    : Icons.play_arrow_rounded,
                                                size: Get.width * 0.1,
                                                color: const Color(0xFF465275)),
                                          ),
                                          onTap: () => controller.playAudio()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (controller.wordDetails?.results?.isNotEmpty ??
                                false) ...[
                              if (controller
                                      .wordDetails?.results?.first.definition !=
                                  null) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.02,
                                      vertical: Get.height * 0.01),
                                  child: Text(
                                    key: const Key('meaning'),
                                    'Meaning',
                                    style: TextStyle(
                                      fontSize: Get.width * 0.07,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.02,
                                      vertical: Get.height * 0.01),
                                  child: Text(
                                    controller.wordDetails?.results?.first
                                            .definition ??
                                        '',
                                    style: TextStyle(
                                      fontSize: Get.width * 0.05,
                                    ),
                                  ),
                                ),
                              ],
                              if (controller
                                      .wordDetails?.results?.first.synonyms !=
                                  null) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.02,
                                      vertical: Get.height * 0.01),
                                  child: Text(
                                    key: const Key('synonyms'),
                                    'Synonyms',
                                    style: TextStyle(
                                      fontSize: Get.width * 0.07,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  itemCount: controller.wordDetails?.results
                                          ?.first.synonyms?.length ??
                                      0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.02,
                                          vertical: Get.height * 0.01),
                                      child: Text.rich(
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: Get.width * 0.055,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: '• ',
                                                style: TextStyle(
                                                  fontSize: Get.width * 0.04,
                                                )),
                                            TextSpan(
                                              text: controller
                                                      .wordDetails
                                                      ?.results
                                                      ?.first
                                                      .synonyms?[index] ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: Get.width * 0.05,
                                              ),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontSize: Get.width * 0.05,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ]
                            ],
                            if (controller
                                    .wordDetails?.results?.first.examples !=
                                null) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.02,
                                    vertical: Get.height * 0.01),
                                child: Text(
                                  key: const Key('examples'),
                                  'Examples',
                                  style: TextStyle(
                                    fontSize: Get.width * 0.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemCount: controller.wordDetails?.results
                                        ?.first.examples?.length ??
                                    0,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.02,
                                        vertical: Get.height * 0.01),
                                    child: Text.rich(
                                      TextSpan(
                                        text: '',
                                        style: TextStyle(
                                          fontSize: Get.width * 0.055,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: '• ',
                                              style: TextStyle(
                                                fontSize: Get.width * 0.04,
                                              )),
                                          TextSpan(
                                            text: controller
                                                    .wordDetails
                                                    ?.results
                                                    ?.first
                                                    .examples?[index] ??
                                                '',
                                            style: TextStyle(
                                              fontSize: Get.width * 0.05,
                                            ),
                                          ),
                                        ],
                                      ),
                                      style: TextStyle(
                                        fontSize: Get.width * 0.05,
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                            if (controller.wordDetails?.syllables != null) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.02,
                                    vertical: Get.height * 0.01),
                                child: Text(
                                  key: const Key('syllables'),
                                  'Syllables',
                                  style: TextStyle(
                                    fontSize: Get.width * 0.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.width * 0.1,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.02),
                                  itemCount: controller.wordDetails?.syllables
                                          ?.list?.length ??
                                      0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.01),
                                      child: Text.rich(
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: Get.width * 0.055,
                                          ),
                                          children: [
                                            if (index != 0)
                                              TextSpan(
                                                  text: '·',
                                                  style: TextStyle(
                                                    fontSize: Get.width * 0.05,
                                                  )),
                                            TextSpan(
                                              text: controller
                                                      .wordDetails
                                                      ?.syllables
                                                      ?.list?[index] ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: Get.width * 0.05,
                                              ),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontSize: Get.width * 0.05,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ]
                          ]),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: controller.backWord,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.015,
                              vertical: Get.height * 0.01),
                          child: Container(
                              height: Get.height * 0.055,
                              width: Get.width * 0.47,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                key: const Key('back_word_button'),
                                'Back',
                                style: TextStyle(
                                  fontSize: Get.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: controller.nextWord,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.015,
                              vertical: Get.height * 0.01),
                          child: Container(
                              height: Get.height * 0.055,
                              width: Get.width * 0.47,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF465275),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                key: const Key('next_word_button'),
                                'Next',
                                style: TextStyle(
                                  fontSize: Get.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
