import 'dart:async';
import 'package:beuty_support/core/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OffersTab extends StatelessWidget {
  const OffersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OffersCarousel(),
            SizedBox(height: 20),
            Text("HOT OFFERS!", style: Theme.of(context).textTheme.titleMedium),
            HotOffers(),
          ],
        ),
      ),
    );
  }
}

class HotOffers extends StatelessWidget {
  const HotOffers({super.key});

  // Sample offer data (replace with your actual data)
  final List<Map<String, String>> _offers = const [
    {
      'title': 'Summer Sale',
      'description': 'Get 50% off on all beauty products!',
      'image': 'assets/images/offers.jpg',
    },
    {
      'title': 'Spa Package',
      'description': 'Relax with our exclusive spa deals.',
      'image': 'assets/images/offers.jpg',
    },
    {
      'title': 'Skincare Bundle',
      'description': 'Buy one, get one free on skincare sets.',
      'image': 'assets/images/offers.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 60.0),
        itemCount: _offers.length,
        itemBuilder: (context, index) {
          final offer = _offers[index];
          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Offer image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                  child: Image.asset(
                    offer['image']!,
                    height: 150.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Offer details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['title']!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        offer['description']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12.0),
                      // Action button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your action here (e.g., navigate to offer details)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('View ${offer['title']}')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('View Offer'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({super.key});

  @override
  OffersCarouselState createState() => OffersCarouselState();
}

class OffersCarouselState extends State<OffersCarousel> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;
  Timer? _timer;

  // List of image paths from assets
  final List<String> _imagePaths = [
    'assets/images/offers.jpg',
    'assets/images/offers.jpg',
    'assets/images/offers.jpg',
    'assets/images/offers.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Start auto-scrolling
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _imagePaths.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _carouselController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 200.0,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _imagePaths.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Pagination dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _imagePaths.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(
                entry.key,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.black54
                      : Colors.grey[200],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
