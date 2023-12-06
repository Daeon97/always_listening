import 'package:always_listening/data/data_sources/local_data_source.dart';
import 'package:always_listening/data/data_sources/remote_data_source.dart';
import 'package:always_listening/data/repositories/create_wav_repository_impl.dart';
import 'package:always_listening/data/repositories/send_audio_wav_repository_impl.dart';
import 'package:always_listening/domain/repositories/create_wav_repository.dart';
import 'package:always_listening/domain/repositories/send_audio_wav_repository.dart';
import 'package:always_listening/domain/usecases/create_wav_use_case.dart';
import 'package:always_listening/domain/usecases/send_audio_wav_use_case.dart';
import 'package:always_listening/presentation/blocs/api_calls_counter_bloc/api_calls_counter_bloc.dart';
import 'package:always_listening/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: _repositoryProviders,
        child: MultiBlocProvider(
          providers: _blocProviders,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

  List<RepositoryProvider> get _repositoryProviders => [
        RepositoryProvider<LocalDataSource>(
          create: (_) => const LocalDataSourceImpl(),
        ),
        RepositoryProvider<RemoteDataSource>(
          create: (_) => const RemoteDataSourceImpl(),
        ),
        RepositoryProvider<CreateWavRepository>(
          create: (context) => CreateWavRepositoryImpl(
            RepositoryProvider.of<LocalDataSource>(
              context,
            ),
          ),
        ),
        RepositoryProvider<SendAudioWavRepository>(
          create: (context) => SendAudioWavRepositoryImpl(
            RepositoryProvider.of<RemoteDataSource>(
              context,
            ),
          ),
        ),
        RepositoryProvider<CreateWavUseCase>(
          create: (context) => CreateWavUseCaseImpl(
            RepositoryProvider.of<CreateWavRepository>(
              context,
            ),
          ),
        ),
        RepositoryProvider<SendAudioWavUseCase>(
          create: (context) => SendAudioWavUseCaseImpl(
            RepositoryProvider.of<SendAudioWavRepository>(
              context,
            ),
          ),
        ),
      ];

  List<BlocProvider> get _blocProviders => [
        BlocProvider<ApiCallsCounterBloc>(
          create: (context) => ApiCallsCounterBloc(
            createWavUseCase: RepositoryProvider.of<CreateWavUseCase>(
              context,
            ),
            sendAudioWavUseCase: RepositoryProvider.of<SendAudioWavUseCase>(
              context,
            ),
          ),
        ),
      ];
}
