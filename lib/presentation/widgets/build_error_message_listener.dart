import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/alert_message.dart';

class BuildErrorMessageListener<T> extends StatefulWidget {
  final T bloc;
  final bool success;

  const BuildErrorMessageListener({
    super.key,
    required this.bloc,
    required this.success,
  });

  @override
  _BuildErrorMessageListenerState<T> createState() =>
      _BuildErrorMessageListenerState<T>();
}

class _BuildErrorMessageListenerState<T> extends State<BuildErrorMessageListener<T>> {
  String? previousErrorMessage;

   @override
  Widget build(BuildContext context) {
    return Selector<T, String?>(
      selector: (_, bloc) {
        final blocAsDynamic = bloc as dynamic;
        return blocAsDynamic.message as String?;
      },
      builder: (_, errorMessage, __) {
        if (errorMessage != null && errorMessage != previousErrorMessage) {
          previousErrorMessage = errorMessage;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage(
              message: errorMessage,
              isSuccess: widget.success,
            ).show(context);
            final blocAsDynamic = widget.bloc as dynamic;
            blocAsDynamic.message = null;
            blocAsDynamic.successMessage = null;
            previousErrorMessage = null;
            blocAsDynamic.notifyListeners();
          });
        }

        return const SizedBox.shrink();
      },
    );
  }
}
