import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nux_wallpapers/screens/category_content.dart';
import 'package:nux_wallpapers/screens/favorite_content.dart';
import 'package:nux_wallpapers/screens/home_content.dart';
import 'package:nux_wallpapers/screens/settings.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:nux_wallpapers/bloc/change_theme_bloc.dart';
import 'package:nux_wallpapers/bloc/change_theme_state.dart';


class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  PageController pageController = PageController();

  void changePage(int index) {
    setState(() {
       currentIndex = index;
    });
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
  
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: changeThemeBloc,
      builder: (BuildContext context, ChangeThemeState state) {
        return Theme(
          data: state.themeData,
          child: Scaffold(
            backgroundColor: state.themeData.backgroundColor,
            body: PageView(
              physics: BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
              children: <Widget>[
                HomeContent(),
                CategoryContent(),
                FavoriteContent(),
            ]),
            
            appBar: AppBar(
              title: Text("Nux Wallpapes"),
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.all(16),
                  icon: Icon(Icons.settings),
                  onPressed: (){
                    Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Settings()),
                    );
                  },
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){},
              child: Icon(Icons.search, color: Colors.purple),
              backgroundColor: Colors.white,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BubbleBottomBar(
              opacity: .2,
              currentIndex: currentIndex,
              onTap: changePage,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              elevation: 8,
              hasNotch: true,
              fabLocation: BubbleBottomBarFabLocation.end,
              items: <BubbleBottomBarItem>[
                BubbleBottomBarItem(
                  backgroundColor: Colors.purple, 
                  icon: Icon(Icons.home, color: Colors.purple,), 
                  activeIcon: Icon(Icons.home, color: Colors.purple), 
                  title: Text("Home")
                ),
                BubbleBottomBarItem(
                  backgroundColor: Colors.purple, 
                  icon: Icon(Icons.folder_open,color: Colors.purple), 
                  activeIcon: Icon(Icons.folder, color: Colors.purple), 
                  title: Text("Categories")
                ),
                BubbleBottomBarItem(
                  backgroundColor: Colors.purple, 
                  icon: Icon(Icons.favorite_border, color: Colors.purple), 
                  activeIcon: Icon(Icons.favorite, color: Colors.purple),
                  title: Text("Favorite")
                )
              ],
            ),
          )
        );
      }
    );
  }
}