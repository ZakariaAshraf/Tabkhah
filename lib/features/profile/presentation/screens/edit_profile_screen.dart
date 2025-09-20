import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
import '../Cubit/user_cubit.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getCurrentUserData();
    final user = context.read<UserCubit>().user;
    if (user != null) {
      fullNameController.text = user.name ?? '';
      phoneController.text = user.phone ?? '';
    }
  }

  // Future<void> selectImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
            Navigator.pop(context); // Go back to the Profile Screen
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                /// image section
                // Center(
                //   child: Stack(
                //     children: [
                //       CircleAvatar(
                //         radius: 60,
                //         backgroundImage: _image != null
                //             ? FileImage(_image!)
                //             : context.read<UserCubit>().user?.photoUrl != null
                //             ? NetworkImage(context.read<UserCubit>().user!.photoUrl)
                //             : const AssetImage("assets/images/Person.png") as ImageProvider,
                //       ),
                //       Positioned(
                //         bottom: 0,
                //         right: 0,
                //         child: IconButton(
                //           icon: const Icon(Icons.camera_alt),
                //           onPressed: (){},
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 24),
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: state is UserLoading
                      ? null
                      : () {
                    context.read<UserCubit>().updateProfile(
                      fullName: fullNameController.text,
                      phoneNumber: phoneController.text,
                      profilePicture: _image,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: state is UserLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 18,),
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