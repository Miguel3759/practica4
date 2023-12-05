import 'package:flutter/material.dart';
import 'package:jobs_app/job.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobProvider extends ChangeNotifier {
  final ScrollController jobScrollController = ScrollController();

  List<Job> _jobs = [];
  List<Job> get jobs => _jobs;

  JobProvider() {
    _fetchJobs();
  }

  Future<void> moveScrollBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    jobScrollController.animateTo(jobScrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 300), curve: Curves.easeOut);
  }

  Future<void> _fetchJobs() async {
     final url =
        Uri.parse('https://api-jobs-production.up.railway.app/api/users?offset=0&limit=10');  
  
   final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
  );
    if (response.statusCode == 200) {
      //parsear los datos
      _jobs = (json.decode(response.body) as List)
          .map((data) => Job.fromJson(data))
          .toList();
    } else {
      throw Exception('Fallo la conexion');
    }
  }

  Future<void> addJob(Job newJob) async {
    final url =
        Uri.parse('https://api-jobs-production.up.railway.app/api/users');
    final response = await http.post(
        url,
        //headers: {'Accept':'application/json'},
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newJob.toJson()));
    if (response.statusCode == 200) {
      _jobs.add(newJob);
      notifyListeners(); 
      moveScrollBottom();
    } else {
      throw Exception('Registro no se agrego');
    }
  }

  Future<void> deleteJob(int jobId) async {
    final url =
        Uri.parse('https://api-jobs-production.up.railway.app/api/users/$jobId');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      _jobs.removeWhere((job) => job.id == jobId);
      notifyListeners();
    } else {
      throw Exception('Fallo la eliminación');
    }
  }

  Future<void> updateJob(Job updatedJob) async {
    final url = Uri.parse(
        'https://api-jobs-production.up.railway.app/api/users/${updatedJob.id}');
        //'https://api-jobs-production.up.railway.app/api/jobs/${updatedJob.id}');
    final response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedJob.toJson()));
    if (response.statusCode == 200) {
      int index = _jobs.indexWhere((job) => job.id == updatedJob.id);
      if (index != -1) {
        _jobs[index] = updatedJob;
        notifyListeners();
      }
    }
    else {
      throw Exception('Fallo la modificación');
    }
  }
}
