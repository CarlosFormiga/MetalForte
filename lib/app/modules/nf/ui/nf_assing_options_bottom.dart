import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/components/app_bottom.dart';
import 'package:metal_forte/app/core/components/divisor.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/global_resource.dart';
import 'package:metal_forte/app/modules/nf/nfs_controller.dart';
import 'package:metal_forte/app/modules/nf/ui/nf_assing_bottom.dart';
import 'package:metal_forte/app/modules/nf/ui/nf_assing_problem_bottom.dart';

class NfAssignOptionsBottom extends StatefulWidget {
  final NfModel nf;

  const NfAssignOptionsBottom({required this.nf, super.key});

  static Future<void> show({required NfModel nf}) async =>
      await showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: contextGlobal,
        isScrollControlled: true,
        builder: (_) => NfAssignOptionsBottom(nf: nf),
      );

  @override
  State<NfAssignOptionsBottom> createState() => _NfAssignBottom();
}

class _NfAssignBottom extends State<NfAssignOptionsBottom> {
  @override
  Widget build(BuildContext context) {
    return AppBottom(
      title: 'Assinar Nota Fiscal',
      height: 400,
      onDone: () => Navigator.pop(context),
      child: StreamOut(
        stream: nfCtrl.nfStream.listen,
        builder: (_, nf) => Column(
          children: [
            ListTile(
              onTap: () async {
                final points =
                    await NfAssignBottom.show(points: nf.assingModel.points);
                if (points != null) {
                  nf.assingModel.points = points;
                  await nf.save();
                  nfCtrl.nfStream.update();
                }
                nfCtrl.isNfEdited(nf);
              },
              leading: Icon(
                Icons.draw,
                color: nf.isAssinada ? Colors.green : null,
              ),
              title: Text(
                nf.isAssinada ? 'Assinatura Realizada' : 'Assinar',
                style: TextStyle(color: nf.isAssinada ? Colors.green : null),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 14,
              ),
            ),
            const Divisor(),
            ListTile(
              onTap: () async {
                final photo = await nfCtrl.onPickPhoto();
                if (photo != null) {
                  nf.assingModel.fotoCarga = photo;
                  await nf.save();
                  nfCtrl.nfStream.update();
                }
                nfCtrl.isNfEdited(nf);
              },
              leading: Icon(Icons.local_shipping,
                  color: nf.hasFotoCarga ? Colors.green : null),
              title: Text('Foto da Carga',
                  style:
                      TextStyle(color: nf.hasFotoCarga ? Colors.green : null)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 14,
              ),
            ),
            const Divisor(),
            ListTile(
              onTap: () async {
                final photo = await nfCtrl.onPickPhoto();
                if (photo != null) {
                  nf.assingModel.fotoCanhoto = photo;
                  await nf.save();
                  nfCtrl.nfStream.update();
                }
                nfCtrl.isNfEdited(nf);
              },
              leading: Icon(Icons.assignment,
                  color: nf.hasFotoCanhoto ? Colors.green : null),
              title: Text(
                'Foto do Canhoto Assinado',
                style:
                    TextStyle(color: nf.hasFotoCanhoto ? Colors.green : null),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 14,
              ),
            ),
            const Divisor(),
            ListTile(
              onTap: () async {
                final problem = await NfAssingProblemBottom.show(
                    problem: nf.assingModel.problem);
                if (problem != null) {
                  nf.assingModel.problem = problem;
                  await nf.save();
                  nfCtrl.nfStream.update();
                }
              },
              leading: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              title: Text(
                nf.hasProblem
                    ? 'Usuário reportou um problema'
                    : 'Tive um problema',
                style: TextStyle(color: nf.hasProblem ? Colors.red : null),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.red[400],
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
