import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/tags_proivder.dart';
import 'package:fucking_math/widget/backgrounds.dart';
import 'package:provider/provider.dart';

class _TagsManagerState extends State<TagsManager> {
  TagProvider get _provider => context.read<TagProvider>();

    @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: _buildAppbar(), body: _buildMainScreen());

  final boxW16 = const SizedBox(width: 16);
  final boxH16 = const SizedBox(height: 16,);

  AppBar _buildAppbar() => AppBar(title: Text("Tags Manager"));

  Widget _buildMainScreen() => Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildTagDisplayArea(),
              const SizedBox(height: 16),
              _buildAddingArea(),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(child: _buildDetailedScreen()),
      ],
    ),
  );

  Widget _buildDetailedScreen() => Container();

  Widget _buildTagDisplayArea() => BorderedContainerWithTopText(
    labelText: "标签展示",
    child: Padding(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(child: Wrap()),
    ),
  );

  Widget _buildAddingArea() => BorderedContainerWithTopText(
    labelText: "添加 Tag",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_buildNameInputer(),boxH16 ,_buildDescriptionInputer()],
        ),
      ),
    ),
  );

  final _nameInputer = TextEditingController();
  Widget _buildNameInputer() => _composeTextInputer(_nameInputer, "Tag name");

  final _descriptionInputer = TextEditingController();
  Widget _buildDescriptionInputer() =>
      _composeTextInputer(_descriptionInputer, "Description");

  Widget _composeTextInputer(TextEditingController c, String t) =>
      TextFormField(
        controller: c,
        decoration: InputDecoration(labelText: t, border: OutlineInputBorder()),
      );


}

class TagsManager extends StatefulWidget {
  const TagsManager({super.key});

  @override
  State<StatefulWidget> createState() => _TagsManagerState();
}
