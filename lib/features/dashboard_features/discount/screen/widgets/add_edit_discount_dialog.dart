import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/bloc/discount_bloc.dart';
import 'package:plantfiy_plantshop_admin_dashboard/features/dashboard_features/discount/model/discount_model.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/constants/colors.dart';
import 'package:plantfiy_plantshop_admin_dashboard/utils/validator/validation.dart';
import 'package:uuid/uuid.dart';

class AddEditDiscountDialog extends StatefulWidget {
  final DiscountModel? discount;

  const AddEditDiscountDialog({super.key, this.discount});

  @override
  State<AddEditDiscountDialog> createState() => _AddEditDiscountDialogState();
}

class _AddEditDiscountDialogState extends State<AddEditDiscountDialog> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final codeController = TextEditingController();
  final percentageController = TextEditingController();
  final minimumAmountController = TextEditingController();
  final rulesController = TextEditingController();

  DateTime? expiredDate;
  String? expiredDateError;

  bool isActive = true;
  bool firstTimeOnly = true;

  @override
  void initState() {
    super.initState();

    final discount = widget.discount;

    if (discount != null) {
      titleController.text = discount.title;
      codeController.text = discount.code;
      percentageController.text = discount.percentage.toString();
      minimumAmountController.text = discount.minAmount.toString();

      isActive = discount.isActive;
      firstTimeOnly = discount.firstTimeOnly;

      rulesController.text = discount.rules.join('\n');

      expiredDate = discount.validUntil;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    codeController.dispose();
    percentageController.dispose();
    minimumAmountController.dispose();
    rulesController.dispose();
    super.dispose();
  }

  Future<void> _selectExpiredDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: expiredDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        expiredDate = selectedDate;
        expiredDateError = null;
      });
    }
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(fontSize: 10, color: Colors.grey));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.red),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 10)),
        const SizedBox(width: 4),
        Transform.scale(
          scale: 0.75,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColor.buttonPrimary,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  void _addDiscount() {
    final isFormValid = formKey.currentState!.validate();

    if (expiredDate == null) {
      setState(() {
        expiredDateError = 'Expired date is required.';
      });
    }

    if (!isFormValid || expiredDate == null) {
      return;
    }

    final rulesList = rulesController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final discount = DiscountModel(
      id: widget.discount?.id ?? const Uuid().v4(),
      title: titleController.text.trim(),
      code: codeController.text.trim(),
      percentage: double.parse(percentageController.text.trim()),
      minAmount: int.parse(minimumAmountController.text.trim()),
      validUntil: expiredDate!,
      rules: rulesList,
      isActive: isActive,
      firstTimeOnly: firstTimeOnly,
    );

    if (widget.discount == null) {
      context.read<DiscountBloc>().add(CreateDiscount(discount));
    } else {
      context.read<DiscountBloc>().add(UpdateDiscount(discount));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 594,
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Coupon',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                _buildLabel('Title'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: titleController,
                  validator: (value) {
                    return Validator.validateIsEmpty(value, 'Title');
                  },
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Code'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: codeController,
                            validator: (value) {
                              return Validator.validateIsEmpty(value, 'Code');
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Discount Percentage'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: percentageController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              final error = Validator.validateIsEmpty(
                                value,
                                'Discount percentage',
                              );

                              if (error != null) {
                                return error;
                              }

                              final percentage = double.tryParse(value!);

                              if (percentage == null) {
                                return 'Must be a valid number.';
                              }

                              if (percentage <= 0 || percentage > 100) {
                                return 'Must be between 1 and 100.';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Minimum Amount'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: minimumAmountController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              final error = Validator.validateIsEmpty(
                                value,
                                'Minimum amount',
                              );

                              if (error != null) {
                                return error;
                              }

                              final amount = double.tryParse(value!);

                              if (amount == null) {
                                return 'Must be a valid number.';
                              }

                              if (amount < 0) {
                                return 'Amount cannot be negative.';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                _buildLabel('Expired Date'),
                const SizedBox(height: 8),

                InkWell(
                  onTap: _selectExpiredDate,
                  child: Container(
                    height: 54,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: expiredDateError != null
                            ? Colors.red
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expiredDate == null
                              ? 'Select date'
                              : _formatDate(expiredDate!),
                          style: TextStyle(
                            fontSize: 14,
                            color: expiredDate == null
                                ? Colors.grey.shade600
                                : Colors.black87,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 20),
                      ],
                    ),
                  ),
                ),

                if (expiredDateError != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 5),
                    child: Text(
                      expiredDateError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),

                const SizedBox(height: 12),

                // Switches
                Row(
                  children: [
                    _buildSwitch(
                      title: 'IsActive',
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildSwitch(
                      title: 'FirstTimeUser',
                      value: firstTimeOnly,
                      onChanged: (value) {
                        setState(() {
                          firstTimeOnly = value;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _buildLabel('Rules'),
                const SizedBox(height: 8),

                TextFormField(
                  controller: rulesController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColor.primary),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                      ),

                      child: const Text('Cancel'),
                    ),

                    const SizedBox(width: 8),

                    ElevatedButton(
                      onPressed: _addDiscount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.buttonPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                      ),
                      child: Text(
                        widget.discount == null
                            ? 'Add Discount'
                            : 'Update Discount',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
