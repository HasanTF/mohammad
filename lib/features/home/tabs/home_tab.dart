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
  String _searchQuery = ''; // Store the search query

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kWidth = screenSize.width;

    // Update username and photoURL on app start
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setDisplayName(user.displayName ?? "User");
        userProvider.setPhotoURL(user.photoURL ?? "");
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background image + blur
          SizedBox.expand(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Image.asset(
                "assets/images/mybadlife.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay layer for contrast
          Container(color: Colors.black12),
          // Foreground content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Header(),
                  SizedBox(height: 13.0),
                  SearchBar(
                    onSearch: (query) {
                      setState(() {
                        _searchQuery = query; // Update search query
                      });
                    },
                  ),
                  SizedBox(height: 13.0),
                  BeutySupport(),
                  SizedBox(height: 13.0),
                  Locations(),
                  SizedBox(height: 13.0),
                  CentersText(),
                  Centers(kWidth: kWidth, searchQuery: _searchQuery),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;
  const SearchBar({super.key, required this.onSearch});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      label: S.of(context).search,
      prefixIcon: const Icon(Icons.search),
      controller: _controller,
      onChanged: (value) {
        widget.onSearch(value);
      },
    );
  }
}

class Centers extends StatelessWidget {
  final double kWidth;
  final String searchQuery;
  const Centers({super.key, required this.kWidth, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
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
            return const Center(child: Text("No centers available."));
          }

          // Filter centers based on search query
          final centers = snapshot.data!.docs.where((center) {
            final data = center.data() as Map<String, dynamic>;
            final centerName =
                data['centerName']?.toString().toLowerCase() ?? '';
            final centerLocation =
                data['centerLocation']?.toString().toLowerCase() ?? '';
            final query = searchQuery.toLowerCase();
            return centerName.contains(query) || centerLocation.contains(query);
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
                  child: PhysicalModel(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    elevation: 10,
                    shadowColor: Colors.black54,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8D2FE).withAlpha(175),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white54,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  data['centerImageUrl'] ?? '',
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.broken_image,
                                        size: 100,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['centerName'] ?? 'No Name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.black87),
                                    ),
                                    const SizedBox(height: 4),
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
                                              : Colors.white24,
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
                                          color: Colors.white70,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            data['centerLocation'] ?? '',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
          S.of(context).centers,
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
            S.of(context).addCenter,
            style: TextStyle(color: Colors.black38),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          border: Border.all(color: Colors.white, width: 2.5),
        ),
        child: Image.asset("assets/images/Locations.jpg", fit: BoxFit.cover),
      ),
    );
  }
}

class BeutySupport extends StatelessWidget {
  const BeutySupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.of(context).beautySupport,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.black),
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
  String? photoURL;

  @override
  void initState() {
    super.initState();
    photoURL = FirebaseAuth.instance.currentUser?.photoURL;
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
                color: AppColors.primary.withAlpha(175),
                blurRadius: 10,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: userProvider.photoURL.isNotEmpty
                    ? NetworkImage(userProvider.photoURL)
                    : AssetImage("assets/images/avatar.jpg") as ImageProvider,
                backgroundColor: AppColors.primary.withAlpha(255),
              ),
              if (isLoading)
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
              else
                Positioned.fill(
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black45,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.add_a_photo,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 12.0),
        // Welcoming + Username
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              S.of(context).welcomeBack,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              userProvider.displayName,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Spacer(),
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
                      color: AppColors.primary.withAlpha(100),
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
        NotificationButton(userId: FirebaseAuth.instance.currentUser!.uid),
      ],
    );
  }
}
