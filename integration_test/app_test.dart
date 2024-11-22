import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_tutorial_prep/main.dart';
import 'package:patrol_tutorial_prep/pages/integration_test_keys.dart';

void main() {
  patrolTest(
    'signs in, triggers a notification, and taps on it',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    ($) async {
      initApp();
      await $.pumpWidgetAndSettle(const MainApp());
      await $(keys.signInPage.emailTextField).enterText('test@email.com');
      await $(keys.signInPage.passwordTextField).enterText('password');
      await $(keys.signInPage.signInButton).tap();
      if (await $.native.isPermissionDialogVisible()) {
        await $.native.grantPermissionWhenInUse();
      }
      await $(keys.homePage.notificationIcon).tap();
      await $.native.pressHome();
      await $.native.openNotifications();
      await $.native.tapOnNotificationBySelector(
        Selector(textContains: 'Patrol says hello!'),
        timeout: const Duration(seconds: 5),
      );
      $(keys.homePage.successSnackbar).waitUntilVisible();
    },
  );
}
