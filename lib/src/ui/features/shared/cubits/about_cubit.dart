import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'about_state.dart';

/// The state manager responsible for providing information
/// about the app.
class AboutCubit extends Cubit<AboutState> {
  /// Creates a new instance of [AboutCubit].
  AboutCubit() : super(AboutState());

  /// Fetches the app details.
  Future<void> fetchAppDetails() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    emit(AboutState(appName: info.appName, appVersion: info.version));
  }
}
