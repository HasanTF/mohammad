import 'dart:io';

import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kWidth = screenSize.width;

    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "User";

    return Scaffold(
      backgroundColor: AppColors.cWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Header(displayName: displayName),
              SizedBox(height: 15.h),
              SearchBar(),
              SizedBox(height: 8.h),
              BeutySupport(),
              SizedBox(height: 15.h),
              Locations(),
              SizedBox(height: 8.h),
              CentersText(),
              SizedBox(height: 15.h),
              Centers(kWidth: kWidth),
            ],
          ),
        ),
      ),
    );
  }
}

class Centers extends StatelessWidget {
  final double kWidth;
  const Centers({super.key, required this.kWidth});

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

          final centers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: centers.length,
            itemBuilder: (context, index) {
              final center = centers[index];
              final data = center.data() as Map<String, dynamic>;
              final centerData = {...data, 'id': center.id};

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.borderR,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 0.1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            data['centerImageUrl'] ?? '',
                            fit: BoxFit.cover,
                            height: kWidth * 0.25,
                            width: kWidth * 0.25,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.broken_image, size: kWidth * 0.25),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['centerName'] ?? 'No Name',
                                style: TextStyle(
                                  color: AppColors.cPrimary,
                                  fontSize: Sizes.large,
                                  fontFamily: "Zain",
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (i) => Icon(
                                    Icons.star,
                                    color:
                                        i < (data['centerRating'] ?? 0).toInt()
                                        ? Colors.amber
                                        : Colors.grey,
                                    size: 20,
                                  ),
                                )..add(const SizedBox(width: 8)),
                              ),
                              Text(
                                data['centerLocation'] ?? '',
                                style: TextStyle(
                                  color: AppColors.cLightGrey,
                                  fontSize: Sizes.small,
                                ),
                              ),
                              Text(
                                data['centerDescription'] ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.small,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
          S.of(context).centers,
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
            shadows: AppShadows.primaryShadow,
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, "/addcenterscreen");
            });
          },
          child: Text(
            S.of(context).addCenter,
            style: TextStyle(fontSize: Sizes.extraSmall),
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
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
            shadows: AppShadows.primaryShadow,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          boxShadow: AppShadows.primaryShadow,
        ),
        child: TextField(
          style: TextStyle(color: AppColors.cPrimary),
          decoration: InputDecoration(
            hintText: "${S.of(context).search}...",
            hintStyle: TextStyle(color: AppColors.cPrimary),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: AppColors.cPrimary),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  final String displayName;

  const Header({super.key, required this.displayName});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isAdmin = false;
  String? photoURL;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    photoURL = FirebaseAuth.instance.currentUser?.photoURL;
    checkAdmin();
  }

  Future<void> checkAdmin() async {
    bool admin = await checkIfUserIsAdmin();
    setState(() {
      isAdmin = admin;
    });
  }

  Future<bool> checkIfUserIsAdmin() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return false;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (userDoc.exists) {
      final data = userDoc.data();
      return data?['isAdmin'] == true;
    }
    return false;
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      try {
        File imageFile = File(pickedFile.path);
        String uid = FirebaseAuth.instance.currentUser!.uid;

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('$uid.jpg');

        await ref.putFile(imageFile);

        final newImageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'imageUrl': newImageUrl,
        });

        await FirebaseAuth.instance.currentUser!.updatePhotoURL(newImageUrl);

        setState(() {
          photoURL = newImageUrl;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile image updated successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to upload image: $e')));
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.cPrimary.withAlpha(175),
                blurRadius: 10,
                offset: Offset(1, 1),
              ),
              BoxShadow(
                color: AppColors.cSecondary.withAlpha(175),
                blurRadius: 5,
                offset: Offset(-1, 0.5),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              photoURL != null && photoURL!.isNotEmpty
                  ? CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(photoURL!),
                      backgroundColor: AppColors.cPrimary.withAlpha(51),
                    )
                  : CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                      backgroundColor: AppColors.cPrimary.withAlpha(51),
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
                      onTap: pickAndUploadImage,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              S.of(context).welcomeBack,
              style: TextStyle(
                color: AppColors.cLightGrey,
                fontSize: Sizes.extraSmall,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.displayName,
              style: TextStyle(
                color: AppColors.cPrimary,
                fontSize: Sizes.medium,
                fontWeight: FontWeight.w800,
                fontFamily: "Delius",
              ),
            ),
          ],
        ),
        Spacer(),
        if (isAdmin)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
              boxShadow: AppShadows.primaryShadow,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admindashboardscreen');
              },
              color: Colors.red,
              icon: Icon(Icons.dashboard, size: 28),
            ),
          ),
        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
            boxShadow: AppShadows.primaryShadow,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, size: 28),
          ),
        ),
      ],
    );
  }
}
