import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api_data_source.dart';
import 'detail_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('User $id'),
        ),
        body: _buildUserData(id),
      ),
    );
  }

  Widget _buildUserData(int id) {
    return FutureBuilder(
        future: ApiDataSource.userData(id),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            UserDetails detailUser = UserDetails.fromJson(snapshot.data);
            return _buildSuccessSection(detailUser.data!);
          }
          return _buildLoadingSection();
        }
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text(
        "Error",
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(Data data) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(data.avatar!),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${data.firstName!} ${data.lastName!}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    data.email!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
