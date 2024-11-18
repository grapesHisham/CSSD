import 'package:cssd/app/modules/cssd_as_custodian/Department_User/controller/dashboard_controller_dept.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestDetailsViewCssdCussDeptUser extends StatefulWidget {
  const RequestDetailsViewCssdCussDeptUser({super.key});

  @override
  State<RequestDetailsViewCssdCussDeptUser> createState() =>
      _RequestDetailsViewCssdCussDeptUserState();
}

class _RequestDetailsViewCssdCussDeptUserState
    extends State<RequestDetailsViewCssdCussDeptUser> {
  @override
  void initState() {
    super.initState();
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    dashboardController.fetchRequestDetails();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<DashboardControllerCssdCussDeptUser>(
                builder: (context, dashboardConsumer, child) {
              return ListView.builder(
                itemCount: dashboardConsumer.requestDetailsList.length,
                itemBuilder: (context, index) {
                  final request = dashboardConsumer.requestDetailsList[index];
                  return Card(
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Request id: ${request.reqId}"),
                          Text("Priority: ${request.priority}"),
                          Text("Requested by : ${request.rUser}"),
                          Text("Time : ${request.rTime}"),
                          Text("Accepted  : ${request.isAccept == 1 ? 'Yes' : 'No'}"),
                          request.isAccept == 1
                              ? Text("Accepted by : ${request.acceptedUser}")
                              : const Text(""),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
