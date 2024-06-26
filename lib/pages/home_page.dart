import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:indus_app/controller/home_page_controller.dart';
import 'package:indus_app/model/banner_model.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return controller.obx(
      (state) => GestureDetector(
        onTap: () {
          controller.focusNodeSearch.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          FeatherIcons.mapPin,
                          size: 17,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'United Arab Emirates, Dubai',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SearchBarWidget(controller: controller),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Recommendations',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RecommendationsWidget(controller: controller, height: height),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendationsWidget extends StatelessWidget {
  const RecommendationsWidget({
    super.key,
    required this.controller,
    required this.height,
  });

  final HomePageController controller;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // autoPlay: true,
        aspectRatio: 1,
        // enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        onPageChanged: (index, reason) {
          controller.bannerIndex(index);
        },
      ),
      items: controller.bannersList.map(
        (banner) {
          var index = controller.bannersList.indexOf(banner);
          return PropertyCardWidget(
            height: height,
            controller: controller,
            property: banner,
          );
        },
      ).toList(),
    );
  }
}

class PropertyCardWidget extends StatelessWidget {
  const PropertyCardWidget({
    super.key,
    required this.height,
    required this.controller,
    required this.property,
  });

  final double height;
  final HomePageController controller;
  final BannerModel property;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 13,
          right: 13,
          left: 13,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fit: BoxFit.cover,
                      property.image,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null &&
                                controller.showBanners.value == true
                            ? child
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: height / 3,
                                child: Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 190, 190, 190),
                                  highlightColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Container(
                                    height: height / 3,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.85),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/star.png',
                              height: 16,
                            ),
                            const SizedBox(width: 7),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                '4.8',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: Theme.of(context).colorScheme.background.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Banglow',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mega Hights',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      FeatherIcons.mapPin,
                      size: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'United Arab Emirates, Dubai',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AED 1,200,000',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Icon(
                  FeatherIcons.heart,
                  size: 25,
                  color: Colors.grey[400],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
  });

  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 15.0,
              spreadRadius: 0.5,
            ),
          ]),
      child: TextFormField(
        focusNode: controller.focusNodeSearch,
        controller: controller.searchController,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w400,
            ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            FeatherIcons.search,
            color: Colors.grey[400],
            size: 20,
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Icon(
              FeatherIcons.sliders,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
