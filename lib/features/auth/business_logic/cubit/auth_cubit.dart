import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker_app/features/auth/business_logic/auth_repo.dart';
import 'package:weight_tracker_app/features/auth/model/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo ;
  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final User ? user = await authRepo.signInWithGoogle();
    if (user != null){
      emit(AuthSuccess(user));
    }else{
      emit(AuthFailure("Google sign-in failed."));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    await authRepo.signOut();
    emit(AuthSignedOut());
  }

  Future<User?> checkUser() async {
   return await authRepo.getCurrentUser();
  }
  

}
