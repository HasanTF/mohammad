// import 'dart:io';
// import 'package:beuty_support/core/constants/themes.dart';
// import 'package:beuty_support/core/widget/custom_input_field.dart';
// import 'package:beuty_support/core/widget/notification_button.dart';
// import 'package:beuty_support/features/providers/user_provider.dart';
// import 'package:beuty_support/generated/l10n.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:provider/provider.dart';

// class HomeTab extends StatelessWidget {
//   const HomeTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final kWidth = screenSize.width;

//     // تحديث اسم المستخدم و photoURL عند بداية التطبيق
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         final userProvider = Provider.of<UserProvider>(context, listen: false);
//         userProvider.setDisplayName(user.displayName ?? "User");
//         userProvider.setPhotoURL(user.photoURL ?? "");
//       });
//     }

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Header(), // لا نحتاج لتمرير displayName بعد الآن
//               SizedBox(height: 13.0),
//               SearchBar(),
//               SizedBox(height: 13.0),
//               BeutySupport(),
//               SizedBox(height: 13.0),
//               Locations(),
//               SizedBox(height: 13.0),
//               CentersText(),
//               Centers(kWidth: kWidth),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Centers extends StatelessWidget {
//   final double kWidth;
//   const Centers({super.key, required this.kWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('centers')
//             .where('status', isEqualTo: 'approved')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No centers available."));
//           }

//           final centers = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: centers.length,
//             itemBuilder: (context, index) {
//               final center = centers[index];
//               final data = center.data() as Map<String, dynamic>;
//               final centerData = {...data, 'id': center.id};

//               return Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       '/centerdetails',
//                       arguments: centerData,
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(
//                         AppBorderRadius.borderR,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 8,
//                           spreadRadius: 1,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                             AppBorderRadius.borderR,
//                           ),
//                           child: Image.network(
//                             data['centerImageUrl'] ?? '',
//                             fit: BoxFit.cover,
//                             height: kWidth * 0.25,
//                             width: kWidth * 0.25,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 Icon(Icons.broken_image, size: kWidth * 0.25),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data['centerName'] ?? 'No Name',
//                                 style: Theme.of(context).textTheme.bodyLarge,
//                               ),
//                               Row(
//                                 children: List.generate(
//                                   5,
//                                   (i) => Icon(
//                                     Icons.star,
//                                     color:
//                                         i < (data['centerRating'] ?? 0).toInt()
//                                         ? Colors.amber
//                                         : Colors.grey,
//                                     size: 20,
//                                   ),
//                                 )..add(const SizedBox(width: 8)),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.location_on_sharp,
//                                     size: Sizes.medium,
//                                     color: AppColors.primary,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     data['centerLocation'] ?? '',
//                                     style: Theme.of(
//                                       context,
//                                     ).textTheme.bodyMedium,
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 data['centerDescription'] ?? '',
//                                 style: Theme.of(context).textTheme.bodySmall,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class CentersText extends StatefulWidget {
//   const CentersText({super.key});

//   @override
//   State<CentersText> createState() => _CentersTextState();
// }

// class _CentersTextState extends State<CentersText> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           S.of(context).centers,
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         TextButton(
//           onPressed: () {
//             setState(() {
//               Navigator.pushNamed(context, "/addcenterscreen");
//             });
//           },
//           child: Text(
//             S.of(context).addCenter,
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Locations extends StatelessWidget {
//   const Locations({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height * 0.20,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
//         ),
//         child: Image.asset("assets/images/Locations.jpg", fit: BoxFit.cover),
//       ),
//     );
//   }
// }

// class BeutySupport extends StatelessWidget {
//   const BeutySupport({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           S.of(context).beautySupport,
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//       ],
//     );
//   }
// }

// class SearchBar extends StatelessWidget {
//   const SearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomInputField(
//       label: "Search...",
//       prefixIcon: const Icon(Icons.search),
//     );
//   }
// }

// class Header extends StatefulWidget {
//   const Header({super.key});

//   @override
//   State<Header> createState() => _HeaderState();
// }

// class _HeaderState extends State<Header> {
//   bool isAdmin = false;
//   bool isLoading = false;

//   String? photoURL;

//   @override
//   void initState() {
//     super.initState();
//     photoURL = FirebaseAuth.instance.currentUser?.photoURL;
//     checkAdmin();
//   }

//   Future<void> checkAdmin() async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) return;

//     final userDoc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get();
//     if (userDoc.exists) {
//       final data = userDoc.data();
//       setState(() {
//         isAdmin = data?['isAdmin'] == true;
//       });
//     }
//   }

//   Future<void> pickAndUploadImage() async {
//     final picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       setState(() {
//         isLoading = true;
//       });

//       try {
//         File imageFile = File(pickedFile.path);
//         String uid = FirebaseAuth.instance.currentUser!.uid;

//         final ref = FirebaseStorage.instance
//             .ref()
//             .child('user_images')
//             .child('$uid.jpg');
//         await ref.putFile(imageFile);
//         final newImageUrl = await ref.getDownloadURL();

//         await FirebaseFirestore.instance.collection('users').doc(uid).update({
//           'imageUrl': newImageUrl,
//         });

//         await FirebaseAuth.instance.currentUser!.updatePhotoURL(newImageUrl);

//         // تحديث Provider
//         if (mounted) {
//           Provider.of<UserProvider>(
//             context,
//             listen: false,
//           ).setPhotoURL(newImageUrl);
//         }

//         setState(() {
//           photoURL = newImageUrl;
//         });

//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Profile image updated successfully!')),
//           );
//         }
//       } catch (e) {
//         if (mounted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('Failed to upload image: $e')));
//         }
//       } finally {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.primary.withAlpha(175),
//                 blurRadius: 10,
//                 offset: Offset(1, 1),
//               ),
//             ],
//           ),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 32,
//                 backgroundImage: userProvider.photoURL.isNotEmpty
//                     ? NetworkImage(userProvider.photoURL)
//                     : AssetImage("assets/images/avatar.jpg") as ImageProvider,
//                 backgroundColor: AppColors.primary.withAlpha(51),
//               ),
//               if (isLoading)
//                 Container(
//                   width: 64,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     color: Colors.black45,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: CircularProgressIndicator(color: Colors.white),
//                   ),
//                 )
//               else
//                 Positioned.fill(
//                   child: CircleAvatar(
//                     radius: 32,
//                     backgroundColor: Colors.black45,
//                     child: InkWell(
//                       onTap: pickAndUploadImage,
//                       child: Icon(
//                         Icons.add_a_photo,
//                         size: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         SizedBox(width: 12.0),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               S.of(context).welcomeBack,
//               style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                 color: AppColors.primary.withAlpha(200),
//               ),
//             ),
//             Text(
//               userProvider.displayName,
//               style: Theme.of(context).textTheme.displayLarge,
//             ),
//           ],
//         ),
//         Spacer(),
//         if (isAdmin)
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
//               boxShadow: AppShadows.primaryShadow,
//             ),
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/admindashboardscreen');
//               },
//               color: Colors.red,
//               icon: Icon(Icons.dashboard, size: 28),
//             ),
//           ),
//         SizedBox(width: 5),
//         NotificationButton(userId: FirebaseAuth.instance.currentUser!.uid),
//       ],
//     );
//   }
// }
