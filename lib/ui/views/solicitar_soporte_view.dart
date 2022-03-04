import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tera_tech_app/ui/buttons/boton_azul.dart';

class SolicitarSoporteView extends StatelessWidget {
  const SolicitarSoporteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(50),
        // color: Colors.redAccent,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Solicitud de soporte',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CustomDropDown(),
            const SizedBox(height: 20),
            const Text('Describe el problema', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            textFormField(),
            const SizedBox(height: 20),
            FileUpload(),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Solicitar soporte',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  TextFormField textFormField() {
    return TextFormField(
      minLines: 1,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      maxLength: 500,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: const Color(0xffEDF1F2),
      ),
    );
  }
}

// Implementación para intentar poner el nombre del archivo a un lado
// cuando ya se cargó la imágen, aún sin funcionar
class FileUpload extends StatefulWidget {
  const FileUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  @override
  Widget build(BuildContext context) {
    late PlatformFile file = PlatformFile(name: '', size: 0);

    return Row(
      children: [
        const Text('Adjunta una imágen', style: TextStyle(fontSize: 20)),
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'jpeg', 'png'],
              allowMultiple: false,
            );
            if (result != null) {
              file = result.files.first;
              // PlatformFile file = result.files.first;
              // print(file.name);
              // print(file.bytes);
              // print(file.size);
              // print(file.extension);
              setState(() {});
            } else {}
          },
          child: const Text('Adjuntar archivo'),
        ),
        const SizedBox(width: 5),
        (file.name != '') ? Text(file.name) : Container(),
      ],
    );
  }
}

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;
  final opciones = [
    'Opción 1',
    'Opción 2',
    'Opción 3',
    'Opción 4',
    'Opción 5',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: const Text('Selecciona una categoría'),
      validator: (value) => value == null ? 'Selecciona una catagoría' : null,
      value: selectedValue,
      // value: (dropdownValue != '') ? '' : 'Selecciona una categoría',
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: const Color(0xffEDF1F2),
      ),
      dropdownColor: const Color(0xffEDF1F2),
      icon: const Icon(Icons.arrow_drop_down),
      items: opciones.map((String opciones) {
        return DropdownMenuItem(
          value: opciones,
          child: Text(opciones),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedValue = newValue!;
        setState(() {});
      },
    );
  }
}
