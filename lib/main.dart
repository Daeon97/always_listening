// import 'package:afta_sale_mobile/app.dart';
// import 'package:afta_sale_mobile/app_bloc_observer.dart';
// import 'package:afta_sale_mobile/injection_container.dart'
//     show registerServices;
import 'package:always_listening/app.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';

void main() => initializeImportanceResources().then(
      (_) => runApp(
        const App(),
      ),
    );

Future<void> initializeImportanceResources() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  // Registers our services
  // registerServices();

  // Registers an observer for our BLoCs
  // Bloc.observer = const AppBlocObserver();
}
