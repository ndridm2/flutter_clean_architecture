import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection.dart';

import '../../domain/entities/profile.dart';
import '../bloc/profile/profile_bloc.dart';

class DetailProfilePage extends StatelessWidget {
  final int userId;
  const DetailProfilePage(
    this.userId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: injection<ProfileBloc>()
          ..add(ProfileEventGetDetailProfile(userId)),
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileStateError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileStateLoadedDetailProfile) {
            Profile profile = state.user;
            return Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(profile.profileImageUrl),
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: Column(
                        children: [
                          Text("ID :  ${profile.id}"),
                          Text(profile.email),
                          Text(profile.fullName),
                        ],
                    ))
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("Empty data"));
          }
        },
      ),
    );
  }
}
