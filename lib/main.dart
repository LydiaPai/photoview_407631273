import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
void main() => runApp(MyApp());

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
  Widget build(BuildContext context) {
    //建立AppBar
    final appBar = AppBar(
      title: Text('Gridview'),
    );

    final btn = RaisedButton(
      child: Text('開啟Photoview'),
      onPressed: ()=>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SecondPage())),
    );


    final widget =  GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[

        Image.asset("assets/image_1.png"),

        Image.asset("assets/image_2.png"),

        Image.asset("assets/image_3.png"),

        Image.asset("assets/image_4.png"),

        Image.asset("assets/image_5.png"),

        Image.asset("assets/image_6.png"),

        Image.asset("assets/image_7.png"),

        Image.asset("assets/image_8.png"),

        Container(
          child: btn,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(30),
        ),
      ],
    );


//結合AppBar 和 App操作畫面
    final page = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return page;
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //建立AppBar
    final appBar = AppBar(
      title: Text('Photoview'),
    );

    const images = <String>[
      'assets/image_1.png',
      'assets/image_2.png',
      'assets/image_3.png',
      'assets/image_4.png',
      'assets/image_5.png',
      'assets/image_6.png',
      'assets/image_7.png',
      'assets/image_8.png',
    ];

    var imgBrowser = _ImageBrowser(GlobalKey<_ImageBrowserState>(), images);

    //建立App操作畫面
    final previousBtn = FlatButton(
      child: Image.asset('assets/previous.png'),
      onPressed: () {
        imgBrowser.previousImage();
      },
    );

    final nextBtn = FlatButton(
      child: Image.asset('assets/next.png'),
      onPressed: () {
        imgBrowser.nextImage();
      },
    );

    final widget = Center(
      child: Stack(children: <Widget>[
        Container(
          child: imgBrowser,
        ),
        Container(
          child: Row(
            children: <Widget>[previousBtn, nextBtn],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
      ],
        alignment: Alignment.topCenter,
      ),
    );

    //結合AppBar和App操作畫面
    final page = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return page;
  }
}

class _ImageBrowser extends StatefulWidget {
  final GlobalKey<_ImageBrowserState> _key;
  List<String> _images;
  int _imageIndex;

  _ImageBrowser(this._key, this._images) : super(key: _key) {
    _imageIndex = 0;
  }

  @override
  State<StatefulWidget> createState() => _ImageBrowserState();

  previousImage() => _key.currentState.previousImage();
  nextImage() => _key.currentState.nextImage();
}

class _ImageBrowserState extends State<_ImageBrowser> {
  @override
  Widget build(BuildContext context) {
    var img = PhotoView(
        imageProvider: AssetImage(widget._images[widget._imageIndex]),
        minScale: PhotoViewComputedScale.contained * 0.6,
        maxScale: PhotoViewComputedScale.covered,
        enableRotation: false,
        backgroundDecoration: BoxDecoration(
          color: Colors.blue,
        ));
    return img;
  }

  previousImage() {
    widget._imageIndex = widget._imageIndex == 0
        ? widget._images.length - 1
        : widget._imageIndex - 1;
    setState(() {});
  }

  nextImage() {
    widget._imageIndex = ++widget._imageIndex % widget._images.length;
    setState(() {});
  }
}