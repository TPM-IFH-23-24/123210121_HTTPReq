import "package:flutter/material.dart";
import 'package:httpreq/api_data_source.dart';
import 'list_users_model.dart';

class PageListUser extends StatefulWidget {
  const PageListUser({Key? key}) : super(key: key);

  @override
  State<PageListUser> createState() => _PageListUserState();
}

class _PageListUserState extends State<PageListUser> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List User Reqres"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody(){
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.loadUsers(page),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasError){
            return _buildErrorSection();
          }
          if(snapshot.hasData){
            ListUserModel listUserModel = ListUserModel.fromJson(snapshot.data);
            return _buildSuccessSection(listUserModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection(){
    return Container(
      child: Text("Ada Error"),
    );
  }

  Widget _buildLoadingSection(){
    return CircularProgressIndicator();
  }

  Widget _buildSuccessSection(ListUserModel user){
    return ListView.builder(
        itemCount: user.data!.length,
        itemBuilder: (BuildContext context, int index){
          return _buildItemUsers(user.data![index]);
        }
    );
  }

  Widget _buildItemUsers(Data userData){
    return InkWell(
      onTap: (){},
      child: Card(
        child: Row(
          children: [
            Container(
              width: 100,
              child: Image.network(userData.avatar!),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userData.firstName! + " " + userData.lastName!),
                Text(userData.email!)
              ],
            )
          ],
        ),
      ),
    );
  }
}

