import 'package:flutter/material.dart';
import 'package:flutter_menu_dashboard/pages/home_page.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'bloc/pages_bloc.dart';

//bool isCollapsed = true;

class MenuDashBoardLayout extends StatefulWidget {
  @override
  _MenuDashBoardLayoutState createState() => _MenuDashBoardLayoutState();
}

class _MenuDashBoardLayoutState extends State<MenuDashBoardLayout>
    with SingleTickerProviderStateMixin {
  final PagesBloc pagesBloc = BlocProvider.getBloc<PagesBloc>();

  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);

  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/images/background.jpg",
            ),
            fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.79)),
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _menuScaleAnimation,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://cdn.vox-cdn.com/thumbor/HBsde0sGqhkCCvF4nlGwwqt48q0=/0x0:5000x2950/1200x675/filters:focal(2293x288:3093x1088)/cdn.vox-cdn.com/uploads/chorus_image/image/65018663/Base.0.jpg"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Pantheon",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ra’Horak, Targon",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    menuItem(Icons.dashboard, "Dashboard", false),
                    menuItem(Icons.message, "Messages", true),
                    menuItem(Icons.info, "Biography", false),
                    menuItem(Icons.event, "Events", false),
                    menuItem(Icons.thumb_up, "Likes", false),
                    SizedBox(
                      height: 50,
                    ),
                    menuItem(Icons.input, "Log out", false),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuItem(IconData iconData, String text, bool isActive) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              iconData,
              color: isActive ? Colors.white : Colors.grey[600],
              size: isActive ? 24 : 20,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontSize: isActive ? 18 : 16,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal
              ),
            ),
          ],
        ),
        SizedBox(
          height: 18,
        )
      ],
    );
  }

  Widget dashboard(context) {
    return StreamBuilder<bool>(
      stream: pagesBloc.outIsCollapsedStream,
      initialData: true,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else
          return AnimatedPositioned(
            duration: duration,
            top: 0,
            bottom: 0,
            left: snapshot.data ? 0 : 0.6 * screenWidth,
            right: snapshot.data ? 0 : -0.4 * screenWidth,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Material(
                animationDuration: duration,
                borderRadius: snapshot.data
                    ? null
                    : BorderRadius.all(Radius.circular(10)),
                elevation: 8,
                child: ClipRRect(
                  borderRadius: snapshot.data
                      ? BorderRadius.all(Radius.circular(0))
                      : BorderRadius.all(Radius.circular(10)),
                  child: HomePage(
                    animationController: _controller,
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
}
