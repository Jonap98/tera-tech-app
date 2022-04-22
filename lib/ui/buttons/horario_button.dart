import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';

class HorarioButton extends StatelessWidget {
  final String horaMostrada;
  final String horario;
  final bool provider;
  final VoidCallback? onTap;
  final bool? seleccionado;

  const HorarioButton({
    Key? key,
    required this.horaMostrada,
    required this.horario,
    required this.provider,
    required this.onTap,
    this.seleccionado = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (!provider) ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            '$horaMostrada ${(provider) ? 'No disponible' : (Provider.of<SolicitudesProvider>(context, listen: false).horarioSeleccionado == horario) ? 'Seleccionado' : 'Disponible'}',
            style: const TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                //  (Provider.of<SolicitudesProvider>(context, listen: false)
                //             .horarioSeleccionado ==
                //         true)
                //     ?
                // Colors.blue :
                (provider)
                    ? Colors.grey
                    : (Provider.of<SolicitudesProvider>(context, listen: false)
                                .horarioSeleccionado ==
                            horario)
                        ? const Color(0xff22bd61)
                        : Colors.blue,
          ),
        ),
      ),
    );
  }
}
