part of '../upload_screen.dart';

class _TypeDropDown<B extends UploadBloc> extends StatelessWidget {
  const _TypeDropDown(this.state);

  final UploadStates state;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<B>(context);
    return DropdownButton<FileType>(
      dropdownColor: Colors.grey.shade300,
      isDense: true,
      menuMaxHeight: 300,
      value: bloc.selectedType,
      items: FileType.values
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text('Upload ${type.label} File'),
              ))
          .toList(),
      onChanged: (type) => bloc.add(UpdateSelectedType(type)),
    ).overallPadding(20);
  }
}
