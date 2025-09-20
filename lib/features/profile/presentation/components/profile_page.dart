import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  final String name;
  final String phone;
   String? photoUrl;
   ProfilePage({super.key,
    required this.name,
    required this.phone,
     this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: const [

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 24),
                _buildInfoTile(Icons.person_outline, name ),
                _buildInfoTile(Icons.phone_outlined, phone),
                _buildInfoTile(Icons.email_outlined, FirebaseAuth.instance.currentUser?.email ?? "no email"),
                const SizedBox(height: 24),
                const Text(
                  'Linked Accounts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // _buildUnlinkButton(
                //   'Google',
                //   "assets/images/google.png" ,
                //   Colors.red,
                // ),
              ],
            ),
        ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 16),
          Icon(icon, size: 24),
        ],
      ),
    );
  }

  // Widget _buildUnlinkButton(String text, String assetName, Color color) {
  //   return ElevatedButton(
  //     onPressed: () {
  //       // Unlink functionality would go here
  //     },
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Colors.white,
  //       foregroundColor: color,
  //       side: BorderSide(color: color),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Image.asset(
  //             assetName,
  //             width: 72,
  //             height: 25,
  //           ),
  //           const Text('Unlink'),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
