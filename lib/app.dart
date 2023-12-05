import 'package:always_listening/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _providers,
        // look for a way to just 'watch' brightnessState
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      );

  List<BlocProvider> get _providers => [
        // BlocProvider<MaybeShowOnboardingCubit>(
        // create: (_) => sl(),
        // ),
        // BlocProvider<LoginCubit>(
        // create: (_) => sl(),
        // ),
      ];
}
