import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).myfavorites)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final favorites = snapshot.data!.docs;
          if (favorites.isEmpty) {
            return Center(child: Text(S.of(context).nofavorites));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final data = favorites[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    data['centerImageUrl'] ?? '',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(data['centerName'] ?? ''),
                subtitle: Text(data['centerLocation'] ?? ''),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .collection('favorites')
                        .doc(favorites[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
