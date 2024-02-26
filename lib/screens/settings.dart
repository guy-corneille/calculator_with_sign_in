import 'package:flutter/material.dart';
import 'package:new_calculator/components/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
          child: SwitchListTile(
              title: const Text(
                'Theme',
                style: TextStyle(color: Colors.blue),
              ),
              secondary: Icon(
                themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: Colors.orange,
              ),
              value: themeState.getDarkTheme,
              onChanged: (bool value) {
                themeState.setDarkTheme = value;
              })),
    );
  }
}

// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Column(
//         children: [
//           ListTile(
//             title: Text('Light Theme'),
//             onTap: () {
//               // Set light theme logic here
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: Text('Dark Theme'),
//             onTap: () {
//               // Set dark theme with inverted colors logic here
//               MyApp.setDarkThemeWithInvertedColors();
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: Text('Custom Color Theme'),
//             onTap: () {
//               // Set custom color theme logic here
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
