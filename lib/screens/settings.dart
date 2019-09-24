import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nux_wallpapers/bloc/change_theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nux_wallpapers/bloc/change_theme_state.dart';

class Settings extends StatefulWidget {

  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int option;
  final List<Color> colors = [Colors.white, Color(0xff323639), Colors.black];
  final List<Color> borders = [Colors.purple, Colors.purple, Colors.purple];
  final List<String> themes = ['Light', 'Dark', 'Amoled'];
  final List<String> description = ['White - Purple', 'Black - Purple', 'BlueGrey - Blue'];


  @override
  void initState() {
    super.initState();
  }

  void changeTheme(int index){
    setState(() {
     option = index;
     switch(index){
       case 0:
        changeThemeBloc.onLightThemeChange();
        break;
      case 1:
        changeThemeBloc.onDarkThemeChange();
        break;
      case 2:
        changeThemeBloc.onAmoledThemeChange();
        break;
     }
    });
  }
  _aboutDialog() {
    var size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          contentPadding: EdgeInsets.only(top: 15.0),
          content: Container(
            width: size.width*0.9,
            height: size.height*0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/n2.png',width: 75.0),
                    SizedBox(height: 10),
                    Text('Nux Wallpapers', style: TextStyle( color: Colors.black, fontSize: 27)),
                    SizedBox(height: 5),
                    Text("Version 1.0.0"),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.all(10.5),
                      child: Text("Gallery of offline wallpapers, with a variety of images and categories, designed for all audiences."),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: (){Navigator.pop(context);},
              elevation: 2.5,
              padding: EdgeInsets.all(10),
              color: Colors.black,
              textColor: Colors.white,
              splashColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(" Ok "),
            )
          ]
        );
      }
    );
  }

  _modalTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    option = preferences.get('theme_option') ?? 0;

    showModalBottomSheet(
      context: context,
      builder: (builder){
        return BlocBuilder(
          bloc: changeThemeBloc, 
          builder: (BuildContext context, ChangeThemeState state) {
            return Container(
              height: 300.0,
              color: Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15,left: 15, bottom: 25),
                      child: Text("Select your theme:", style: TextStyle( color: Colors.black, fontSize: 24)),
                    ),
                    ListTile(
                      title: Text(themes[0], style: TextStyle(color: Colors.black,fontSize: 18)),
                      subtitle: Text(description[0],style: TextStyle(color: Colors.blueGrey,fontSize: 15)),
                      leading: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: borders[0]),
                          color: colors[0]
                        ),
                        child: option==0 ? Icon(Icons.check, color: state.themeData.accentColor) : null,
                      ),
                      onTap: (){changeTheme(0);}
                    ),
                    ListTile(
                      title: Text(themes[1], style: TextStyle(color: Colors.black,fontSize: 18)),
                      subtitle: Text(description[1],style: TextStyle(color: Colors.blueGrey,fontSize: 15)),
                      leading: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: borders[1]),
                          color: colors[1]
                        ),
                        child: option==1 ? Icon(Icons.check, color: state.themeData.accentColor) : null,
                      ),
                      onTap: (){changeTheme(1);}
                    ),
                    ListTile(
                      title: Text(themes[2], style: TextStyle(color: Colors.black,fontSize: 18)),
                      subtitle: Text(description[2],style: TextStyle(color: Colors.blueGrey,fontSize: 15)),
                      leading: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: borders[2]),
                          color: colors[2]
                        ),
                        child: option==2 ? Icon(Icons.check, color: state.themeData.accentColor) : null,
                      ),
                      onTap: (){changeTheme(2);}
                    )
                  ],
                )
              )
            );
          }
        );
      }
    );
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
            appBar: AppBar(
              title: Text("Settings"),
            ),
            body: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.brightness_6, color: state.themeData.accentColor),
                    title: Text("Theme",style: state.themeData.textTheme.body2),
                    onTap: (){_modalTheme();},
                    trailing: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4, color: state.themeData.accentColor),
                        color: state.themeData.primaryColor),
                    )
                  ),
                  ListTile(
                    leading: Icon(Icons.accessibility, color: state.themeData.accentColor),
                    title: Text(
                      'Privacy Policies',
                      style: state.themeData.textTheme.body2,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: state.themeData.accentColor),
                    title: Text('About Of', style: state.themeData.textTheme.body2),
                    onTap: (){_aboutDialog();},
                  ),
                  Spacer(),
                  Text("Nux Wallpapers Version 1.0.0", style: TextStyle(color: Colors.grey, fontSize: 15))
                ],
              )
            ),
            /*body: Container(
              color: state.themeData.backgroundColor,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.brightness_4),
                    title: Text(
                      'Theme',
                      style: state.themeData.textTheme.body2,
                    ),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2, color: state.themeData.accentColor),
                          color: state.themeData.primaryColor),
                    ),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      option = preferences.get('theme_option') ?? 0;
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return BlocBuilder(
                              bloc: changeThemeBloc,
                              builder: (BuildContext context,
                                  ChangeThemeState state) {
                                return AlertDialog(
                                  backgroundColor: state.themeData.primaryColor,
                                  title: Text(
                                    'Change Theme',
                                    style: state.themeData.textTheme.body1,
                                  ),
                                  content: SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Stack(
                                            children: <Widget>[
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              width: 2,
                                                              color: borders[
                                                                  index]),
                                                          color: colors[index]),
                                                    ),
                                                  ),
                                                  Text(themes[index],
                                                      style: state.themeData
                                                          .textTheme.body2)
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          switch (index) {
                                                            case 0:
                                                              changeThemeBloc
                                                                  .onLightThemeChange();
                                                              break;
                                                            case 1:
                                                              changeThemeBloc
                                                                  .onDarkThemeChange();
                                                              break;
                                                            case 2:
                                                              changeThemeBloc
                                                                  .onAmoledThemeChange();
                                                              break;
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        child: state.themeData
                                                                    .primaryColor ==
                                                                colors[index]
                                                            ? Icon(Icons.done,
                                                                color: state
                                                                    .themeData
                                                                    .accentColor)
                                                            : Container(),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(themes[index],
                                                      style: state.themeData
                                                          .textTheme.body2)
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text(
                      'About',
                      style: state.themeData.textTheme.body2,
                    ),
                  ),
                ],
              )
            ),*/
          )
        );
      }
    );
  }
}