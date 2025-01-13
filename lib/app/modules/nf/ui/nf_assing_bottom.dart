import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/components/app_bottom.dart';
import 'package:metal_forte/app/core/components/h.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/components/w.dart';
import 'package:metal_forte/app/core/models/app_stream.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/global_resource.dart';
import 'package:signature/signature.dart';

class NfAssignBottom extends StatefulWidget {
  final List<AppPoint>? points;

  const NfAssignBottom({this.points, super.key});

  static Future<List<AppPoint>?> show({List<AppPoint>? points}) async =>
      await showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: contextGlobal,
        isScrollControlled: true,
        builder: (_) => NfAssignBottom(points: points),
      );

  @override
  State<NfAssignBottom> createState() => _NfAssignBottom();
}

class _NfAssignBottom extends State<NfAssignBottom> {
  final AppStream<List<Point>> _stream = AppStream<List<Point>>();

  late SignatureController _controller;

  @override
  void initState() {
    final points = (widget.points ?? []).map((e) => e.toPoint()).toList();
    _stream.add(points);

    _controller = SignatureController(
        penStrokeWidth: 1,
        penColor: Colors.black,
        exportBackgroundColor: Colors.black,
        points: points,
        onDrawMove: () {
          _stream.add(_controller.points);
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBottom(
      title: 'Assine a Nota Fiscal',
      height: 500,
      onDone: () {},
      onDoneButton: StreamOut(
        stream: _stream.listen,
        builder: (_, points) => TextButton(
          onPressed: points.isEmpty
              ? null
              : () => Navigator.pop(
                  context,
                  _controller.points.isEmpty
                      ? null
                      : _controller.points.map((e) => e.toAppPoint()).toList()),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.all(
                points.isEmpty ? Colors.grey : AppColors.primaryMain),
          ),
          child: const Text('Confirmar'),
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Signature(
                controller: _controller,
                width: double.maxFinite,
                height: 300,
                backgroundColor: Colors.grey[100]!,
              ),
            ),
          ),
          const H(8),
          Row(
            children: [
              IconButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8))),
                  foregroundColor:
                      WidgetStateProperty.all(const Color(0xFFF5F5F5)),
                ),
                onPressed: () async {
                  _controller.undo();
                  _stream.add(_controller.points);
                },
                icon: Icon(Symbols.undo, color: Colors.grey[400]!),
              ),
              const W(4),
              IconButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8))),
                  foregroundColor:
                      WidgetStateProperty.all(const Color(0xFFF5F5F5)),
                ),
                onPressed: () {
                  _controller.redo();
                  _stream.add(_controller.points);
                },
                icon: Icon(Symbols.redo, color: Colors.grey[400]!),
              ),
              const Spacer(),
              IconButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8))),
                  foregroundColor:
                      WidgetStateProperty.all(const Color(0xFFF5F5F5)),
                ),
                onPressed: () {
                  _controller.clear();
                  _stream.add(_controller.points);
                },
                icon: Icon(Symbols.ink_eraser, color: Colors.grey[400]!),
              ),
            ],
          )
        ],
      ),
    );
  }
}
