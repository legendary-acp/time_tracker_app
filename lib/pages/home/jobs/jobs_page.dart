import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/home/job_entries/job_entries_page.dart';
import 'package:timetrackerapp/pages/home/jobs/job_tiles.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/models/jobs.dart';
import 'package:timetrackerapp/pages/home/jobs/edit_job_page.dart';
import 'package:timetrackerapp/pages/home/jobs/list_item_builder.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/database.dart';

class JobsPage extends StatefulWidget {


  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return _homeBuild();
  }

  Widget _homeBuild() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditJobPage.show(context,
                database: Provider.of<Database>(context, listen: false)),
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
      PlatformAlertDialog(
        title: 'Successfully Deleted',
        content: 'Delete operation complete',
        defaultActionText: 'ok',
      ).show(context);
    } catch (e) {
      PlatformAlertDialog(
        title: 'Deletion Failed',
        content: 'Can\'t delete right now try again later',
        defaultActionText: 'ok',
      ).show(context);
    }
  }

  _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Job>(
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(
              color: Color(0xFF8B0000),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete_outline,
                    size: 40.0,
                    color: Colors.white,
                  )),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobTile(
              job: job,
              onPress: () => JobEntriesPage.show(
                  database: database, context: context, job: job),
            ),
          ),
          snapshot: snapshot,
        );
      },
    );
  }
}
