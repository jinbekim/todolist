import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/application/notes/form/note_form_controller.dart';
import 'package:todolist/domain/notes/value_objects.dart';

class ColorField extends StatelessWidget {
  const ColorField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final itemColor = NoteColor.predefinedColors[index];
          return Obx(
            () => GestureDetector(
              onTap: () {
                NoteFormController.to.colorChanged(itemColor);
              },
              child: Material(
                color: itemColor,
                elevation: 4,
                shape: CircleBorder(
                  side: NoteFormController.to.state.value.note.color.value.fold(
                    (_) => BorderSide.none,
                    (color) => BorderSide(
                      color: color == itemColor
                          ? Colors.black
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 12,
        ),
        itemCount: NoteColor.predefinedColors.length,
      ),
    );
  }
}
