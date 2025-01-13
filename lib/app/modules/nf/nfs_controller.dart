import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:metal_forte/app/app_controller.dart';
import 'package:metal_forte/app/core/bottoms/select_image_source_bottom.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/nf_provider.dart';
import 'package:metal_forte/app/core/data/local/usuario/nf_data_source.dart';
import 'package:metal_forte/app/core/dialogs/loading_dialog.dart';
import 'package:metal_forte/app/core/enums/storage_status_enum.dart';
import 'package:metal_forte/app/core/models/app_stream.dart';
import 'package:metal_forte/app/core/services/connectivity_service.dart';
import 'package:metal_forte/app/core/services/notification_service.dart';
import 'package:metal_forte/app/core/utils/global_resource.dart';
import 'package:metal_forte/app/modules/nf/nf_view_model.dart';
import 'package:overlay_support/overlay_support.dart';

final nfCtrl = NfController();

class NfController {
  static final NfController _instance = NfController._();

  NfController._();

  factory NfController() => _instance;

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  AppStream<List<NfModel>> nfsStream = AppStream<List<NfModel>>();
  AppStream<NfsViewModel> nfsViewModelStream =
      AppStream<NfsViewModel>.seed(NfsViewModel());
  NfsViewModel get nfsViewModel => nfsViewModelStream.value;

  AppStream<NfModel> nfStream = AppStream<NfModel>();
  Future<void> getNfs() async {
    List<NfModel> nfsLocal = await NfLocalDataSource.getNfs();
    if (await ConnectivityService.hasConnection) {
      final nfsRemote = await NfProvider.getNfs(appCtrl.usuario.cgc!);
      await saveNfs(nfsLocal, nfsRemote);
      nfsLocal = await NfLocalDataSource.getNfs();
    }
    nfsStream.add(nfsLocal);
  }

  Future<void> saveNfs(List<NfModel> nfsLocal, List<NfModel> nfsRemote) async {
    for (var nfRemote in nfsRemote.where((e) => e.f2Filial.isNotEmpty).toList()) {
      final nfLocal = nfsLocal.firstWhereOrNull((e) => e.id == nfRemote.id);
      if (nfLocal != null) {
        if ((nfLocal.storageStatus == StorageStatusEnum.aberta &&
            !nfLocal.editada)) {
          await NfLocalDataSource.updateNf(nfRemote);
        }
      } else {
        await NfLocalDataSource.saveNf(nfRemote);
      }
    }
  }

  Future<String?> onPickPhoto() async {
    final imageSource = await SelectImageSourceBottom.show();
    if (imageSource != null) {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        final compressedImage = await FlutterImageCompress.compressWithFile(
          image.path,
          quality: 70,
        );
        if (compressedImage != null) {
          return base64Encode(compressedImage);
        }
      }
    }
    return null;
  }

  Future<void> isNfEdited(NfModel nf) async {
    if (nf.assingModel.points != null ||
        nf.assingModel.fotoCarga != null ||
        nf.assingModel.fotoCanhoto != null) {
      nf.editada = true;
    } else {
      nf.editada = true;
    }
    await nf.save();
    nfStream.update();
  }

  Future<void> concluirNf(BuildContext context, NfModel nf) async {
    try {
      nf.storageStatus = StorageStatusEnum.pendente;
      final location = await Location().getLocation();
      nf.locatioAtDelivered = '${location.latitude}, ${location.longitude}';
      await nf.save();
      nfsViewModel.pageController.jumpToPage(1);
      nfsViewModel.storageStatus = StorageStatusEnum.pendente;
      nfsViewModelStream.update();
      nfStream.update();
      Navigator.pop(context);
      NotificationService.showPositive(
          'NF ${nf.f2Doc} concluída com sucesso', 'Sincronize para enviar a NF',
          position: NotificationPosition.bottom);
    } catch (e) {
      NotificationService.showPositive(
          'Não foi possível concluir', 'Erro: ${e.toString()}',
          position: NotificationPosition.bottom);
    }
  }

  Future<void> onSyncNfs(List<NfModel> nfs) async {
    showLoadingDialog();
    for (var nf in nfs) {
      try {
        await onSyncNf(nf);
      } catch (e) {
        log(e.toString());
      }
    }
    nfsStream.update();
    nfsViewModel.pageController.jumpToPage(2);
    nfsViewModel.storageStatus = StorageStatusEnum.enviada;
    nfsViewModelStream.update();
    NotificationService.showPositive(
        'NF(s) enviada(s) com sucesso', 'NF(s) foram enviadas ao servidor.',
        position: NotificationPosition.bottom);
    Navigator.pop(contextGlobal);
  }

  Future<void> onSyncNf(NfModel nf) async {
    await NfProvider.postNf(await nf.toPostBody());
    nf.storageStatus = StorageStatusEnum.enviada;
    await nf.save();
    nfStream.update();
  }

  List<NfModel> getFilteredNfs(List<NfModel> nfs) {
    List<NfModel> nfsFiltered = [];
    if (nfsViewModel.showSearch && nfs.length > 1) {
      nfsFiltered = nfs
          .where((e) => e
              .toString()
              .toLowerCase()
              .contains(nfsViewModel.searchController.text.toLowerCase()))
          .toList();
      return nfsFiltered;
    } else {
      return nfs;
    }
  }
}
