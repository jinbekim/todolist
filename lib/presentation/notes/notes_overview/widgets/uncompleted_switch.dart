import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todolist/application/notes/watcher/note_watcher_controller.dart';

class UncompletedSwitch extends HookWidget {
  const UncompletedSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isUncompleted = useState(false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkResponse(
        onTap: () {
          isUncompleted.value = !isUncompleted.value;
          isUncompleted.value
              ? NoteWatcherController.to.watchUncompletedStarted()
              : NoteWatcherController.to.watchAllStarted();
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: isUncompleted.value
              ? const Icon(
                  Icons.indeterminate_check_box,
                  key: Key('outlined'),
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  key: Key('filled'),
                ),
        ),
      ),
    );
  }
}
