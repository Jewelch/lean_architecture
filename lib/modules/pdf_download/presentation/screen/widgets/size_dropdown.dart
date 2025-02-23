part of '../download_screen.dart';

class _SizeDropDown extends StatelessWidget {
  const _SizeDropDown({
    required this.size,
    required this.onChanged,
  });

  final PdfSize size;
  final void Function(PdfSize? size)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<PdfSize>(
      dropdownColor: Colors.grey.shade300,
      isDense: true,
      menuMaxHeight: 300,
      value: size,
      items: PdfSize.values
          .map((size) => DropdownMenuItem(
                value: size,
                child: Text('Download ${size.label} PDF'),
              ))
          .toList(),
      onChanged: onChanged,
    ).overallPadding(20);
  }
}
