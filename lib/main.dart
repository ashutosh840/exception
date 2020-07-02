import 'package:exception/Post/post.dart';
import 'package:exception/Post/post_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Post/Failure.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => PostChangeNotifier(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final postService = PostService();
  Future<Post> postFuture;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Consumer<PostChangeNotifier>(
          builder: (_, notifier, __) {
            if (notifier.state == NotifierState.initial) {
              return StyledText('Press the button 👇');
            } else if (notifier.state == NotifierState.loading) {
              return CircularProgressIndicator();
            } else {
              if (notifier.failure != null) {
                return StyledText(notifier.failure.exception.toString());
              } else {
                return StyledText(notifier.post.toString());
              }
            }
          },
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
          ),
        ),
        RaisedButton(
          child: Text("Check Error Handling"),
          onPressed: () async {
            Provider.of<PostChangeNotifier>(context,listen: false).getOnePost();
          },
        )
      ],
    ));
  }
}

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40),
    );
  }
}
