// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ateammt/state/settings_state.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:provider/provider.dart';

class SettingsScreenBase extends StatelessWidget {
  const SettingsScreenBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SettinsgState(), child: FormSample());
  }
}

class FormSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.grey,
        variantColor: Colors.black38,
        depth: 8,
        intensity: 0.65,
      ),
      themeMode: ThemeMode.light,
      child: Material(
        child: NeumorphicBackground(
          child: _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SettinsgState>(context, listen: true);

    Widget _switch(bool value, Function tap) {
      return GestureDetector(
        onTap: () {
          tap();
        },
        child: Container(
          width: 70,
          height: 25,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  offset: Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
              color: Color(
                0xffdbdbdb,
              ),
              borderRadius: BorderRadius.circular(10)),
          // borderRadius: 5,
          // primaryColor: Colors.grey,
          // borderThickness: 0,
          // depth: 10,
          // borderColor: Colors.grey,
          // curvature: Curvature.flat,
          // primaryColor: Color(0xffdbdbdb),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SizedBox(
              //   width: 2,
              // ),
              if (!value)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    // height: 60,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.8),
                          offset: Offset(-6.0, -6.0),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(6.0, 6.0),
                          blurRadius: 16.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: VerticalDivider(),
                    ),
                  ),
                ),
              if (value)
                Text(
                  "ON",
                  style: TextStyle(
                      color: Color(0xffd28785),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              SizedBox(
                width: 2,
              ),
              if (!value)
                Text(
                  "OFF",
                  style: TextStyle(
                      color: Color(0xffa4a4a4),
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),

              if (value)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    // height: 60,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color(0xfff0f0f0),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.8),
                          offset: Offset(-6.0, -6.0),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(6.0, 6.0),
                          blurRadius: 16.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: VerticalDivider(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    Widget _expansionTile(String title, Function tap, value, {bool isSub}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isSub ?? false)
              SizedBox(
                width: 10,
              ),
            Text(title ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: (isSub ?? false)
                      ? Colors.grey
                      : value
                          ? NeumorphicTheme.defaultTextColor(context)
                          : Colors.grey,
                )),
            Spacer(),
            _switch(value, tap)
          ],
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text("Notification Settings",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: NeumorphicTheme.defaultTextColor(context),
                )),
            SizedBox(
              height: 16,
            ),
            _expansionTile("Email Notification", () {
              state.emailTap(!state.emailClicked);
            }, state.emailClicked),
            if (state.emailClicked ?? false)
              Column(
                children: [
                  _expansionTile("Order Updates", () {}, true, isSub: true),
                  _expansionTile("Shipping Updates", () {}, true, isSub: true),
                  _expansionTile("Promotions", () {}, true, isSub: true),
                  _expansionTile("Offers", () {}, true, isSub: true),
                  _expansionTile("News", () {}, true, isSub: true),
                  _expansionTile("Messages", () {}, false, isSub: true),
                  _expansionTile("New Arrivals", () {}, true, isSub: true),
                ],
              ),
            _expansionTile("Push Notification", () {}, false),
            _expansionTile("Notification at Night", () {}, false),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        padding: EdgeInsets.all(10),
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
          depth: NeumorphicTheme.embossDepth(context),
        ),
        child: Icon(
          Icons.insert_emoticon,
          size: 120,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}

class _AgeField extends StatelessWidget {
  final double age;
  final ValueChanged<double> onChanged;

  _AgeField({@required this.age, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: NeumorphicSlider(
                  min: 8,
                  max: 75,
                  value: this.age,
                  onChanged: (value) {
                    this.onChanged(value);
                  },
                ),
              ),
            ),
            Text("${this.age.floor()}"),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

class _TextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  _TextField({@required this.label, @required this.hint, this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            this.widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextField(
            onChanged: this.widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: this.widget.hint),
          ),
        )
      ],
    );
  }
}
