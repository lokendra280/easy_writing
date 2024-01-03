import 'package:learning_path_app/provider/homepage_provider.dart';
import 'package:learning_path_app/provider/task_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => HomepageProvider()),
  ChangeNotifierProvider(create: (_) => TaskModel())
];
