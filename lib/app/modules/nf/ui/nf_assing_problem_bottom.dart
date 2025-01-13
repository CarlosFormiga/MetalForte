import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/components/app_bottom.dart';
import 'package:metal_forte/app/core/components/app_checkbox.dart';
import 'package:metal_forte/app/core/components/app_field.dart';
import 'package:metal_forte/app/core/components/h.dart';
import 'package:metal_forte/app/core/models/text_controller.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/global_resource.dart';
import 'package:metal_forte/app/modules/nf/nfs_controller.dart';

class NfAssingProblemBottom extends StatefulWidget {
  final NfAssingProblemModel? problem;

  const NfAssingProblemBottom({required this.problem, super.key});

  static Future<NfAssingProblemModel?> show(
      {required NfAssingProblemModel? problem}) async {
    NfAssingProblemModel? assingResult =
        await showModalBottomSheet<NfAssingProblemModel?>(
      backgroundColor: AppColors.white,
      context: contextGlobal,
      isScrollControlled: true,
      builder: (_) => NfAssingProblemBottom(problem: problem),
    );
    return assingResult == null || !assingResult.hasProblem
        ? null
        : assingResult;
  }

  @override
  State<NfAssingProblemBottom> createState() => _NfAssignBottom();
}

class _NfAssignBottom extends State<NfAssingProblemBottom> {
  bool hasProblem = false;
  TextController textController = TextController();
  String? foto;

  @override
  initState() {
    hasProblem = widget.problem?.hasProblem ?? false;
    textController.text = widget.problem?.message ?? '';
    foto = widget.problem?.fotoProblema;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBottom(
      title: 'Problema com a entrega',
      height: 300,
      onDoneButton: TextButton(
        onPressed:
            hasProblem && (textController.text.isNotEmpty || foto != null)
                ? () => Navigator.pop(
                    context,
                    NfAssingProblemModel(
                        hasProblem: hasProblem,
                        message: textController.text,
                        fotoProblema: foto))
                : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(
              hasProblem && (textController.text.isNotEmpty || foto != null)
                  ? AppColors.primaryMain
                  : Colors.grey),
        ),
        child: const Text('Confirmar'),
      ),
      onDone: () {},
      child: Column(
        children: [
          AppCheckbox(
              label: 'Tive um problema',
              value: hasProblem,
              onChanged: (e) {
                setState(() {
                  hasProblem = e;
                });
              }),
          const H(16),
          if (hasProblem) ...[
            AppField(
              controller: textController,
              hint: 'Descreva o problema',
              onChanged: (e) {
                setState(() {});
              },
            ),
            const H(8),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              onTap: () async {
                final photo = await nfCtrl.onPickPhoto();
                if (photo != null) {
                  foto = photo;
                }
                setState(() {});
              },
              leading: Icon(Icons.assignment,
                  color: foto != null ? Colors.green : null),
              title: Text(
                'Fotografar Problema',
                style: TextStyle(color: foto != null ? Colors.green : null),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 14,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
