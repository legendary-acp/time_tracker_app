import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:timetrackerapp/pages/home/job_entries/entry_list_item.dart';
import 'package:timetrackerapp/pages/home/job_entries/entry_page.dart';
import 'package:timetrackerapp/pages/home/jobs/edit_job_page.dart';
import 'package:timetrackerapp/pages/home/jobs/list_item_builder.dart';
import 'package:timetrackerapp/models/entry.dart';
import 'package:timetrackerapp/models/jobs.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/database.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({@required this.database, @required this.job});

  final Database database;
  final Job job;

  static Future<void> show(
      {BuildContext context, Database database, Job job}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => JobEntriesPage(database: database, job: job),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
      PlatformAlertDialog(
        title: 'Deleted Successfully',
        content: 'Item deletion was successful',
        defaultActionText: 'OK',
      ).show(context);
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Operation failed',
        content: PlatformExceptionAlertDialog.message(e),
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Job>(
        stream: database.jobStream(jobId: job.id),
        builder: (context, snapshot) {
          final job = snapshot.data;
          final jobName = job?.name ?? '';
          return Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              title: Text(jobName),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () =>
                      EntryPage.show(
                          context: context, database: database, job: job),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () =>
                      EditJobPage.show(context, job: job, database: database),
                ),
              ],
            ),
            body: _buildContent(context, job),
          );
        }
    );
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () =>
                  EntryPage.show(
                    context: context,
                    database: database,
                    job: job,
                    entry: entry,
                  ),
            );
          },
        );
      },
    );
  }
}