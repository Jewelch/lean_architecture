part of '../download_screen.dart';

class _SizeDropDown<B extends DownloadBloc> extends StatelessWidget {
  const _SizeDropDown(this.state);

  final DownloadStates state;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<B>(context);
    return DropdownButton<PdfSize>(
      dropdownColor: Colors.grey.shade300,
      isDense: true,
      menuMaxHeight: 300,
      value: bloc.selectedSize,
      items: PdfSize.values
          .map((size) => DropdownMenuItem(
                value: size,
                child: Text('Download ${size.label} PDF'),
              ))
          .toList(),
      onChanged: (size) => bloc.add(UpdateSelectedSize(size)),
    ).overallPadding(20);
  }
}
