import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/image_strings.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/popups/animation_loader.dart';

class AppPaginatedDataTable extends StatefulWidget {
  final bool sortAscending;
  final int? sortColumnIndex;
  final int rowsPerPage;
  final DataTableSource source;
  final List<DataColumn> columns;
  final Function(int)? onPageChanged;
  final double dataRowHeight;
  final double tableHeight;
  final double? minWidth;

  const AppPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    required this.rowsPerPage,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = 32.0 * 2,
    this.sortAscending = true,
    this.minWidth = 1000,
  });

  @override
  State<AppPaginatedDataTable> createState() => _AppPaginatedDataTableState();
}

class _AppPaginatedDataTableState extends State<AppPaginatedDataTable> {
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.rowsPerPage;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardThemeData(
          color: AppColor.sidebarBackground,
          elevation: 0,
        ),
      ),
      child: PaginatedDataTable2(
        source: widget.source,
        columns: widget.columns,
        columnSpacing: 12,
        minWidth: widget.minWidth,
        dividerThickness: 0,
        horizontalMargin: 12,
        rowsPerPage: _rowsPerPage,
        showFirstLastButtons: true,
        showCheckboxColumn: true,
        sortAscending: widget.sortAscending,
        onPageChanged: widget.onPageChanged,
        dataRowHeight: widget.dataRowHeight,
        renderEmptyRowsInTheEnd: false,
        onRowsPerPageChanged: (value) {
          if (value != null) {
            setState(() {
              _rowsPerPage = value;
            });
          }
        },
        sortColumnIndex: widget.sortColumnIndex,
        headingTextStyle: Theme.of(context).textTheme.titleMedium,
        headingRowColor: WidgetStateColor.resolveWith(
          (states) => AppColor.accent,
        ),
        empty: AnimationLoader(
          text: 'Nothing found',
          animation: ImageStrings.emptyAnimation,
          height: 200,
          width: 200,
        ),
        headingRowDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        sortArrowBuilder: (ascending, sorted) {
          if (sorted) {
            return Icon(
              ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
              size: 16.0,
            );
          } else {
            return Icon(Iconsax.arrow_3, size: 16.0);
          }
        },
        availableRowsPerPage: [5, 8, 15, 50],

        sortArrowAlwaysVisible: true,
        sortArrowIcon: Icons.data_array,
      ),
    );
  }
}
