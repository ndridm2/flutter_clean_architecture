import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failure.dart';

import '../../../domain/entities/profile.dart';
import '../../../domain/usecases/get_all_user.dart';
import '../../../domain/usecases/get_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUser getAllUser;
  final GetUser getUser;

  ProfileBloc(
    this.getAllUser,
    this.getUser,
  ) : super(ProfileStateEmpty()) {
    on<ProfileEventGetProfile>((event, emit) async {
      emit(ProfileStateLoading());
      Either<Failure, List<Profile>> result =
          await getAllUser.execute(event.page);
      result.fold(
        (leftGetProfiles) {
          emit(ProfileStateError("Cannot get profile"));
        },
        (rightGetProfiles) {
          emit(ProfileStateLoadedProfile(rightGetProfiles));
        },
      );
    });
    on<ProfileEventGetDetailProfile>((event, emit) async {
      emit(ProfileStateLoading());
      Either<Failure, Profile> result = await getUser.execute(event.userId);
      result.fold(
        (leftGetDetailProfile) {
          emit(ProfileStateError("Cannot get detail profile"));
        },
        (rightGetDetailProfile) {
          emit(ProfileStateLoadedDetailProfile(rightGetDetailProfile));
        },
      );
    });
  }
}
