import 'package:flutter/material.dart';

import '../../models/blogs/mlangblogpost.dart';
import '../../viewmodels/blogs/langblogposts_detail_viewmodel.dart';

class LangBlogPostsDetailPage extends StatefulWidget {
  final LangBlogPostsDetailViewModel vmDetail;

  LangBlogPostsDetailPage(MLangBlogPost item, {super.key})
      : vmDetail = LangBlogPostsDetailViewModel(item);

  @override
  LangBlogPostsDetailPageState createState() => LangBlogPostsDetailPageState();
}

class LangBlogPostsDetailPageState extends State<LangBlogPostsDetailPage> {
  final _formKey = GlobalKey<FormState>();
  MLangBlogPost get item => widget.vmDetail.item;

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
                  initialValue: item.title,
                  decoration: const InputDecoration(
                    labelText: "TITLE",
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  initialValue: item.url,
                  decoration: const InputDecoration(
                    labelText: "URL",
                  ),
                  readOnly: true,
                ),
              ]))));
}
