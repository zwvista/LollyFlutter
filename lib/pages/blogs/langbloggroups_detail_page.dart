import 'package:flutter/material.dart';

import '../../models/blogs/mlangbloggroup.dart';
import '../../viewmodels/blogs/langbloggroups_detail_viewmodel.dart';

class LangBlogGroupsDetailPage extends StatefulWidget {
  final LangBlogGroupsDetailViewModel vmDetail;

  LangBlogGroupsDetailPage(MLangBlogGroup item, {super.key})
      : vmDetail = LangBlogGroupsDetailViewModel(item);

  @override
  LangBlogGroupsDetailPageState createState() =>
      LangBlogGroupsDetailPageState();
}

class LangBlogGroupsDetailPageState extends State<LangBlogGroupsDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MLangBlogGroup get item => widget.vmDetail.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Online Textbooks (Detail)')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                TextFormField(
                  initialValue: item.id.toString(),
                  decoration: const InputDecoration(
                    labelText: "ID",
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  initialValue: item.groupname,
                  decoration: const InputDecoration(
                    labelText: "GROUP",
                  ),
                  readOnly: true,
                ),
              ]))));
}
