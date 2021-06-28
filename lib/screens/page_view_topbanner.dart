import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageviewBanner extends StatefulWidget {
  static List imagess = [];
  @override
  _PageviewBannerState createState() => _PageviewBannerState();
}

class _PageviewBannerState extends State<PageviewBanner> {
  String id;
  int _currentPage = 0;
  int index;
  int indexcategory;
  var isLoading = false;
  PageController _pagecontroller;

  void _onscroll() {}

  @override
  void initState() {
    _pagecontroller = PageController(initialPage: 0, viewportFraction: 1)
      ..addListener(_onscroll);
    super.initState();
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
    super.dispose();
  }

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : PageView.builder(
            onPageChanged: _onchanged,
            itemCount: PageviewBanner.imagess.length,
            controller: _pagecontroller,
            itemBuilder: (context, i) => Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3, right: 3, bottom: 8),
                  child: makepage(PageviewBanner.imagess[i]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 8, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List<Widget>.generate(
                          PageviewBanner.imagess.length,
                          (int index) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: 10,
                              width: (index == _currentPage) ? 30 : 10,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (index == _currentPage)
                                      ? Colors.white
                                      : Theme.of(context).buttonColor),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Widget makepage(String image) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).accentColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
    );
  }
}
