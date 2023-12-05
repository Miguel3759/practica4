import 'package:flutter/material.dart';
import 'package:jobs_app/item.dart';
import 'package:jobs_app/job.dart';
import 'package:jobs_app/job_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Pagina de usuarios')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: jobProvider.jobScrollController,
                itemCount: jobProvider.jobs.length,
                itemBuilder: (context, index) {
                  final Job job = jobProvider.jobs[index];
                  return Item(
                    data: job,
                    onDeletePressed: () => jobProvider.deleteJob(job.id!),
                    onEditPressed: () => _editJob(job, context, jobProvider),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addJob(context, jobProvider),
        child: const Icon(Icons.add),
      ),
    );
  }
//correguir desde aqui title y description
  void _addJob(BuildContext context, JobProvider jobProvider) {
    showDialog(
        context: context,
        builder: (context) {
          String name = '';
          String email = '';
          return AlertDialog(
            title: const Text('Nuevo Usuario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    //maxLines: null,
                    //keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(labelText: 'email'),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  jobProvider
                      .addJob(Job(name: name, email: email));
                  Navigator.of(context).pop();
                },
                child: const Text('Agregar'),
              ),
            ],
          );
        });
  }

  void _editJob(Job job, context, JobProvider jobProvider) {
    final TextEditingController nameController =
        TextEditingController(text: job.name);
    final TextEditingController emailController =
        TextEditingController(text: job.email);
    showDialog(
        context: context,
        builder: (context) {
          String name = job.name;
          String email = job.email;
          return AlertDialog(
            title: const Text('Editar Usuario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: nameController,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: emailController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(labelText: 'email'),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  jobProvider.updateJob(
                      Job(id: job.id, name: name, email: email));
                  Navigator.of(context).pop();
                },
                child: const Text('Actualizar'),
              ),
            ],
          );
        });
  }
}