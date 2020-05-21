import 'package:meta/meta.dart';
import 'dart:async';
import 'package:timetrackerapp/models/jobs.dart';
import 'package:timetrackerapp/services/api_path.dart';
import 'package:timetrackerapp/services/firestore_service.dart';
import 'package:timetrackerapp/models/entry.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>> jobsStream();

  Future<void> setEntry(Entry entry);

  Future<void> deleteEntry(Entry entry);

  Stream<List<Entry>> entriesStream({Job job});

  Stream<Job> jobStream({@required String jobId});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) async =>
      _service.setData(
        path: APIPath.job(uid: uid, jobId: job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteJob(Job job) async
  {
    final allEntries = await entriesStream(job: job).first;
    for(Entry entry in allEntries){
      if(entry.jobId==job.id){
        await deleteEntry(entry);
      }
    }
    await _service.deleteData(
      path: APIPath.job(uid: uid, jobId: job.id),);
  }

  @override
  Stream<Job> jobStream({@required String jobId}) => _service.documentStream(
    path: APIPath.job(uid: uid, jobId: jobId),
    builder: (data, documentID) => Job.fromMap(data, documentID),
  );

  @override
  Stream<List<Job>> jobsStream() =>
      _service.collectionStream(
          path: APIPath.jobs(uid: uid),
          builder: (data, documentID) => Job.fromMap(data, documentID));

  @override
  Future<void> setEntry(Entry entry) async =>
      await _service.setData(
        path: APIPath.entry(uid: uid, entryId: entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) async =>
      await _service.deleteData(
          path: APIPath.entry(uid: uid, entryId: entry.id));

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _service.collectionStream<Entry>(
        path: APIPath.entries(uid: uid),
        queryBuilder: job != null ? (query) =>
            query.where('jobId', isEqualTo: job.id) : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
