import 'package:flutter/material.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:timetrackerapp/models/jobs.dart';
import 'package:timetrackerapp/services/database.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({@required this.database, this.job});

  final Database database;
  final Job job;

  static Future<void> show(BuildContext context, { Database database, Job job}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(
          database: database,
          job: job,
        ),
        fullscreenDialog: true,
      ),
    );
  }


  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;

  @override
  void initState() {
    super.initState();
    if(widget.job != null){
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job Name'),
        initialValue: _name,
        onSaved: (value) => _name = value,
        validator: (value) => value.isNotEmpty ? null : 'Can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate Per Hour'),
        initialValue: _ratePerHour != null ? '$_ratePerHour':null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      )
    ];
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  Future<void> _submit() async {
    try {
      if (_validateAndSaveForm()) {
        final jobs = await widget.database.jobsStream().first;
        final allJobs = jobs.map((job) => job.name).toList();
        if(widget.job!=null){
          allJobs.remove(widget.job.name);
        }
        if (allJobs.contains(_name)) {
          PlatformAlertDialog(
            title: 'Job name already exist',
            content: 'Please use another name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(name: _name, ratePerHour: _ratePerHour,id: id);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job == null ? 'New Job': 'Edit Job'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContent(),
    );
  }
}
