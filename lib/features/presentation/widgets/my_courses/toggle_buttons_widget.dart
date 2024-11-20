part of 'widgets_imports.dart';

class ToggleButtonsWidget extends StatelessWidget {
  const ToggleButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleButtonsCubit, ToggleButtonsState>(
      builder: (context, toggleState) {
        return ToggleButtons(
          isSelected: toggleState.isSelected,
          onPressed: (int index) {
            context.read<ToggleButtonsCubit>().toggleButton(index);

            // Re-fetch courses after the state has been updated
            context.read<GetCoursesByStatusCubit>().fetchCoursesByStatus(
                  status: index == 0 ? 'in_progress' : 'finished',
                );
          },
          borderRadius: BorderRadius.circular(10.0),
          selectedBorderColor: Colors.white,
          selectedColor: Colors.black,
          disabledColor: Colors.grey,
          fillColor: Colors.white,
          color: Colors.black,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(AppLocalization.of(context)!.translate('inProgress'),
                  style: TextStyle(fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(AppLocalization.of(context)!.translate('finished'),
                  style: TextStyle(fontSize: 22)),
            ),
          ],
        );
      },
    );
  }
}
