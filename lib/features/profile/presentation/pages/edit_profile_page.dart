import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioTextController = TextEditingController();

  void updateBioButton() async {
    final profileCubit = context.read<ProfileCubit>();
    if (bioTextController.text.isNotEmpty) {
      profileCubit.updateUserProfile(
        uid: widget.user.uid,
        newBio: bioTextController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfilLouded) {
          return Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is ProfileLouding) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: updateBioButton,
                  icon: Icon(Icons.upload),
                ),
              ],
            ),
            body: Column(
              children: [
                Text('BIO'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(controller: bioTextController),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
