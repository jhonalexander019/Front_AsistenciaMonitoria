import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_bar_content.dart';
import 'build_error_message_listener.dart';

class ScreenTemplate<T> extends StatelessWidget {
  final String title;
  final int Function(T bloc) itemCount;
  final VoidCallback onAdd;
  final Widget Function(T bloc) child;

  const ScreenTemplate({
    super.key,
    required this.title,
    required this.itemCount,
    required this.onAdd,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, bloc, childWidget) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: AppBar(flexibleSpace: AppBarContent(title: title)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$title: ${itemCount(bloc)}', style: const TextStyle(fontSize: 16)),
                    GestureDetector(
                      onTap: onAdd,
                      child: const Icon(Icons.add_circle, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        child(bloc),
                        BuildErrorMessageListener(
                          bloc: bloc,
                          success: (bloc as dynamic).successMessage ?? false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
