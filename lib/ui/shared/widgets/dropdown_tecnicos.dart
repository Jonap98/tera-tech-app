import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/tecnicos_model.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';

// ignore: must_be_immutable
class DropdownTecnicos extends StatefulWidget {
  DatoTecnico? selectedValue;

  DropdownTecnicos({
    Key? key,
    this.selectedValue,
  }) : super(key: key);

  @override
  State<DropdownTecnicos> createState() => _DropdownTecnicosState();
}

class _DropdownTecnicosState extends State<DropdownTecnicos> {
  late Future<List<DatoTecnico>> tecnicos;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<RecursosProvider>(context, listen: false).eliminarTecnico();
    });
    super.initState();
    tecnicos =
        Provider.of<RecursosProvider>(context, listen: false).getTecnicos();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<RecursosProvider>(context, listen: false).eliminarTecnico();
  //   tecnicos =
  //       Provider.of<RecursosProvider>(context, listen: false).getTecnicos();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DatoTecnico>>(
      future: tecnicos,
      builder: (context, AsyncSnapshot<List<DatoTecnico>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<DatoTecnico>(
            hint: const Text('Selecciona un tecnico'),
            value: widget.selectedValue,
            // value: (selectedValue != '') ? '' : 'Selecciona una categoría',
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffEDF1F2), width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffEDF1F2), width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              filled: true,
              fillColor: const Color(0xffEDF1F2),
            ),
            dropdownColor: const Color(0xffEDF1F2),
            icon: const Icon(Icons.arrow_drop_down),
            items: snapshot.data!
                .map<DropdownMenuItem<DatoTecnico>>((DatoTecnico opcion) {
              return DropdownMenuItem(
                value: opcion,
                child: Text(opcion.name),
              );
            }).toList(),
            onChanged: (DatoTecnico? newValue) {
              widget.selectedValue = newValue!;

              Provider.of<RecursosProvider>(context, listen: false)
                  .cargarTecnico(widget.selectedValue!);
              setState(() {});
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
