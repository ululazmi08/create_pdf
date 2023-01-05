import 'package:create_pdf/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final dataC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HomeView'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dataC.product.length,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(
              child: Text('${dataC.product[index]['id']}'),
            ),
            title: Text('${dataC.product[index]['name']}'),
            subtitle: Text('${dataC.product[index]['desc']}'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>dataC.getPDF(),
        child: Icon(Icons.note),
      ),
    );
  }
}
