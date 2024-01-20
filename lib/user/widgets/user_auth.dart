import 'package:arbuz_dash/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class UserAuth extends StatelessWidget {
  const UserAuth({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        userRepository: context.read<UserRepository>(),
      )..add(const LoaderUserRequested()),
      child: child,
    );
  }
}
