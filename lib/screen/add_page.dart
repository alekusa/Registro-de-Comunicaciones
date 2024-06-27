import 'package:ccig/services/Registro_Services.dart';
import 'package:ccig/widgets/imput.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController intercambioController = TextEditingController();
  TextEditingController observacionesControler = TextEditingController();
  List<String> frecuencias = ['1', '2', '3', 'CH1'];
  String _frecSelect = '1';
  List<String> de = ['LTA', 'LTJ', 'B15', 'RED'];
  List<String> a = ['LTA', 'LTJ', 'B15', 'RED'];
  String _de = 'LTA';
  String _a = 'LTJ';
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['intercambio'];
      final descripcion = todo['observaciones'];
      intercambioController.text = title;
      observacionesControler.text = descripcion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar' : 'Agregar Registro '),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          //-- FRECUENCIA --//
          MyImput(
            titulo: "Frecuencia",
            hint: _frecSelect,
            widget: DropdownButton(
              isDense: false,
              items: frecuencias.map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _frecSelect = newValue!;
                });
              },
            ),
          ),
          //-- DE --//
          MyImput(
            titulo: "DE:",
            hint: _de,
            widget: DropdownButton(
              items: de.map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _de = newValue!;
                });
              },
            ),
          ),
          //--A-:--//
          MyImput(
            titulo: "A:",
            hint: _a,
            widget: DropdownButton(
              items: a.map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _a = newValue!;
                });
              },
            ),
          ),
          //-- OBSERVACIONES --//
          MyImput(
            titulo: 'Observaciones',
            hint: 'hint',
            controller: observacionesControler,
          ),
          //-- INTERCAMBIO --//ß
          MyImput(
            titulo: 'Intercambio',
            hint: 'QRU QSO QAP AR',
            controller: intercambioController,
          ),
          //-- espacio --//
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Guardar'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo['id'].toString();
    final isSucces = await RegistroServices.updateRegistro(id, body);
    if (isSucces) {
      showSuccesMessage('Se actualizo correctamente');
    } else {
      showSuccesMessage('No se Actualizo');
    }
  }

  Future<void> submitData() async {
    final isSucces = await RegistroServices.addRegistro(body);
    if (isSucces) {
      intercambioController.text = '';
      observacionesControler.text = '';
      showSuccesMessage('Todo bien');
    } else {
      showErrorMessage('Algo salio MAL');
    }
  }

  void showSuccesMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Map get body {
    final intercambio = intercambioController.text;
    final observaciones = observacionesControler.text;
    //final frecuencia = _frecSelect.text;
    return {
      "frecuencia": _frecSelect,
      "DE": _de,
      "Areceptor": _a,
      "hora": DateFormat('hh:mm a').format(DateTime.now()),
      "intercambio": intercambio,
      "observaciones": observaciones,
      "dia": DateFormat.yMd().format(DateTime.now()),
      "prioridad": "",
      "createdAt": "2024-06-20T00:23:20.847Z",
      "updatedAt": "2024-06-20T00:23:20.847Z"
    };
  }
}
