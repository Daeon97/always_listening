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
          const StartOperation(),
        );
    super.initState();
  }

  @override
  void deactivate() {
    context.read<ApiCallsCounterBloc>().add(
          const StopOperation(),
        );
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
              ),
              Text(
                'Eren',
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Text(
              'Always Listening',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'This app is always listening to you. Every 10 seconds, we send that audio to our STT API. The last 3 transcripts will be shown on the screen. Additionally, we show a timer that indicates since when the app is listening.',
            ),
            Text(
              'API call counter',
            ),
            Text(
              'API call counter called times will show here',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 10,
            ),
            ListView.separated(
              itemCount: 3,
              separatorBuilder: (_, index) => const Divider(),
              itemBuilder: (_, index) => Text('Some text will show here'),
            ),
          ],
        ),
      );
}
