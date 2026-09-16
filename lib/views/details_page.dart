import 'package:flutter/material.dart';
import 'package:logiks_crud/models/lego.dart';
import 'package:logiks_crud/view_models/details_view_model.dart';
import 'package:logiks_crud/views/edit_page.dart';
import 'package:logiks_crud/utils/snackbar_utils.dart';
import 'package:logiks_crud/utils/dialogs.dart';

class DetailsPage extends StatefulWidget {
  final Lego item;

  const DetailsPage({super.key, required this.item});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsViewModel _viewModel = DetailsViewModel();
  late Lego _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    final item = _item;
    final id = item.id!;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: const Color.fromARGB(136, 13, 126, 179),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text("Id"),
              subtitle: Text(id),
            ),
            ListTile(
              title: Text("Name"),
              subtitle: Text(item.name),
            ),
            ListTile(
              title: Text("Year"),
              subtitle: Text("${item.year ?? "-"}"),
            ),
            ListTile(
              title: Text("Price"),
              subtitle: Text("${item.price ?? "-"}"),
            ),
            ListTile(
              title: Text("Pieces"),
              subtitle: Text("${item.pieces ?? "-"}"),
            ),
            ListTile(
              title: Text("Minifigures"),
              subtitle: Text("${item.minifigures ?? "-"}"),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      navigateToEditPage(item);
                    },
                    child: Text("Edit"),
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (){
                      deleteById(id, item.name);
                    },
                    child: Text("Delete"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToEditPage(Lego item) async{
    final route = MaterialPageRoute(builder: (context) => EditPage(item: item),);
    final updatedLego = await Navigator.push(context, route);
    if(updatedLego is Lego){
      setState(() {
        _item = updatedLego;
      });
    }
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
      Navigator.pop(context, true);
    }
    else{
      showErrorMessage(context, "Deletion Failed");
    }
  }
}
