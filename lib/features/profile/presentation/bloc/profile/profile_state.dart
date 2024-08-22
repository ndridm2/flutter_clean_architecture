part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
}

class ProfileStateEmpty extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileStateLoading extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileStateError extends ProfileState {
  final String message;
  ProfileStateError(this.message);

  @override
  List<Object> get props => [
    message,
  ];
}
class ProfileStateLoadedProfile extends ProfileState {
  final List<Profile> allUsers;
  ProfileStateLoadedProfile(this.allUsers);

  @override
  List<Object> get props => [
    allUsers,
  ];
}
class ProfileStateLoadedDetailProfile extends ProfileState {
  final Profile user;
  ProfileStateLoadedDetailProfile(this.user);

  @override
  List<Object> get props => [
    user,
  ];
}
