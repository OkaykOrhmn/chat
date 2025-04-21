import 'package:chat/core/utils/empty_space.dart';
import 'package:chat/data/model/auth/me_model.dart';
import 'package:chat/ui/pages/auth/provider/user_provider.dart';
import 'package:chat/ui/widgets/buttons.dart';
import 'package:chat/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditeProfilePage extends StatefulWidget {
  const EditeProfilePage({super.key});

  @override
  State<EditeProfilePage> createState() => _EditeProfilePageState();
}

class _EditeProfilePageState extends State<EditeProfilePage> {
  late MeModel initialMeData = context.read<UserProvider>().userData;

  late TextEditingController firstNameController =
      TextEditingController(text: initialMeData.firstName);
  late TextEditingController lastNameController =
      TextEditingController(text: initialMeData.lastName);
  late TextEditingController bioController =
      TextEditingController(text: initialMeData.bio);
  late TextEditingController usernameController =
      TextEditingController(text: initialMeData.username);
  late TextEditingController phoneNumberController =
      TextEditingController(text: initialMeData.phomeNumber);
  late TextEditingController emailController =
      TextEditingController(text: initialMeData.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Theme.of(context).colorScheme.surface),
                                  shape: WidgetStateProperty.all(
                                    CircleBorder(),
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.photo_filter_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        12.w,
                        Flexible(
                          child: Column(
                            children: [
                              TextFields.primaryTextField(
                                hintText: 'Firstname',
                                controller: firstNameController,
                              ),
                              12.h,
                              TextFields.primaryTextField(
                                hintText: 'Lastname',
                                controller: lastNameController,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    16.h,
                    TextFields.multilineTextField(
                      hintText: 'Bio',
                      controller: bioController,
                    ),
                    16.h,
                    TextFields.primaryTextField(
                        hintText: 'Username',
                        controller: usernameController,
                        prefixIcon: Icon(Icons.alternate_email)),
                    16.h,
                    TextFields.primaryTextField(
                        hintText: 'Phone Number',
                        controller: phoneNumberController,
                        prefixIcon: Icon(Icons.phone)),
                    16.h,
                    TextFields.primaryTextField(
                        hintText: 'Email',
                        controller: emailController,
                        prefixIcon: Icon(Icons.email_rounded)),
                    16.h,
                    TextFields.primaryTextField(
                        hintText: 'New Password',
                        controller: emailController,
                        prefixIcon: Icon(Icons.lock),
                        isSecure: true),
                    16.h,
                    TextFields.primaryTextField(
                        hintText: 'Confirm New Password',
                        controller: emailController,
                        prefixIcon: Icon(Icons.lock),
                        isSecure: true),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Buttons(context)
                  .primary(text: 'Change Profile', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
