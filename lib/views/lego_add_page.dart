import 'package:flutter/material.dart';
import 'package:logiks_crud/view_models/lego_add_view_model.dart';
import 'package:logiks_crud/utils/snackbar_utils.dart';
import 'package:logiks_crud/utils/validators.dart';

class LegoAddPage extends StatefulWidget {
  const LegoAddPage({super.key});

  @override
  State<LegoAddPage> createState() => _LegoAddPageState();
}

class _LegoAddPageState extends State<LegoAddPage> {
  final LegoAddViewModel _viewModel = LegoAddViewModel();
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController piecesController = TextEditingController();
  TextEditingController minifiguresController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Lego"),
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
                SizedBox(height: 24,),
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
                SizedBox(height: 24,),
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

    final success = await _viewModel.submit(
      name: titleController.text,
      year: int.tryParse(yearController.text),
      price: double.tryParse(priceController.text),
      pieces: int.tryParse(piecesController.text),
      minifigures: int.tryParse(minifiguresController.text),
    );

    if(success){
      titleController.text = "";
      yearController.text = "";
      priceController.text = "";
      piecesController.text = "";
      minifiguresController.text = "";
      showSuccessMessage(context, "Creation Success");
    }
    else{
      showErrorMessage(context, "Creation Failed");
    }
  }
}
