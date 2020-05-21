import 'package:flutter/material.dart';
import 'package:timetrackerapp/models/jobs.dart';

class JobTile extends StatelessWidget {
  JobTile({@required this.job, this.onPress});

  final onPress;
  final Job job;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${job.name} (${job.ratePerHour})'),
      trailing: Icon(Icons.chevron_right),
      onTap: onPress,
    );
  }
}
