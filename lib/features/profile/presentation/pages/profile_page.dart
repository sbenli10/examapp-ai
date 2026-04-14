import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/config/router/app_router.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/extensions/snack_bar_extension.dart';
import '../../../../core/utils/functions/calculate_max_width.dart';
import '../../../../core/utils/resources/supabase.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/text_field.dart';
import '../../data/data_sources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository.dart';
import '../../../about/presentation/dialogs/supa_quiz_about_dialog.dart';
import '../../../../core/widgets/user_bubble.dart';

@RoutePage()
class ProfilePage extends StatefulHookWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    if (user == null) {
      context.router.push(const AuthRoute());
    }

    final nicknameController = useTextEditingController(
      text: user?.userMetadata?['nickname'],
    );
    final widgetState = useState<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => const SupaQuizAboutDialog(),
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: kDefaultPadding),
        ],
      ),
      body: Center(
        child: Container(
          width: calculateMaxWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserBubble(
                username: nicknameController.text.isEmpty
                    ? "U"
                    : nicknameController.text,
              ),
              const SizedBox(height: kHugePadding),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: SupaTextField(
                    label: "Nickname",
                    controller: nicknameController,
                    keyboardType: TextInputType.name,
                    onChanged: (_) => widgetState.value = widgetState.value + 1,
                    isEmptyError: "Please enter a nickname",
                  ),
                ),
              ),
              CustomElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  if (nicknameController.text.length < 3) {
                    context.showSnackBar(
                      message: "Nickname must be at least 3 characters",
                    );
                    return;
                  }

                  if (nicknameController.text.length > 20) {
                    context.showSnackBar(
                      message: "Nickname must be at most 20 characters",
                    );
                    return;
                  }

                  if (nicknameController.text ==
                      user?.userMetadata?['nickname']) {
                    context.showSnackBar(
                      message: "The nickname is the same as before",
                    );
                    return;
                  }

                  final result = await ProfileRepositoryImpl(
                    remoteDataSource: ProfileRemoteDataSourceImpl(),
                  ).updateProfile(
                    nickname: nicknameController.text,
                  );

                  result.fold(
                    (failure) => {
                      context.showSnackBar(
                        message: failure.errorMessage,
                      ),
                    },
                    (_) {
                      context.showSnackBar(
                        message: "Profile updated!",
                        background: AppColors.primary,
                        foreground: Colors.black,
                      );
                    },
                  );

                  widgetState.value = widgetState.value + 1;
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Update Profile", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: kHugePadding),
              CustomElevatedButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                },
                color: AppColors.red,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
