import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/homepage/widgets/my_drawer_tile.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                  size: 88,
                ),
              ),

              Divider(color: Theme.of(context).colorScheme.secondary),

              MyDrawerTile(
                title: 'H O M E',
                icon: Icons.home,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),

              MyDrawerTile(
                title: 'P R O F I L E',
                icon: Icons.home,
                onTap: () {
                  final user = context.read<AuthCubit>().currentuser;
                  String? uid = user!.uid;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(uid: uid),
                    ),
                  );
                },
              ),

              MyDrawerTile(
                title: 'S E A R C H',
                icon: Icons.home,
                onTap: () {},
              ),

              MyDrawerTile(
                title: 'S E T T I N G',
                icon: Icons.home,
                onTap: () {},
              ),

              const Spacer(),

              MyDrawerTile(
                title: 'L O G O U T',
                icon: Icons.home,
                onTap: () {
                  context.read<AuthCubit>().logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
