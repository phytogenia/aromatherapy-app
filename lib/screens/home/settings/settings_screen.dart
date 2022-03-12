import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/platform_alert_dialog.dart';
import '../../../services/auth_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/functions.dart';

class SettingsScreen extends StatelessWidget {
  /* Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }*/

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _bodyContent(context),
    );
  }

  void _signOutUser(BuildContext context) async {
    final authProvider = Provider.of<AuthService>(context, listen: false);
    try {
      await authProvider.signOut();
    } catch (e) {
      const dialogTitle = 'Logout Error';
      final dialogContent = 'Cause $e Can you please try later ?';
      const cancelTextButton = 'Dismiss';

      PlatformAlertDialog(
        title: dialogTitle,
        content: dialogContent,
        cancelTextButton: cancelTextButton,
      ).show(context);
    }
  }

  void _showDialogToLogout(BuildContext context) async {
    const dialogTitle = 'Logout';
    const dialogContent = 'Do you want to logout ?';
    const cancelTextButton = 'Dismiss';
    const agreeTextButton = 'Logout';

    bool isUserWantToLogout = await PlatformAlertDialog(
      content: dialogTitle,
      title: dialogContent,
      cancelTextButton: cancelTextButton,
      agreeTextButton: agreeTextButton,
    ).show(context);

    if (isUserWantToLogout) {
      _signOutUser(context);
    }
  }

  Widget _bodyContent(BuildContext context) {
    final List<Widget> settings = [
      SettingsListTile(
        title: 'Term of use',
        icon: const RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.import_contacts,
          ),
        ),
        onTap: () async {
          if (!await launch(urlTermOfUse)) {
            throw 'Could not launch $urlTermOfUse';
          }
        },
      ),
      SettingsListTile(
        title: 'Privacy Policy',
        icon: const RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.assignment,
          ),
        ),
        onTap: () async {
          if (!await launch(urlPrivacyPolicy)) {
            throw 'Could not launch $urlPrivacyPolicy';
          }
        },
      ),
      SettingsListTile(
        title: 'Logout',
        icon: const RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.logout,
          ),
        ),
        onTap: () => _showDialogToLogout(context),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              'Account Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 20,
            child: ListView.separated(
                itemCount: 2 + settings.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0 || index == settings.length + 1) {
                    return const SizedBox.shrink();
                  }
                  return settings[index - 1];
                }),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: FutureBuilder<String>(
                future: Functions.getAppVersion(), // a Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Text('Loading version...');
                    default:
                      return Text('${snapshot.data}');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final Function() onTap;
  final Widget icon;
  final String title;

  SettingsListTile({
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: icon,
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }
}
