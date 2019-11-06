import 'package:flutter/material.dart';
import 'package:auto_waste/model/User.dart';
import 'package:auto_waste/ui/widgets/common_divider.dart';
import 'package:auto_waste/ui/widgets/common_scaffold.dart';
import 'package:auto_waste/ui/widgets/profile_tile.dart';

class ProfileOnePage extends StatelessWidget {
  var deviceSize;
  User user;
  ProfileOnePage({this.user});

  //Column1
  Widget profileColumn() => Container(
        height: deviceSize.height * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileTile(
              title: user.title,
              subtitle: user.subtitle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.chat),
                  color: Colors.black,
                  onPressed: () {},
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: Colors.black,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        user.image),
                    foregroundColor: Colors.black,
                    radius: 40.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      );

  //column2

  //column3
  Widget descColumn() => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              "Google Developer Expert",
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );
  //column4
  Widget accountColumn() => Container(
        height: deviceSize.height * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
           child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Website",
                  subtitle: user.items[0],
                ),
                ProfileTile(
                  title: "Phone",
                  subtitle: user.items[1],
                ),
                ProfileTile(
                  title: "YouTube",
                  subtitle: user.items[2],
                ),
              ],
            ),),
            Expanded(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Location",
                  subtitle: user.items[3],
                ),
                ProfileTile(
                  title: "Email",
                  subtitle: user.items[4],
                ),
                ProfileTile(
                  title: "Facebook",
                  subtitle: user.items[5],
                ),
              ],
            ),),
          ],
        ),
      );

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          profileColumn(),
          CommonDivider(),
          followColumn(deviceSize),
          CommonDivider(),
          descColumn(),
          CommonDivider(),
          accountColumn(),
          CommonDivider(),
          SizedBox(height: 20.0)
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "Profile",
        bodyData: bodyData(),
        showFAB: true,
        showDrawer: false,
        floatingIcon: Icons.person_add,
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }
}

Widget followColumn(Size deviceSize) => Container(
      height: deviceSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ProfileTile(
            title: "1.5K",
            subtitle: "Posts",
          ),
          ProfileTile(
            title: "2.5K",
            subtitle: "Followers",
          ),
          ProfileTile(
            title: "10K",
            subtitle: "Comments",
          ),
          ProfileTile(
            title: "1.2K",
            subtitle: "Following",
          )
        ],
      ),
    );
