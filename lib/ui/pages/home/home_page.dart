import 'dart:async';

import 'package:chat/core/gen/assets.gen.dart';
import 'package:chat/core/gen/flutter_icon_icons.dart';
import 'package:chat/core/services/auth_services.dart';
import 'package:chat/core/utils/empty_space.dart';
import 'package:chat/data/enum/state_handler.dart';
import 'package:chat/ui/pages/auth/provider/user_provider.dart';
import 'package:chat/ui/pages/setting/edite_profile_page.dart';
import 'package:chat/ui/pages/setting/settings_page.dart';
import 'package:chat/ui/widgets/dialog.dart';
import 'package:chat/ui/widgets/provider/status_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showArchive = false;
  ValueNotifier<bool> onGhostMode = ValueNotifier(false);
  ValueNotifier<bool> showText = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    _startTimer(); // Start the timer when the widget is initialized
  }

  void logOut() {
    final AuthServices authServices = AuthServices();
    try {
      authServices.signOut();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        ));
      }
    }
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showText.value = false;
      });
    });
  }

  void _onTextTap() {
    showText.value = true;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTextTap,
          child: ValueListenableBuilder(
              valueListenable: onGhostMode,
              builder: (context, isOn, _) {
                return ValueListenableBuilder(
                    valueListenable: showText,
                    builder: (context, onShow, _) {
                      return Text.rich(TextSpan(children: [
                        WidgetSpan(
                          child: AnimatedSwitcher(
                            duration: const Duration(
                                milliseconds: 500), // Animation duration
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            }, // Animation duration
                            child: onShow
                                ? Text(
                                    'You Are ',
                                    key: const ValueKey('ghostModeText'),
                                  )
                                : Text(
                                    '',
                                    key: ValueKey('empty'),
                                  ),
                          ),
                        ),
                        TextSpan(
                          text: isOn ? 'Ghost' : 'Online',
                        ),
                      ]));
                    });
              }),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add your action here
            },
          ),
          ValueListenableBuilder(
            valueListenable: onGhostMode,
            builder: (context, isOn, _) => IconButton(
              icon: Icon(
                  isOn ? FlutterIcon.ghost : Icons.online_prediction_rounded),
              onPressed: () {
                onGhostMode.value = !isOn;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        shape: const CircleBorder(),
        onPressed: () {
          // Add your action here
        },
        child: const Icon(
          CupertinoIcons.pencil,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Consumer<UserProvider>(builder: (context, auth, _) {
              if (auth.userState == StateHandler.loaded) {
                return SizedBox(
                    width: double.infinity,
                    child: DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Stack(
                              children: [
                                CircleAvatar(),
                                if (auth.userData.isVerified ?? false)
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.verified_rounded,
                                        color: Colors.green,
                                        size: 18,
                                      ))
                              ],
                            ),
                            title: Text(
                              auth.userData.firstName ?? 'Unknow User',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              auth.userData.phomeNumber ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            trailing: InkWell(
                              borderRadius: BorderRadius.circular(360),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditeProfilePage(),
                                    ));
                              },
                              child: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.amber.withValues(alpha: 0.2)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      CupertinoIcons.star_fill,
                                      size: 12,
                                      color: Colors.amber,
                                    ),
                                    8.w,
                                    Text(
                                      '${(auth.userData.stars ?? 0)} Stars',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                              8.w,
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withValues(alpha: 0.2)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    8.w,
                                    Text(
                                      (auth.userData.ghostMode ?? false)
                                          ? 'Ghost Mode'
                                          : 'Online',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          8.h,
                          InkWell(
                            onTap: () {
                              context
                                  .read<StatusProvider>()
                                  .checkMyInformation();
                              DialogManager(context).showListOfStatuses();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withValues(alpha: 0.2)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    auth.userData.status ?? 'Status Not set',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  8.w,
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      size: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              }
              return SizedBox.shrink();
            }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ListTile(
                          title: const Text('CHATS'),
                          leading: Icon(CupertinoIcons.chat_bubble_2),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('SAVED MESSAGES'),
                          leading: Icon(CupertinoIcons.bookmark),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('GROUPS'),
                          leading: Icon(CupertinoIcons.group_solid),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: const Text('CALLS'),
                          leading: Icon(CupertinoIcons.phone),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('CONTACTS'),
                          leading: Icon(CupertinoIcons.profile_circled),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: const Text('SETTINGS'),
                          leading: Icon(CupertinoIcons.settings),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsPage(),
                                ));
                          },
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        'LOG OUT',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.error),
                      ),
                      leading: Icon(CupertinoIcons.arrow_right_circle,
                          color: Theme.of(context).colorScheme.error),
                      onTap: logOut,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        color: Colors.transparent,
        backgroundColor: Colors.transparent,
        onRefresh: () async {
          setState(() {
            showArchive = !showArchive;
          });
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return AnimatedCrossFade(
                firstChild: SizedBox(),
                secondChild: ListTile(
                  leading: SizedBox(
                      width: 38,
                      height: 38,
                      child: Center(
                        child: Icon(
                          Icons.archive_outlined,
                        ),
                      )),
                  title: Text('Archives'),
                  subtitle: Text('For see Archived chats'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle tap on the list item
                    // You can navigate to a chat screen or perform any other action
                  },
                ),
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                crossFadeState: !showArchive
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300),
              );
            }
            return Dismissible(
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(16),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.green,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(16),
                child: const Icon(Icons.archive, color: Colors.white),
              ),
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  return false;
                }
                return await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete'),
                    content: const Text('Are you sure you want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              key: Key(index.toString()),
              child: GestureDetector(
                onLongPressStart: (details) {
                  final position = details.globalPosition;
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      position.dx,
                      position.dy,
                      position.dx,
                      position.dy,
                    ),
                    items: [
                      PopupMenuItem(
                          value: 'show_profile', child: Text('Show Profile')),
                      PopupMenuItem(
                          value: 'mute', child: Text('Mute Notifications')),
                      PopupMenuItem(
                          value: 'mark_read', child: Text('Mark as Read')),
                    ],
                  ).then((value) {
                    if (value != null) {
                      // Handle selected value here
                    }
                  });
                },
                child: ListTile(
                  leading: CircleAvatar(),
                  title: Text('User $index'),
                  subtitle: Text('Last message from user $index'),
                  trailing: Text('12:00 PM'),
                  onTap: () {
                    // Handle tap on the list item
                    // You can navigate to a chat screen or perform any other action
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
