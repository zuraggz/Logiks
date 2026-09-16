import 'package:flutter/material.dart';
import 'package:logiks_crud/models/lego.dart';
import 'package:logiks_crud/view_models/edit_view_model.dart';
import 'package:logiks_crud/utils/snackbar_utils.dart';
import 'package:logiks_crud/utils/validators.dart';

class EditPage extends StatefulWidget {
  final Lego item;

  const EditPage({super.key, required this.item});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final EditViewModel _viewModel = EditViewModel();
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController minifiguresController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.item.name;
    yearController.text = widget.item.year?.toString() ?? "";
    priceController.text = widget.item.price?.toString() ?? "";
    piecesController.text = widget.item.pieces?.toString() ?? "";
    minifiguresController.text = widget.item.minifigures?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Lego"),
        backgroundColor: const Color.fromARGB(136, 13, 126, 179),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(),
                    helperText: " ",
                  ),
                  validator: validateName,
                ),
                SizedBox(height: 12,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: yearController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Year",
                          border: OutlineInputBorder(),
                          helperText: " ",
                        ),
                        validator: validateYear,
                      ),
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: "Price",
                          border: OutlineInputBorder(),
                          helperText: " ",
                        ),
                        validator: validatePrice,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: piecesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Pieces",
                          border: OutlineInputBorder(),
                          helperText: " ",
                        ),
                        validator: validateInt,
                      ),
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                      child: TextFormField(
                        controller: minifiguresController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Minifigures",
                          border: OutlineInputBorder(),
                          helperText: " ",
                        ),
                        validator: validateInt,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: submitData, child: Text("Submit")),
              ],
            ),
          ),
        ),
    );
  }

  Future<void> submitData() async{
    if(!_formKey.currentState!.validate()){
      return;
    }

    final updatedLego = await _viewModel.submit(
      id: widget.item.id!,
      name: titleController.text,
      year: int.tryParse(yearController.text),
      price: double.tryParse(priceController.text),
      pieces: int.tryParse(piecesController.text),
      minifigures: int.tryParse(minifiguresController.text),
    );

    if(updatedLego != null){
      showSuccessMessage(context, "Edit Success");
      Navigator.pop(context, updatedLego);
    }
    else{
      showErrorMessage(context, "Edit Failed");
    }
  }
}
