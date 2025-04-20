import 'package:chat/core/utils/empty_space.dart';
import 'package:chat/ui/theme/theme_brightnes_changer.dart';
import 'package:chat/ui/theme/theme_changer.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(
          children: [
            SwitchListTile.adaptive(
              title: Text('Use System Theme'),
              value: context.watch<ThemeBrightnesChanger>().themeMode ==
                  ThemeMode.system,
              onChanged: (value) {
                final themeMode =
                    Theme.of(context).brightness == Brightness.light
                        ? ThemeMode.light
                        : ThemeMode.dark;

                context.read<ThemeBrightnesChanger>().setThemeMode(
                      value ? ThemeMode.system : themeMode,
                    );
              },
            ),
            Opacity(
              opacity: context.watch<ThemeBrightnesChanger>().themeMode ==
                      ThemeMode.system
                  ? 0.5
                  : 1,
              child: SwitchListTile.adaptive(
                title: Text('Dark Mode'),
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  if (context.read<ThemeBrightnesChanger>().themeMode ==
                      ThemeMode.system) {
                    return;
                  }
                  context.read<ThemeBrightnesChanger>().toggleTheme();
                },
              ),
            ),
            ListTile(
              title: const Text('Select Theme'),
              trailing: DropdownButton<FlexScheme>(
                menuMaxHeight: MediaQuery.sizeOf(context).height * 0.5,
                value: context.watch<ThemeChanger>().theme,
                alignment: AlignmentDirectional.bottomCenter,
                items: FlexScheme.values.map((FlexScheme value) {
                  return DropdownMenuItem<FlexScheme>(
                    value: value,
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: value
                                  .colors(
                                      Theme.of(context).colorScheme.brightness)
                                  .primary),
                        ),
                        4.w,
                        Text(value.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (FlexScheme? newValue) {
                  if (newValue != null) {
                    context.read<ThemeChanger>().setTheme(newValue);
                  }
                },
              ),
            ),
          ],
        ));
  }
}
