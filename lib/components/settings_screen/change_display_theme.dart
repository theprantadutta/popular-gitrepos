import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../constants/selectors.dart';
import '../../main.dart';
import '../settings_screen/settings_menu_row_layout.dart';

List<FlexScheme> kAllFlexSchemes = [
  FlexScheme.amber,
  FlexScheme.aquaBlue,
  FlexScheme.bahamaBlue,
  FlexScheme.barossa,
  FlexScheme.bigStone,
  FlexScheme.blue,
  FlexScheme.blueM3,
  FlexScheme.blueWhale,
  FlexScheme.blumineBlue,
  FlexScheme.brandBlue,
  FlexScheme.cyanM3,
  FlexScheme.damask,
  FlexScheme.deepBlue,
  FlexScheme.dellGenoa,
  FlexScheme.ebonyClay,
  FlexScheme.espresso,
  FlexScheme.flutterDash,
  FlexScheme.gold,
  FlexScheme.green,
  FlexScheme.greenM3,
  FlexScheme.hippieBlue,
  FlexScheme.indigo,
  FlexScheme.indigoM3,
  FlexScheme.jungle,
  FlexScheme.limeM3,
  FlexScheme.mallardGreen,
  FlexScheme.mandyRed,
  FlexScheme.mango,
  FlexScheme.material,
  FlexScheme.materialBaseline,
  FlexScheme.materialHc,
  FlexScheme.money,
  FlexScheme.deepOrangeM3,
  FlexScheme.orangeM3,
  FlexScheme.outerSpace,
  FlexScheme.pinkM3,
  FlexScheme.purpleBrown,
  FlexScheme.purpleM3,
  FlexScheme.redM3,
  FlexScheme.red,
  FlexScheme.redWine,
  FlexScheme.rosewood,
  FlexScheme.sakura,
  FlexScheme.sanJuanBlue,
  FlexScheme.shark,
  FlexScheme.verdunHemlock,
  FlexScheme.tealM3,
  FlexScheme.vesuviusBurn,
  FlexScheme.wasabi,
  FlexScheme.yellowM3,
];

class ChangeDisplayTheme extends StatefulWidget {
  const ChangeDisplayTheme({super.key});

  @override
  State<ChangeDisplayTheme> createState() => _ChangeDisplayThemeState();
}

class _ChangeDisplayThemeState extends State<ChangeDisplayTheme> {
  FlexScheme _dropdownValue = kDefaultFlexScheme;

  @override
  void initState() {
    setState(() {
      _dropdownValue = MyApp.of(context).flexScheme;
    });
    super.initState();
  }

  void handleThemeChange(FlexScheme? value) {
    setState(() {
      _dropdownValue = value!;
      MyApp.of(context).changeFlexScheme(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return SettingsMenuRowLayout(
      title: 'Change Theme',
      iconData: Icons.palette_outlined,
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 5.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton<FlexScheme>(
          value: _dropdownValue,
          icon: Icon(
            Icons.arrow_downward,
            color: kPrimaryColor,
          ),
          elevation: 16,
          style: TextStyle(color: kPrimaryColor),
          underline: Container(
            height: 2,
            color: kPrimaryColor,
          ),
          onChanged: handleThemeChange,
          items: kAllFlexSchemes
              .map<DropdownMenuItem<FlexScheme>>((FlexScheme value) {
            return DropdownMenuItem<FlexScheme>(
              value: value,
              child: Text(
                value.name,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
