import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dictionary/src/application/controllers/home_controller.dart';
import 'package:dictionary/src/ui/pages/home/widgets/word_card.dart';
import 'package:dictionary/src/ui/widgets/scaffold_dictionary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldDictionary(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color(0xFF465275),
        style: TabStyle.react,
        activeColor: Colors.white,
        onTap: (int tabNum) => controller.changeWords(tabNum),
        items: const [
          TabItem(icon: Icons.wordpress_outlined, title: 'Home'),
          TabItem(icon: Icons.star_border, title: 'Favorite'),
          TabItem(icon: Icons.history_rounded, title: 'History'),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.width * 0.02, horizontal: Get.height * 0.02),
            child: SizedBox(
              height: Get.height * 0.06,
              child: TextField(
                style: TextStyle(fontSize: Get.width * 0.05),
                controller: controller.searchController,
                onChanged: controller.search,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => controller.clearSearch(),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Color(0xFF465275), width: 0.8),
                    )),
              ),
            ),
          ),
          Expanded(
            child: PagedGridView(
                pagingController: controller.pagingController,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, word, index) => WordCard(
                          word: word.toString(),
                          onTap: () => controller.navigateWord(word.toString()),
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
