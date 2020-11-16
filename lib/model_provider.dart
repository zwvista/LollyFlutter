import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/viewmodels/wordsunitviewmodel.dart';

// InheritedWidgets allow you to propagate values down the Widget Tree.
// it can then be accessed by just writing  TheViewModel.of(context)
class ModelProvider extends InheritedWidget {
  final WordsUnitViewModel model;

  const ModelProvider({Key key, @required this.model, @required Widget child})
      : assert(model != null),
        assert(child != null),
        super(key: key, child: child);

  static WordsUnitViewModel of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<ModelProvider>()).model;

  @override
  bool updateShouldNotify(ModelProvider oldWidget) => model != oldWidget.model;
}
