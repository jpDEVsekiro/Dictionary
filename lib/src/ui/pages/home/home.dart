import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dic/src/application/controllers/home_controller.dart';
import 'package:dic/src/ui/pages/home/widgets/word_card.dart';
import 'package:dic/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDictionary(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color(0xFF465275),
        style: TabStyle.react,
        activeColor: Colors.white,
        onTap: (int tabNum) => controller.changeWords(tabNum),
        items: [
          TabItem(icon: Image.asset('assets/images/icon.jpg'), title: 'Words'),
          const TabItem(icon: Icons.star_border, title: 'Favorite'),
          const TabItem(icon: Icons.history_rounded, title: 'History'),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF465275),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: Get.width * 0.04,
                  left: Get.height * 0.02,
                  right: Get.height * 0.02,
                  top: Get.height * 0.04),
              child: TextField(
                key: const Key('search_home'),
                style: TextStyle(fontSize: Get.width * 0.05),
                cursorColor: const Color(0xFF465275),
                controller: controller.searchController,
                onChanged: controller.search,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    filled: true,
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Color(0xFF465275),
                      ),
                      focusColor: const Color(0xFF465275),
                      onPressed: () => controller.clearSearch(),
                    ),
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF465275)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color(0xFF465275), width: 0.8),
                    )),
              ),
            ),
          ),
          Expanded(
            child: PagedGridView(
                key: const Key('words_grid'),
                pagingController: controller.pagingController,
                scrollController: controller.scrollController,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, word, index) => WordCard(
                          key: Key('${word.toString()}_${controller.tabName}'),
                          word: word.toString(),
                          onTap: () => controller.navigateWord(word.toString()),
                        ),
                    firstPageProgressIndicatorBuilder: (context) =>
                        const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF465275),
                          ),
                        ),
                    noItemsFoundIndicatorBuilder: (context) => Center(
                          child: Text(
                            'No words found',
                            style: TextStyle(
                                fontSize: Get.width * 0.05,
                                color: const Color(0xFF465275)),
                          ),
                        ),
                    newPageProgressIndicatorBuilder: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF465275),
                          ),
                        )),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                )),
          )
        ],
      ),
    );
  }
}
