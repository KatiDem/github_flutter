import '../../base/bloc.dart';
import '../search/search_screen.dart';

abstract class SplashBloc extends Bloc {
  factory SplashBloc() => _SplashBloc();
}

class _SplashBloc extends BlocImpl implements SplashBloc {
  _SplashBloc();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
   await Future.delayed(const Duration(seconds: 1));
   appNavigator.popAndPush(
     SearchScreen.page(
       SearchScreenArguments(),
     ),
   );
  }
}
