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
  double width = 100;

  void _setScrollbar(index) {
    selectedIndex = index;
    double totalWidth = 15 * width;
    if (totalWidth - (index * width) <= 300) {}
    _controller.animateTo(_controller.position.minScrollExtent + (index * 100),
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    setState(() {});
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
                    itemBuilder: (BuildContext context, int index) => Container(
                        alignment: Alignment.centerLeft,
                        width: index == 14 ? deviceSize.width : width,
                        color: Colors.black,
                        child: TextButton(
                            onPressed: () => _setScrollbar(index),
                            child: Text(
                              "Item $index",
                              style: TextStyle(
                                  fontWeight: selectedIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: selectedIndex == index ? 22 : 20),
                            ))),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  "Content of Item : $selectedIndex",
                  style: const TextStyle(
                      fontSize: 22,color: Colors.white, fontWeight: FontWeight.bold),
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
