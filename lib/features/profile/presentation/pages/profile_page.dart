import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/profile.dart';
import '../bloc/profile/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: context.read<ProfileBloc>()..add(ProfileEventGetProfile(1)),
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            // loading
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileStateError) {
            // error
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileStateLoadedProfile) {
            // loaded
            List<Profile> allUsers = state.allUsers;
            return ListView.builder(
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                Profile profile = allUsers[index];
                return ListTile(
                  onTap: () {
                    context.pushNamed(
                      "detail_profile_page",
                      extra: profile.id,
                    );
                  },
                  title: Text(profile.fullName),
                );
              },
            );
          } else {
            // empty
            return const Center(child: Text('Empty Data'));
          }
        },
      ),
    );
  }
}
