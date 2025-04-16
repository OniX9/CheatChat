import 'package:cheat_chat/imports/imports.dart';

class Utilities {
  ToastFuture displayToastMessage(
      BuildContext context,
      String message, {
        StyledToastPosition position = StyledToastPosition.bottom,
        Color? backgroundColor = const Color(0xBB424242),
        Duration? duration = const Duration(seconds: 3),
      }) {
    return showToast(
      message,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: position,
      animDuration: const Duration(seconds: 1),
      duration: duration,
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      borderRadius: BorderRadius.circular(25),
      backgroundColor: backgroundColor,
    );
  }

  /// Detects if showLoadingScreen(), or dialog is showing... if showing,
  /// Navigator.pop(context) is called.
  /// In summary, it only pops current screen if there is a dialog.
  /// Example:
  ///
  ///   showLoadingScreen(context);
  ///   await _longOperation();  //ie. fetching API data.
  ///   loadingScreenPopper(context);
  ///
  ///How it works: when showDialog is displayed
  /// it is actually a new route being pushed to the screen,
  /// which means current route is not the one that is displayed below dialog,
  /// but the dialog window itself is current,
  /// thus making isDialogOverCurrentRoute to be true.
  dialogPopper(BuildContext context) {
    bool isDialogOverCurrentRoute = ModalRoute.of(context)?.isCurrent != true;
    if (isDialogOverCurrentRoute) {
      Navigator.pop(context);
    }
  }

  Future<void> showLoadingScreen(BuildContext context,
      {bool pseudoDelay = false,
        int delayDuration = 9000,
        bool? isLoading}) async {
    var myDialogRoute = DialogRoute(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LoadingScreen(),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        );
      },
    );

    // Save a reference to the context before starting async operation
    final navigator = Navigator.of(context);
    Navigator.of(context).push(myDialogRoute); // push the dialog

    if (pseudoDelay == true) {
      await Future.delayed(Duration(milliseconds: delayDuration), () {
        // ensure the route is still active to avoid removing a route that doesn't
        // exist causing Navigator error
        if (myDialogRoute.isActive) {
          navigator.removeRoute(myDialogRoute); // Removes dialog specifically
        }
      });
    }
    if (isLoading == false) {
      if (myDialogRoute.isActive) {
        navigator.removeRoute(myDialogRoute); // Removes dialog specifically
      }
    }
  }

}