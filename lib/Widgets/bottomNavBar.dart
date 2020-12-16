import 'package:api_call/Widgets/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final TabController _tabController;
  CustomBottomNavigationBar(this._tabController);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  AnimationController _xController;
  AnimationController _yController;
  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    const buttonCount = 4.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _icon(IconData icon, bool isEnable, int index) {
    return Container(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        alignment: isEnable ? Alignment.topCenter : Alignment.center,
        child: AnimatedContainer(
            height: isEnable ? 60 : 20,
            duration: Duration(milliseconds: 2000),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isEnable ? Colors.blue : Colors.white,
                shape: BoxShape.circle),
            child: Opacity(
              opacity: isEnable ? _yController.value : 1,
              child: Icon(icon,
                  color: isEnable
                      ? Colors.white
                      : Theme.of(context).iconTheme.color),
            )),
      ),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  void _handlePressed(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 1000));
    _yController.animateTo(1.0, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        width: appSize.width,
        height: 60,
        child: TabBar(
          onTap: (value) => _handlePressed(value),
          controller: widget._tabController,
          tabs: <Widget>[
            _icon(MyFlutterApp.newspaper, _selectedIndex == 0, 0),
            _icon(MyFlutterApp.local_movies, _selectedIndex == 1, 1),
            _icon(MyFlutterApp.cricket, _selectedIndex == 2, 2),
            _icon(MyFlutterApp.mobile, _selectedIndex == 3, 3),
          ],
        ));
  }
}
