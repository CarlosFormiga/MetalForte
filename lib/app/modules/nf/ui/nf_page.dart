import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/components/app_scaffold.dart';
import 'package:metal_forte/app/core/components/divisor.dart';
import 'package:metal_forte/app/core/components/h.dart';
import 'package:metal_forte/app/core/components/item_label.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/components/w.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/app_css.dart';
import 'package:metal_forte/app/modules/nf/nfs_controller.dart';
import 'package:metal_forte/app/modules/nf/ui/nf_assing_options_bottom.dart';

class NfPage extends StatefulWidget {
  final NfModel nf;
  const NfPage({required this.nf, super.key});

  @override
  State<NfPage> createState() => NfPageState();
}

class NfPageState extends State<NfPage> {
  @override
  void initState() {
    nfCtrl.nfStream.add(widget.nf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamOut(
      stream: nfCtrl.nfStream.listen,
      builder: (_, nf) => AppScaffold(
          backgroundColor: AppColors.primaryMain,
          fab: FloatingActionButton.extended(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            onPressed: () => NfAssignOptionsBottom.show(nf: nf),
            backgroundColor: const Color(0xFFF67B42),
            label: const Text(
              'Assinar NF',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.assignment,
              color: Colors.white,
            ),
          ),
          appBar: AppBar(
            backgroundColor: AppColors.primaryMain,
            elevation: 0,
            title: Text(
              'NF ${widget.nf.f2Doc}',
              style: AppCss.largeBold.copyWith(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: nf.isConcluirAvailable
                    ? () => nfCtrl.concluirNf(context, nf)
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  foregroundColor: WidgetStateProperty.all(
                      nf.isConcluirAvailable ? Colors.white : Colors.grey[700]),
                ),
                child: const Text('Concluir'),
              )
            ],
          ),
          body: ListView(
            children: [
              _clienteWidget(nf),
              const Divisor(),
              _entregaWidget(nf),
              const Divisor(),
              _nfWidget(nf),
              const Divisor(),
              _observacoesWidget(nf),
              const H(64),
            ],
          )),
    );
  }

  Widget _clienteWidget(NfModel nf) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cliente', style: AppCss.largeBold),
          const H(8),
          ItemLabel('Nome', nf.a1NReduz ?? 'Indisponível'),
          const H(16),
          ItemLabel('CPF/CNPJ', nf.a1Cgc ?? 'Indisponível'),
          const H(16),
          ItemLabel('Telefone', nf.a1TEL ?? 'Indisponível'),
        ],
      ),
    );
  }

  Widget _entregaWidget(NfModel nf) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Entrega', style: AppCss.largeBold),
          const H(8),
          ItemLabel('Endereço', nf.address),
          const H(16),
          ItemLabel('CEP', nf.a1Cep ?? 'Indisponível'),
        ],
      ),
    );
  }

  Widget _nfWidget(NfModel nf) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nota Fiscal', style: AppCss.largeBold),
          const H(8),
          ItemLabel('NF.NUM', nf.f2Doc),
          const H(8),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text('Itens (${nf.itens.length})',
                      style: AppCss.mediumRegular.copyWith(
                        color: AppColors.black.withOpacity(0.8),
                      ))),
              const W(8),
              Expanded(
                child: Text('Qtde',
                    style: AppCss.mediumRegular.copyWith(
                      color: AppColors.black.withOpacity(0.8),
                    )),
              ),
            ],
          ),
          for (NfItemModel item in nf.itens)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(item.sDescri ?? 'Indisponível',
                          style: AppCss.minimumRegular.copyWith(
                            color: Colors.black,
                          ))),
                  const W(8),
                  Expanded(
                    child: Text(
                        '${(item.d2Quant?.toString()) ?? 'Indisponível'} Kg',
                        style: AppCss.minimumRegular.copyWith(
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _observacoesWidget(NfModel nf) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Observações', style: AppCss.largeBold),
          const H(8),
          ItemLabel('Obsevação', nf.c5OBS ?? 'Indisponível'),
          const H(16),
          ItemLabel('Nota', nf.c5MenNota ?? 'Indisponível'),
        ],
      ),
    );
  }
}
