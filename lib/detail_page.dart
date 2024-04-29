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
          body: _buildUserData(id),
        )
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
          if(snapshot.hasData) {
            UserDetails detailUser = UserDetails.fromJson(snapshot.data);
            return _buildSuccessSection(detailUser.data!);
          }
          return _buildLoadingSection();
        }
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(Data data) {
    return SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(data.id!.toString()),
              Image.network(data.avatar!),
              Text("Nama : " + data.firstName! + " " + data.lastName!),
              Text("Email : " + data.email!),

            ],
          ),
        )
    );
  }
}
