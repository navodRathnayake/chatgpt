library popup_settings_menu;

import 'package:chatgpt/Logic/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopUpSettingsMenu extends StatefulWidget {
  final Icon icon;
  const PopUpSettingsMenu({
    super.key,
    required this.icon,
  });

  @override
  State<PopUpSettingsMenu> createState() => _PopUpSettingsMenuState();
}

class _PopUpSettingsMenuState extends State<PopUpSettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
      ),
      child: PopupMenuButton(
        icon: widget.icon,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        position: PopupMenuPosition.under,
        itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
          PopupMenuItem(child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return ListTile(
                leading: (state.themeModeStatus == AppThemeMode.lightMode
                    ? const Icon(Icons.light_mode_outlined)
                    : const Icon(Icons.dark_mode_outlined)),
                title: const Text('Dark Mode ON/OFF'),
                subtitle: const Text('Change UI theme'),
                trailing: Switch(
                  value: (state.themeModeStatus == AppThemeMode.lightMode)
                      ? false
                      : true,
                  onChanged: (value) {
                    BlocProvider.of<SettingsBloc>(context).add(ThemeModeChanged(
                        themeModeStatus: (value == true)
                            ? AppThemeMode.darkMode
                            : AppThemeMode.lightMode));
                  },
                ),
              );
            },
          )),
          const PopupMenuDivider(),
          PopupMenuItem(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Font Size'),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return Slider(
                    value:
                        context.read<SettingsBloc>().state.fontSizeSliderValue,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (value) {
                      BlocProvider.of<SettingsBloc>(context)
                          .add(FontSizeChanged(sliderValue: value));
                    },
                    label: context
                        .read<SettingsBloc>()
                        .state
                        .fontSizeSliderValue
                        .toString(),
                    divisions: 4,
                  );
                },
              ),
            ],
          )),
          //PopupMenuDivider(),
          PopupMenuItem(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Internationalization'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SegmentedButton(
                    multiSelectionEnabled: false,
                    onSelectionChanged: (p0) {},
                    selectedIcon: const Icon(Icons.done),
                    segments: const [
                      ButtonSegment(
                        value: 'english',
                        icon: null, //Icon(Icons.language_outlined),
                        label: Text('En-Us'),
                        enabled: true,
                      ),
                      ButtonSegment(
                        value: 'sinhala',
                        icon: null, //Icon(Icons.language_outlined),
                        label: Text('සිංහල'),
                        enabled: true,
                      ),
                      ButtonSegment(
                        value: 'tamil',
                        icon: null, //Icon(Icons.language_outlined),
                        label: Text('தமிழ்'),
                        enabled: true,
                      ),
                    ],
                    selected: const <dynamic>{'english'},
                    emptySelectionAllowed: true,
                  )
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
