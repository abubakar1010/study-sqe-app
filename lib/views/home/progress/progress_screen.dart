import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/utils/app_colors.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});

  // Enhanced data structure matching your spreadsheet
  List<SubjectProgressDetail> getSubjectProgressData() {
    return [
      // Business Law and Practice
      SubjectProgressDetail('Business Law and Practice', 'Starting a new business through the vehicle of a company, partnership, LLP or sole trader', 'Completed'),
      SubjectProgressDetail('Business Law and Practice', 'The management of a business and company decision making to ensure compliance with statutory and other legal requirements', 'In Progress'),
      SubjectProgressDetail('Business Law and Practice', 'The interests, rights, obligations and powers of stakeholders in a business', 'In Progress'),
      SubjectProgressDetail('Business Law and Practice', 'Financing a business', 'Pending'),
      SubjectProgressDetail('Business Law and Practice', 'Taxation of a business and its stakeholders', 'Pending'),
      SubjectProgressDetail('Business Law and Practice', 'The termination of a solvent business, corporate insolvency and personal bankruptcy', 'Pending'),
      SubjectProgressDetail('Business Law and Practice', 'Analysis of merits of claim or defence', 'Pending'),
      SubjectProgressDetail('Business Law and Practice', 'Arbitration, mediation and litigation as an appropriate mechanism to resolve a dispute', 'Pending'),
      SubjectProgressDetail('Business Law and Practice', 'Pre-action considerations and steps', 'Pending'),

      // Dispute Resolution
      SubjectProgressDetail('Dispute Resolution', 'Commencing, responding to or progressing a claim', 'Completed'),
      SubjectProgressDetail('Dispute Resolution', 'Case management and any interim applications relevant to a claim', 'In Progress'),
      SubjectProgressDetail('Dispute Resolution', 'Evidence needed and disclosure steps required in commencing, responding to, progressing or defending a claim', 'In Progress'),
      SubjectProgressDetail('Dispute Resolution', 'Preparation of a case for trial, the trial and post-trial steps', 'Pending'),
      SubjectProgressDetail('Dispute Resolution', 'Procedures and processes relevant to costs involved in dispute resolution', 'Pending'),

      // Contract Law
      SubjectProgressDetail('Contract Law', 'Existence/formation of a contract', 'In Progress'),
      SubjectProgressDetail('Contract Law', 'Contents of a contract', 'In Progress'),
      SubjectProgressDetail('Contract Law', 'Causation and remoteness', 'Pending'),
      SubjectProgressDetail('Contract Law', 'Vitiating elements', 'Pending'),
      SubjectProgressDetail('Contract Law', 'Discharge of contract and remedies', 'Pending'),
      SubjectProgressDetail('Contract Law', 'Unjust enrichment', 'Pending'),

      // Tort Law
      SubjectProgressDetail('Tort Law', 'Negligence', 'In Progress'),
      SubjectProgressDetail('Tort Law', 'Remedies and defences', 'Pending'),
      SubjectProgressDetail('Tort Law', 'Occupier\'s liability', 'Pending'),
      SubjectProgressDetail('Tort Law', 'Product liability', 'Pending'),
      SubjectProgressDetail('Tort Law', 'Nuisance and the rule in Rylands v Fletcher', 'Pending'),

      // Legal System of England and Wales
      SubjectProgressDetail('Legal System of England and Wales', 'The Legal System of England and Wales and sources of law', 'Completed'),
      SubjectProgressDetail('Legal System of England and Wales', 'Constitutional and Administrative law and EU Law', 'Completed'),
      SubjectProgressDetail('Legal System of England and Wales', 'Legal services', 'In Progress'),

      // Criminal Law and Practice
      SubjectProgressDetail('Criminal Law and Practice', 'The core principles of criminal liability (actus reus, mens rea, specific and general defences, participation)', 'In Progress'),
      SubjectProgressDetail('Criminal Law and Practice', 'The law, procedure and processes involved in advising a client at the police station', 'Pending'),
      SubjectProgressDetail('Criminal Law and Practice', 'The law, procedure and processes involved in pre-trial considerations', 'Pending'),
      SubjectProgressDetail('Criminal Law and Practice', 'The law, procedure and processes involved to meet the client\'s objectives', 'Pending'),
      SubjectProgressDetail('Criminal Law and Practice', 'The law, procedure and processes involved in magistrates\' court and Crown Court trials, sentencing and appeals', 'Pending'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final progressData = getSubjectProgressData();

    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(text: "Progress Overview"),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            CustomTextTwo(
              text: "Detailed Subject Progress",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            CustomTextTwo(
              text: "Track your progress across all knowledge areas",
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
            SizedBox(height: 16.h),

            // Progress Summary Cards
            _buildProgressSummary(progressData),
            SizedBox(height: 16.h),

            // Data Grid
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SfDataGrid(
                    source: SubjectProgressDataSource(progressData),
                    columnWidthMode: ColumnWidthMode.fill,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    rowHeight: 120.h, // Increased row height to accommodate text
                    // allowWrappingText: true, // Allow text wrapping
                    columns: [
                      GridColumn(
                        columnName: 'subject',
                        width: 100.w, // Increased width for subject names
                        label: Container(
                          padding: EdgeInsets.all(12.w),
                          alignment: Alignment.center,
                          color: AppColors.primaryColor.withOpacity(0.1),
                          child: CustomTextTwo(
                            text: 'Subject',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'knowledge',
                        // Let this column take remaining space for long text
                        label: Container(
                          padding: EdgeInsets.all(6.w),
                          alignment: Alignment.center,
                          color: AppColors.primaryColor.withOpacity(0.1),
                          child: CustomTextTwo(
                            text: 'Knowledge',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'status',
                        width: 100.w, // Reduced width as status text is short
                        label: Container(
                          padding: EdgeInsets.all(12.w),
                          alignment: Alignment.center,
                          color: AppColors.primaryColor.withOpacity(0.1),
                          child: CustomTextTwo(
                            text: 'Status',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSummary(List<SubjectProgressDetail> data) {
    final completed = data.where((item) => item.status == 'Completed').length;
    final inProgress = data.where((item) => item.status == 'In Progress').length;
    final pending = data.where((item) => item.status == 'Pending').length;
    final total = data.length;

    return Row(
      children: [
        _buildSummaryCard('Completed', completed.toString(), Colors.green, total),
        SizedBox(width: 12.w),
        _buildSummaryCard('In Progress', inProgress.toString(), Colors.orange, total),
        SizedBox(width: 12.w),
        _buildSummaryCard('Pending', pending.toString(), Colors.blue, total),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String count, Color color, int total) {
    final percentage = ((int.parse(count) / total) * 100).toInt();

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 5.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 5.w),
                Flexible(
                  child: CustomTextOne(
                    text: title,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            CustomTextTwo(
              text: count,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            CustomTextTwo(
              text: '$percentage% of total',
              fontSize: 10.sp,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced model class for detailed subject progress
class SubjectProgressDetail {
  final String subject;
  final String knowledgeArea;
  final String status;

  SubjectProgressDetail(this.subject, this.knowledgeArea, this.status);
}

// Enhanced data source for Syncfusion DataGrid
class SubjectProgressDataSource extends DataGridSource {
  List<SubjectProgressDetail> subjectProgressData;

  SubjectProgressDataSource(this.subjectProgressData);

  @override
  List<DataGridRow> get rows => subjectProgressData
      .map(
        (subjectProgress) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'subject', value: subjectProgress.subject),
      DataGridCell<String>(columnName: 'knowledge', value: subjectProgress.knowledgeArea),
      DataGridCell<String>(columnName: 'status', value: subjectProgress.status),
    ]),
  )
      .toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final subject = row.getCells()[0].value as String;
    final knowledge = row.getCells()[1].value as String;
    final status = row.getCells()[2].value as String;

    // Track subject groups to show subject name only once per group
    final rowIndex = rows.indexWhere((r) =>
    r.getCells()[0].value == subject &&
        r.getCells()[1].value == knowledge &&
        r.getCells()[2].value == status);

    final isFirstInGroup = rowIndex == 0 ||
        rows[rowIndex - 1].getCells()[0].value != subject;

    Color statusColor;
    Color statusBgColor;
    switch (status) {
      case 'Completed':
        statusColor = Colors.green;
        statusBgColor = Colors.green.withOpacity(0.1);
        break;
      case 'In Progress':
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withOpacity(0.1);
        break;
      case 'Pending':
        statusColor = Colors.grey;
        statusBgColor = Colors.grey.withOpacity(0.1);
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey.withOpacity(0.1);
    }

    return DataGridRowAdapter(
      color: isFirstInGroup ? Colors.grey[50] : null,
      cells: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: isFirstInGroup
              ? CustomTextOne(
            text: subject,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
            maxLine: 5,
          )
              : SizedBox.shrink(),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: CustomTextTwo(
            text: knowledge,
            fontSize: 11.sp,
            // Remove maxLines to show full text
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 12.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: statusColor.withOpacity(0.3)),
            ),
            child: CustomTextTwo(
              text: status,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }
}