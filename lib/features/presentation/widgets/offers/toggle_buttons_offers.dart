part of 'widgets_imports.dart';

class ToggleOffersWidget extends StatelessWidget {
  const ToggleOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleOffersCubit, ToggleOffersState>(
      builder: (context, toggleState) {
        return ToggleButtons(
          isSelected: toggleState.isSelected,
          onPressed: (int index) {
            debugPrint("Toggle button pressed: $index");
            context.read<ToggleOffersCubit>().toggleButton(index);
            context.read<GetOffersByTypeCubit>().getOffersByType(
                  type: index == 0 ? 'internship' : 'job',
                );
          },
          borderRadius: BorderRadius.circular(10.0),
          selectedBorderColor: Colors.grey,
          selectedColor: Colors.black,
          disabledColor: Colors.grey,
          fillColor: toggleState.isSelected.contains(true)
              ? Colors.white
              : Colors.grey,
          color: Colors.black,
          highlightColor: Colors.grey,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Text(AppLocalization.of(context)!.translate("internship"),
                  style: TextStyle(fontSize: 22.sp)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Text(AppLocalization.of(context)!.translate("job"),
                  style: TextStyle(fontSize: 22.sp)),
            ),
          ],
        );
      },
    );
  }
}
