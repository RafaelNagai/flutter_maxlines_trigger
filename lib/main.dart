import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mytext =
      "I have found that in RichText, there is a RenderParagraph renderObject , which has a private property TextPainter _textPainter which has a bool didExceedMaxLines. In short, I just need to access richText.renderObject._textPainter.didExceedMaxLines but as you can see, it is made private with the underscore.";

  @override
  Widget build(BuildContext context) {
    int maxLines = 3;
    double fontSize = 30.0;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          LayoutBuilder(builder: (context, size) {
            // Build the textspan
            var span = TextSpan(
              text: mytext,
              style: TextStyle(fontSize: fontSize),
            );

            // Use a textpainter to determine if it will exceed max lines
            var tp = TextPainter(
              maxLines: maxLines,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              text: span,
            );

            // trigger it to layout
            tp.layout(maxWidth: size.maxWidth);

            // whether the text overflowed or not
            var exceeded = tp.didExceedMaxLines;

            return Column(children: <Widget>[
              Text.rich(
                span,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
              ),
              Text(exceeded ? "Overflowed!" : "Not overflowed yet.")
            ]);
          }),
        ],
      ),
    );
  }
}
