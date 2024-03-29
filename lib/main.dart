import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Provide the model to all widgets within the app. We're using
    // ChangeNotifierProvider because that's a simple way to rebuild
    // widgets when a model changes. We could also just use
    // Provider, but then we would have to listen to Counter ourselves.
    //
    // Read Provider's docs to learn about all the available providers.
    ChangeNotifierProvider(
      // Initialize the model in the builder. That way, Provider
      // can own Counter's lifecycle, making sure to call `dispose`
      // when not needed anymore.
      builder: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does
/// _not_ depend on Provider.
class Counter with ChangeNotifier {
  int value1 = 0;
  int value2 = 0;

  void increment() {
    value1 += 1;
    print(value1);
    notifyListeners();
  }

  void incrementdouble() {
    value2 += 2;
    print(value2);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            // Consumer looks for an ancestor Provider widget
            // and retrieves its model (Counter, in this case).
            // Then it uses that model to build widgets, and will trigger
            // rebuilds if the model is updated.
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                    'value1: ${counter.value1} \n value2: ${counter.value2} ',
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Consumer<Counter>(
              builder: (context, counter, child) => FloatingActionButton(
                    // Provider.of is another way to access the model object held
                    // by an ancestor Provider. By default, even this listens to
                    // changes in the model, and rebuilds the whole encompassing widget
                    // when notified.
                    //
                    // By using `listen: false` below, we are disabling that
                    // behavior. We are only calling a function here, and so we don't care
                    // about the current value. Without `listen: false`, we'd be rebuilding
                    // the whole MyHomePage whenever Counter notifies listeners.
                    onPressed: () => Provider.of<Counter>(
                          context,
                          listen: false,
                        ).increment(),
                    tooltip: 'Increment',
                    child: Text(
                      '+1',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    backgroundColor: Colors.red,
                  ),
            ),
            SizedBox(height: 10.0),
            FloatingActionButton(
              // Provider.of is another way to access the model object held
              // by an ancestor Provider. By default, even this listens to
              // changes in the model, and rebuilds the whole encompassing widget
              // when notified.
              //
              // By using `listen: false` below, we are disabling that
              // behavior. We are only calling a function here, and so we don't care
              // about the current value. Without `listen: false`, we'd be rebuilding
              // the whole MyHomePage whenever Counter notifies listeners.
              onPressed: () => Provider.of<Counter>(context, listen: false)
                  .incrementdouble(),
              tooltip: 'IncrementDouble',
              child: Text(
                '+2',
                style: TextStyle(fontSize: 20.0),
              ),
              backgroundColor: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
