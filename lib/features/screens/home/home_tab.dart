import 'dart:ui';
import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/notification_button.dart';
import 'package:beuty_support/features/providers/user_provider.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _searchQuery = '';
  List<String> _selectedServices = []; // لتخزين الخدمات المختارة

  @override
  void initState() {
    super.initState();
    // تهيئة بيانات المستخدم عند بدء التطبيق
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.initializeUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(),
              SizedBox(height: screenHeight * 0.02),
              SearchBar(
                onSearch: (query, services) {
                  setState(() {
                    _searchQuery = query;
                    _selectedServices = services; // تحديث الخدمات
                  });
                },
              ),
              Clinicly(),
              Locations(),
              CentersText(),
              Centers(
                screenWidth: screenWidth,
                searchQuery: _searchQuery,
                selectedServices: _selectedServices, // تمرير الخدمات
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String, List<String>) onSearch; // تعديل لتمرير الخدمات
  const SearchBar({super.key, required this.onSearch});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  List<String> selectedServices = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> allServices = [
      S.of(context).haircut,
      S.of(context).makeup,
      S.of(context).massage,
      S.of(context).nails,
      S.of(context).skincare,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          label: S.of(context).search,
          prefixIcon: const Icon(Icons.search),
          controller: _controller,
          onChanged: (value) {
            widget.onSearch(value, selectedServices); // تمرير النص والخدمات
          },
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: allServices.map((service) {
            final isSelected = selectedServices.contains(service);
            return FilterChip(
              label: Text(
                service,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              selected: isSelected,
              selectedColor: AppColors.secondaryDark.withAlpha(50),
              checkmarkColor: AppColors.primary,
              backgroundColor: AppColors.secondaryDark.withAlpha(100),
              onSelected: (value) {
                setState(() {
                  if (value) {
                    selectedServices.add(service);
                  } else {
                    selectedServices.remove(service);
                  }
                  widget.onSearch(
                    _controller.text,
                    selectedServices,
                  ); // تحديث البحث
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class Centers extends StatelessWidget {
  final double screenWidth;
  final String searchQuery;
  final List<String> selectedServices;

  const Centers({
    super.key,
    required this.screenWidth,
    required this.searchQuery,
    required this.selectedServices,
  });

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('centers')
            .where('status', isEqualTo: 'approved')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text(S.of(context).noclinics));
          }

          // فلترة النتائج
          final centers = snapshot.data!.docs.where((center) {
            final data = center.data() as Map<String, dynamic>;
            final centerName =
                data['centerName']?.toString().toLowerCase() ?? '';
            final centerLocation =
                data['centerLocation']?.toString().toLowerCase() ?? '';
            final services = List<String>.from(data['services'] ?? []);
            final query = searchQuery.toLowerCase();

            bool matchesQuery =
                centerName.contains(query) || centerLocation.contains(query);
            bool matchesServices =
                selectedServices.isEmpty ||
                selectedServices.every((service) => services.contains(service));

            return matchesQuery && matchesServices;
          }).toList();

          if (centers.isEmpty) {
            return const Center(child: Text("No centers match your search."));
          }

          return ListView.builder(
            itemCount: centers.length,
            padding: const EdgeInsets.only(bottom: 60),
            itemBuilder: (context, index) {
              final center = centers[index];
              final data = center.data() as Map<String, dynamic>;
              final centerData = {...data, 'id': center.id};

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/centerdetails',
                      arguments: centerData,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: AppColors.primary.withAlpha(150),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(25),
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // صورة المركز
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            data['centerImageUrl'] ?? '',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // باقي التفاصيل + القلب
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // تفاصيل المركز
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['centerName'] ?? 'No Name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: AppColors.primary),
                                    ),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (i) => Icon(
                                          Icons.star_rounded,
                                          color:
                                              i <
                                                  (data['centerRating'] ?? 0)
                                                      .toInt()
                                              ? Colors.amber
                                              : Colors.black26,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: AppColors.secondaryDark,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            data['centerLocation'] ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color:
                                                      AppColors.secondaryDark,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data['centerDescription'] ?? '',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              // ❤️ زر المفضلة (يتغير حسب وجوده بالفيفوريتس)
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId)
                                    .collection('favorites')
                                    .doc(center.id)
                                    .snapshots(),
                                builder: (context, favSnapshot) {
                                  final isFavorite =
                                      favSnapshot.data?.exists ?? false;

                                  return IconButton(
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.red
                                          : AppColors.secondaryDark,
                                    ),
                                    onPressed: () {
                                      final favRef = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userId)
                                          .collection('favorites')
                                          .doc(center.id);

                                      if (isFavorite) {
                                        favRef.delete();
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              S
                                                  .of(context)
                                                  .removedfromfavorites,
                                            ),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      } else {
                                        favRef.set(data);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              S.of(context).addedtofavorites,
                                            ),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CentersText extends StatefulWidget {
  const CentersText({super.key});

  @override
  State<CentersText> createState() => _CentersTextState();
}

class _CentersTextState extends State<CentersText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.of(context).clinics,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black87),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, "/addcenterscreen");
            });
          },
          child: Text(
            S.of(context).addclinic,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}

class Locations extends StatelessWidget {
  const Locations({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(25);

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.secondaryDark.withAlpha(150),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: radius.subtract(
          BorderRadius.circular(2.5), // نقصنا عرض البوردر شوي
        ),
        child: Image.asset("assets/images/Locations.jpg", fit: BoxFit.cover),
      ),
    );
  }
}

class Clinicly extends StatelessWidget {
  const Clinicly({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            S.of(context).clinicly,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isAdmin = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkAdmin();
  }

  Future<void> checkAdmin() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (userDoc.exists) {
      final data = userDoc.data();
      setState(() {
        isAdmin = data?['isAdmin'] == true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Avatar image
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryDark.withAlpha(175),
                blurRadius: 10,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 32,
            backgroundImage: userProvider.photoURL.isNotEmpty
                ? NetworkImage(userProvider.photoURL)
                : AssetImage("assets/images/avatar.jpg") as ImageProvider,
            backgroundColor: AppColors.primary.withAlpha(255),
          ),
        ),
        SizedBox(width: 12.0),

        // Welcoming + Username
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                S.of(context).welcome,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                userProvider.displayName,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.primary),
                overflow: TextOverflow.ellipsis, // يمنع overflow
                maxLines: 1, // يفرض سطر واحد
              ),
            ],
          ),
        ),

        // زر الادمن إذا موجود
        if (isAdmin)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white54, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryDark.withAlpha(100),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admindashboardscreen');
                  },
                  icon: const Icon(
                    Icons.dashboard,
                    size: 28,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 1)],
                  ),
                ),
              ),
            ),
          ),
        SizedBox(width: 5),

        // Notification Button
        NotificationButton(userId: FirebaseAuth.instance.currentUser!.uid),
      ],
    );
  }
}
