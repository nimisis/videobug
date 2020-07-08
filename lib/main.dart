import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var videoPlayerController;
  var chewieController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network("https://api.st-helens.org.uk/v1.0/downloads/video-download/436384774");

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      //aspectRatio: 16.0/9.0,//widget.aspectRatio, //TODO not all videos will be this.
      autoPlay: true,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child:Column(
              children: [
                Chewie(
                  controller: chewieController,
                ),
                Expanded(child:Container(
                    height: 200,
                    width: double.infinity,
                    child:InAppWebView(
                  initialUrl: "https://www.biblegateway.com/passage/?search=Salmos+2&version=ESV&interface=print",
                  initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        debuggingEnabled: false,
                      ),
                      android: AndroidInAppWebViewOptions(
                          cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK
                      )
                  ),
                )
                )
                )
              ]
          )
      )
    );
  }
}
