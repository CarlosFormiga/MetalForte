import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:metal_forte/app/core/components/app_bottom.dart';
import 'package:metal_forte/app/core/components/divisor.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/global_resource.dart';

class SelectImageSourceBottom extends StatefulWidget {
  const SelectImageSourceBottom({super.key});

  static Future<ImageSource?> show() async => await showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: contextGlobal,
        isScrollControlled: true,
        builder: (_) => const SelectImageSourceBottom(),
      );

  @override
  State<SelectImageSourceBottom> createState() => _SelectImageSourceBottom();
}

class _SelectImageSourceBottom extends State<SelectImageSourceBottom> {
  @override
  Widget build(BuildContext context) {
    return AppBottom(
      title: 'Selecione de onde deseja adicionar a imagem',
      height: 300,
      onDone: () {},
      onDoneButton: const SizedBox.shrink(),
      child: Column(
        children: [
          ListTile(
            title: const Text('Câmera'),
            leading: const Icon(Symbols.camera),
            onTap: () => Navigator.pop(context, ImageSource.camera),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 12,
            ),
          ),
          const Divisor(),
          ListTile(
            title: const Text('Galeria'),
            leading: const Icon(Symbols.photo),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
