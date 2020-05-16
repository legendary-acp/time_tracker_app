import 'package:flutter/material.dart';
import 'package:timetrackerapp/models/jobs.dart';
import 'package:timetrackerapp/services/api_path.dart';
import 'package:timetrackerapp/services/firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);

  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) async => _service.setData(
        path: APIPath.job(uid: uid, jobId: 'main_job'),
        data: job.toMap(),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid: uid), builder: (data) => Job.fromMap(data));
}
