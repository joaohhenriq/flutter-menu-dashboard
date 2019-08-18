import 'package:flutter/material.dart';
import 'package:flutter_menu_dashboard/model/profile.dart';

class ProfilePageView extends StatefulWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _slideAnimation;
  Animation _fadeAnimation;
  int currentIndex = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _slideAnimation = TweenSequence([
      // o weight é a porcentagem que a animação vai rodar baseado na duração do controller
      // por exemplo, o movimento de descida do widget vai durar 10% de 500, e o de subida
      // vai durar 90%
      TweenSequenceItem<Offset>(
        weight: 20,
        tween: Tween(
          begin: Offset(0, 0),
          end: Offset(0, 1),
        ),
      ),
      TweenSequenceItem<Offset>(
        weight: 80,
        tween: Tween(
          begin: Offset(0, 1),
          end: Offset(0, 0),
        ),
      ),
    ]).animate(_controller);

    _fadeAnimation = TweenSequence([
      TweenSequenceItem<double>(
        weight: 20,
        tween: Tween(
          begin: 1,
          end: 0,
        ),
      ),
      TweenSequenceItem<double>(
        weight: 80,
        tween: Tween(
          begin: 0,
          end: 1,
        ),
      ),
    ]).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: widget._pageController,
          pageSnapping: true,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
              _controller.reset();
              _controller.forward();
            });
          },
          scrollDirection: Axis.horizontal,
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  color: Colors.black,
                  child: Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      )),
                ),
                Image.asset(
                  profiles[index].imagePath,
                  fit: BoxFit.cover,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 40,
          left: 25,
          right: 25,
          child: ProfileDetails(
            index: currentIndex,
            slideAnimation: _slideAnimation,
            fadeAnimation: _fadeAnimation,
          ),
        ),
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final int index;
  final Animation slideAnimation;
  final Animation fadeAnimation;

  ProfileDetails({this.index, this.slideAnimation, this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            itemColumn(
              profiles[index].followers.toString(),
              "Followers",
              CrossAxisAlignment.start,
            ),
            itemColumn(
              profiles[index].posts.toString(),
              "Posts",
              CrossAxisAlignment.center,
            ),
            itemColumn(
              profiles[index].following.toString(),
              "Following",
              CrossAxisAlignment.end,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemColumn(String firstText, String secondText,
      CrossAxisAlignment crossAxisAlignment) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Text(
          firstText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          secondText,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
