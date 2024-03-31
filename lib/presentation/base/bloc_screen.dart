import 'package:flutter/material.dart';
import '../navigation/base_arguments.dart';
import 'bloc.dart';

abstract class BlocScreenState<SW extends StatefulWidget, B extends Bloc> extends State<SW>
    with WidgetsBindingObserver {
  BlocScreenState(this.bloc);

  @protected
  final B bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
    bloc.dispose();
    _getArgs();
  }

  void _getArgs() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settings = ModalRoute.of(context)?.settings;
      if (settings != null) {
        final arguments = settings.arguments;
        if (arguments is BaseArguments) {
          bloc.initArgs(arguments);
        }
      }
    });
  }
}
