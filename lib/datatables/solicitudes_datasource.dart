import 'package:flutter/material.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';

class SolicitudesDTS extends DataTableSource {
  final SolicitudesResponse solicitudes;

  SolicitudesDTS(this.solicitudes);
  @override
  DataRow getRow(int index) {
    final solicitud = solicitudes.datos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${solicitud.id}')),
        DataCell(
            Text('${solicitud.nombreTecnico} ${solicitud.apellidoTecnico}')),
        DataCell(Text('${solicitud.nombreCategoria}')),
        DataCell(Text('${solicitud.nombreEstado}')),
        DataCell(Text(solicitud.fechaCita)),
        DataCell(Text(solicitud.fechaListo ?? 'No asignada')),
        DataCell(Text(solicitud.fechaReal ?? 'No asignada')),
      ],
    );
  }

  @override
  // Si no se sabe el número de rows, indica un aproximado
  bool get isRowCountApproximate => false;

  @override
  // Cantidad de elementos
  int get rowCount => solicitudes.solicitudesCount;

  @override
  int get selectedRowCount => 0;
}
