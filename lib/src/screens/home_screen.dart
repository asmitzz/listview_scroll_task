import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  int selectedIndex = 0;
  late Size deviceSize;

  final List<ItemWidth> itemsWidth = [];

  final arr = [2, 3, 5, 6];

  getScrollWidth(int index) {
    double width = 0;
    for (var i = 0; i < index; i++) {
      width += itemsWidth[i].width;
    }
    return width;
  }

  void _setScrollbar(index, itemWidth) {
    selectedIndex = index;
    _controller.animateTo(getScrollWidth(index) - 5,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    setState(() {});
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black54,
            height: deviceSize.height,
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                  child: ListView.builder(
                    controller: _controller,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      final Size txtSize = _textSize(
                          index % 2 == 0
                              ? "Item $index"
                              : "item item item item $index",
                          TextStyle(
                              fontWeight: selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: Colors.black,
                              fontSize: selectedIndex == index ? 22 : 20));

                      if (itemsWidth
                          .where((ItemWidth element) => element.id == index)
                          .isEmpty) {
                        itemsWidth.add(ItemWidth(index, (txtSize.width+16)));
                      }

                      return TextButton(
                          style: TextButton.styleFrom(padding:const EdgeInsets.symmetric(horizontal: 8)),
                          onPressed: () => _setScrollbar(index, txtSize.width),
                          child: SizedBox(
                            width:
                                index == 14 ? deviceSize.width : txtSize.width,
                            child: Text(
                              index % 2 == 0
                                  ? "Item $index"
                                  : "item item item item $index",
                              style: TextStyle(
                                  fontWeight: selectedIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: selectedIndex == index ? 22 : 20),
                            ),
                          ));
                    },
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  "Content of Item : $selectedIndex",
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemWidth {
  final int id;
  final double width;

  ItemWidth(this.id, this.width);
}
