// ignore_for_file: sized_box_for_whitespace, must_be_immutable, avoid_print

// import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/categorias_model.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/router/router.dart';
// import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/services/notification_service.dart';
// import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/datetime_picker.dart';

class SolicitarSoporteView extends StatelessWidget {
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();
  final idUser = LocalStorage.prefs.getInt('id_usuario');
  SolicitarSoporteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solicitudProvider = Provider.of<SolicitudesProvider>(context);
    DatoCategoria? selectedValue;
    // String? image = '';
    // late PlatformFile image = PlatformFile(name: '', size: 0);
    // PlatformFile image =
    //     Provider.of<SolicitudesProvider>(context, listen: false)
    //         .obtenerInformacionImagen;

    return ListView(
      // shrinkWrap: true,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, left: 30),
          child: Text(
            'Solicitud de soporte',
            style: CustomLabels.h1,
          ),
        ),
        // const SizedBox(height: 20),
        Container(
          // width: double.infinity,
          // height: double.infinity,
          margin: const EdgeInsets.all(30),
          padding:
              const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
          // color: Colors.redAccent,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          // Single child scroll view
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selecciona la categoría',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              CustomDropDown(selectedValue: selectedValue),
              const SizedBox(height: 16),
              const Text('Describe el problema',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              textFormField(descripcionCtrl),
              // const SizedBox(height: 16),
              const Text('Fecha de cita', style: TextStyle(fontSize: 16)),
              CustomDateTimePicker(
                title: 'Fecha de cita',
              ),
              const SizedBox(height: 20),
              const FileUpload(),
              const SizedBox(height: 16),
              // ElevatedButton(
              //     onPressed: () => CafeApi.obtenerUrl(), child: Text('Prueba')),
              CustomElevatedButton(
                  text: 'Solicitar soporte',
                  onPressed: () async {
                    final value =
                        Provider.of<SolicitudesProvider>(context, listen: false)
                            .obtenerSelectedValue;
                    final fecha =
                        Provider.of<SolicitudesProvider>(context, listen: false)
                            .obtenerFecha;
                    final disponibilidad =
                        Provider.of<SolicitudesProvider>(context, listen: false)
                            .obtenerDisponibilidad;
                    PlatformFile image =
                        Provider.of<SolicitudesProvider>(context, listen: false)
                            .obtenerInformacionImagen;
                    // selectedValue mostrar con provider, ya que el valor está
                    // establecido por un widget hijo
                    if (value.nombre.isEmpty) {
                      _categoriasAlert(context);
                    } else if (disponibilidad == false) {
                      NotificationService.genericDialog(
                          context, 'Seleccione otra fecha');
                    } else {
                      // print('Nombre: ${image.name}');

                      final solicitudCreada = solicitudProvider.crearSolicitud(
                        context,
                        idUser!,
                        value.id,
                        descripcionCtrl.text,
                        (fecha.isNotEmpty)
                            ? fecha
                            : DateTime.now().toString().substring(0, 16),
                        image,
                      );

                      if (solicitudCreada) {
                        // image = PlatformFile(name: '', size: 0, bytes: null);
                        imageCache!.clear();
                        solicitudProvider.eliminarImagen();
                        NotificationService.solicitudExitosa(
                            context, 'Solicitud creada exitosamente');
                        NavigationService.navigateTo(Flurorouter.whiteRoute);
                      }
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> _categoriasAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                const Text(
                  '¡Atención!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text('La categoría es obligatoria'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Aceptar'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField textFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
  String value = '';

  // Init state puede usarse para inicializar la imagen vacía
  late PlatformFile info;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<SolicitudesProvider>(context, listen: false).eliminarImagen();
    });
    super.initState();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   info = PlatformFile(name: '', size: 0);
  //   Provider.of<SolicitudesProvider>(context, listen: false).eliminarImagen();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final solicitudesProvider = Provider.of<SolicitudesProvider>(context);

    return Row(
      children: [
        ((info = Provider.of<SolicitudesProvider>(context, listen: false)
                        .obtenerInformacionImagen)
                    .name !=
                '')
            ? Container(
                // color: Colors.redAccent,
                height: 150,
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    info.bytes!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : const Text('Adjunta una imagen'),

        // Puede ser que de error el Spacer, se puede manejar mainAxisAlignment
        const Spacer(),
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['jpg', 'jpeg', 'png'],
              allowMultiple: false,
            );
            if (result != null) {
              // NotificationService.showBusyIndicator(context);
              // Carga de imagen
              // Navigator.of(context).pop();

              PlatformFile file = result.files.first;

              solicitudesProvider.cargarNombreImagen(file.name);
              solicitudesProvider.cargatInformacionImagen(file);

              setState(() {});
            } else {
              // print('No hay imagen');
            }
          },
          child: const Text('Seleccionar archivo'),
        ),
        // const SizedBox(width: 5),
        // (file.name != '') ? Text(file.name) : Container(),
      ],
    );
  }
}

class CustomDropDown extends StatefulWidget {
  DatoCategoria? selectedValue;

  CustomDropDown({
    Key? key,
    this.selectedValue,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // DatoCategoria? selectedValue;
  // final opciones = [
  //   'Opción 1',
  //   'Opción 2',
  //   'Opción 3',
  //   'Opción 4',
  //   'Opción 5',
  // ];

  late Future<List<DatoCategoria>> categorias;
  @override
  void initState() {
    super.initState();
    categorias = Provider.of<SolicitudesProvider>(context, listen: false)
        .getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    // categorias.asStream().forEach((element) {
    //   opciones.add(element.datos);
    // });

    return FutureBuilder<List<DatoCategoria>>(
      future: categorias,
      builder: (context, AsyncSnapshot<List<DatoCategoria>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<DatoCategoria>(
            hint: const Text('Selecciona una categoría'),
            // validator: (value) =>
            //     value == null ? 'Selecciona una catagoría' : null,
            // PAra hacer uso del index se ocupa un itemBuilder con el index
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
                .map<DropdownMenuItem<DatoCategoria>>((DatoCategoria opcion) {
              return DropdownMenuItem(
                value: opcion,
                child: Text(opcion.nombre),
              );
            }).toList(),
            // items: opciones.map((String opciones) {
            //   return DropdownMenuItem(
            //     value: opciones,
            //     child: Text(opciones),
            //   );
            // }).toList(),
            onChanged: (DatoCategoria? newValue) {
              widget.selectedValue = newValue!;
              // print(selectedValue!.id);
              // print(selectedValue!.nombre);
              Provider.of<SolicitudesProvider>(context, listen: false)
                  .cargarSelectedValue(widget.selectedValue!);
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
