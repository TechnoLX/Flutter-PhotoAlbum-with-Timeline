import 'package:flutter/material.dart';
import 'dart:math';

import 'package:valentineAlb/model/sweetMemo_model.dart';

class PhotoAlbum extends StatefulWidget {
  final MemoDetails photo;
  PhotoAlbum(this.photo);

  @override
  _PhotoAlbumState createState() => _PhotoAlbumState(photo);
}

var cardAspectRatio = 12.0 / 20.0;
var widgetAspectRatio = cardAspectRatio * 1.2;
var currentPage;

List<String> images = [];

class _PhotoAlbumState extends State<PhotoAlbum> {
  MemoDetails photo;

  _PhotoAlbumState(this.photo);
  var currentPage = 3 - 1.0;

  @override
  void dispose() {
    images.remove(photo.sweetPhoto['photo1']);
    images.remove(photo.sweetPhoto['photo2']);
    images.remove(photo.sweetPhoto['photo3']);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 3 - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    if (images.isEmpty) {
      images.add(photo.sweetPhoto['photo1']);
      images.add(photo.sweetPhoto['photo2']);
      images.add(photo.sweetPhoto['photo3']);
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sweet Album'),
        backgroundColor: Colors.pinkAccent[100],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                    child: PageView.builder(
                  itemBuilder: (context, index) {
                    return Container();
                  },
                  controller: controller,
                  itemCount: images.length,
                )),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: size.width * 0.9,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.pinkAccent[100],
              ),
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(photo.title),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    photo.sweetMemo,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = List();

          for (var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(
                          images[i],
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
