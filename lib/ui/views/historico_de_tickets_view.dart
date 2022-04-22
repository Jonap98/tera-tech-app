// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/datatables/solicitudes_datasource.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';

class HistoricoDeTicketsView extends StatefulWidget {
  const HistoricoDeTicketsView({Key? key}) : super(key: key);

  @override
  State<HistoricoDeTicketsView> createState() => _HistoricoDeTicketsViewState();
}

class _HistoricoDeTicketsViewState extends State<HistoricoDeTicketsView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<SolicitudesProvider>(context, listen: false).getSolicitudes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final solicitudes = Provider.of<SolicitudesProvider>(context).solicitudes;

    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
      width: double.infinity,
      // height: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Historico de tickets',
              style: CustomLabels.h1,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text('Id')),
                    DataColumn(label: Text('Técnico')),
                    DataColumn(label: Text('Soporte')),
                    DataColumn(label: Text('Estado')),
                    DataColumn(label: Text('Fecha cita')),
                    DataColumn(label: Text('Fecha listo')),
                    DataColumn(label: Text('Fecha real')),
                  ],
                  source: SolicitudesDTS(solicitudes),
                  // dataRowHeight: 50,
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      _rowsPerPage = value ?? 10;
                    });
                  },
                  rowsPerPage: _rowsPerPage,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
