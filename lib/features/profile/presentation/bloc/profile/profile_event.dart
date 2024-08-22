part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
}

class ProfileEventGetProfile extends ProfileEvent {
  final int page;
  ProfileEventGetProfile(this.page);

  @override
  
  List<Object?> get props => [
    page,
  ];
}

class ProfileEventGetDetailProfile extends ProfileEvent {
  final int userId;
  ProfileEventGetDetailProfile(this.userId);

  @override
  
  List<Object?> get props => [
    userId,
  ];
}

