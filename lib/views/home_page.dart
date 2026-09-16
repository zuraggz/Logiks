import 'package:flutter/material.dart';
import 'package:logiks_crud/models/lego.dart';
import 'package:logiks_crud/view_models/home_view_model.dart';
import 'package:logiks_crud/views/lego_add_page.dart';
import 'package:logiks_crud/views/edit_page.dart';
import 'package:logiks_crud/views/details_page.dart';
import 'package:logiks_crud/utils/snackbar_utils.dart';
import 'package:logiks_crud/utils/dialogs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.fetchLegos();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LEGO", style: TextStyle(
          fontWeight: FontWeight.bold
        )),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(136, 13, 126, 179),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigateToLegoAddPage, label: Text("Add Lego")),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_viewModel.hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 12,),
            Text(
              "Couldn't load Legos",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 12,),
            ElevatedButton(
              onPressed: _viewModel.fetchLegos,
              child: Text("Retry"),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _viewModel.fetchLegos,
      child: ListView.builder(scrollDirection: Axis.vertical,itemCount: _viewModel.items.length,itemBuilder: (context, index) {

        final item = _viewModel.items[index];
        final id = item.id!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Text("${index+1}"),
            title: Text(item.name),
            subtitle: Text(id),
            onTap: (){
              navigateToDetailsPage(item);
            },
            trailing: PopupMenuButton(onSelected: (value){
              if(value=="edit"){
                navigateToEditPage(item);
              }
              else if(value ==  "delete"){
                deleteById(id, item.name);
              }
            }
            ,itemBuilder: (context){
              return [
                PopupMenuItem(value: "edit",child: Text("Edit"),),
                PopupMenuItem(value: "delete",child: Text("Delete"),)
              ];
            }),
          ),
        );
      }),
    );
  }

  void navigateToLegoAddPage() async{
    final route = MaterialPageRoute(builder: (context) => LegoAddPage(),);
    await Navigator.push(context, route);
    _viewModel.fetchLegos();
  }

  void navigateToEditPage(Lego item) async{
    final route = MaterialPageRoute(builder: (context) => EditPage(item: item),);
    await Navigator.push(context, route);
    _viewModel.fetchLegos();
  }

  void navigateToDetailsPage(Lego item) async{
    final route = MaterialPageRoute(builder: (context) => DetailsPage(item: item),);
    await Navigator.push(context, route);
    _viewModel.fetchLegos();
  }

  Future<void> deleteById(String id, String name) async{
    final confirmed = await showDeleteConfirmDialog(
      context,
      itemName: name,
    );
    if(!confirmed){
      return;
    }

    final success = await _viewModel.deleteById(id);
    if(success){
      showSuccessMessage(context, "Deletion Success");
    }
    else{
      showErrorMessage(context, "Deletion Failed");
    }
  }
}
