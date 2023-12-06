import 'package:always_listening/presentation/blocs/api_calls_counter_bloc/api_calls_counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ApiCallsCounterBloc>().add(
          const StartOperationEvent(),
        );
    super.initState();
  }

  @override
  void deactivate() {
    context.read<ApiCallsCounterBloc>().add(
          const StopOperationEvent(),
        );
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Eren',
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                'Always Listening',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'This app is always listening to you.',
              ),
              const Text(
                'Every 10 seconds, we send that audio to our STT API.',
              ),
              const Text(
                'The last 3 transcripts will be shown on the screen.',
              ),
              const Text(
                'Additionally, we show a timer that indicates since when the app is listening.',
              ),
              const SizedBox(
                height: 64,
              ),
              const Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'API call counter',
                ),
              ),
              BlocBuilder<ApiCallsCounterBloc, ApiCallsCounterState>(
                builder: (_, apiCallsCounterState) => Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    switch (apiCallsCounterState) {
                      ApiCallsSuccessState(
                        :final count,
                        lastThreeResults: final _,
                      ) =>
                        '$count',
                      _ => '...'
                    },
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              BlocBuilder<ApiCallsCounterBloc, ApiCallsCounterState>(
                builder: (_, apiCallsCounterState) =>
                    switch (apiCallsCounterState) {
                  ApiCallsFailedState(
                    :final failure,
                  ) =>
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        failure.message,
                      ),
                    ),
                  ApiCallsSuccessState(
                    count: final _,
                    :final lastThreeResults,
                  ) =>
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lastThreeResults.length,
                      separatorBuilder: (_, index) => const Divider(),
                      itemBuilder: (_, index) => Text(
                        lastThreeResults[index].text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  _ => const Align(
                      alignment: AlignmentDirectional.center,
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    )
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      );
}
