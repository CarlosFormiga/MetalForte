import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/client/http/providers/nf/models/nf_model.dart';
import 'package:metal_forte/app/core/components/app_drawer.dart';
import 'package:metal_forte/app/core/components/app_field.dart';
import 'package:metal_forte/app/core/components/app_loading.dart';
import 'package:metal_forte/app/core/components/app_scaffold.dart';
import 'package:metal_forte/app/core/components/h.dart';
import 'package:metal_forte/app/core/components/stream_out.dart';
import 'package:metal_forte/app/core/enums/storage_status_enum.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/core/utils/app_css.dart';
import 'package:metal_forte/app/modules/nf/nfs_controller.dart';
import 'package:metal_forte/app/modules/nf/ui/nf_page.dart';

class NfsPage extends StatefulWidget {
  const NfsPage({super.key});

  @override
  State<NfsPage> createState() => NfsPageState();
}

class NfsPageState extends State<NfsPage> {
  @override
  void initState() {
    nfCtrl.getNfs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamOut(
      stream: nfCtrl.nfsStream.listen,
      loading: const AppLoading(),
      builder: (_, __) => StreamOut(
        stream: nfCtrl.nfsViewModelStream.listen,
        loading: const AppLoading(),
        builder: (_, viewModel) {
          final nfs = nfCtrl.getFilteredNfs(__);
          return AppScaffold(
            backgroundColor: AppColors.primaryMain,
            drawer: const AppDrawer(),
            fab: viewModel.storageStatus == StorageStatusEnum.pendente &&
                    (nfs.where((e) =>
                            e.storageStatus == StorageStatusEnum.pendente))
                        .isNotEmpty
                ? FloatingActionButton.extended(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    onPressed: () => nfCtrl
                        .onSyncNfs(nfs
                            .where((e) =>
                                e.storageStatus == StorageStatusEnum.pendente)
                            .toList())
                        .then((_) => setState(() {})),
                    backgroundColor: const Color(0xFFF67B42),
                    label: const Text(
                      'Sincronizar Notas Fiscais',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                    ),
                  )
                : null,
            appBar: AppBar(
              backgroundColor: AppColors.primaryMain,
              elevation: 0,
              title: Text(
                'Notas Fiscais',
                style: AppCss.largeBold.copyWith(color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: Icon(viewModel.showSearch ? Icons.close : Icons.search),
                  onPressed: () {
                    viewModel.showSearch = !viewModel.showSearch;
                    nfCtrl.nfsViewModelStream.add(viewModel);
                  },
                ),
              ],
              bottom: viewModel.showSearch
                  ? PreferredSize(
                      preferredSize: const Size(double.maxFinite, 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.primaryMain),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: AppField(
                            hint: 'Pesquisar NF',
                            controller: viewModel.searchController,
                            onChanged: (p0) =>
                                nfCtrl.nfsViewModelStream.update(),
                          ),
                        ),
                      ))
                  : null,
            ),
            bottomNav: BottomNavigationBar(
                backgroundColor: const Color(0xFFF67B42),
                currentIndex: viewModel.storageStatus.index,
                onTap: (value) {
                  viewModel.storageStatus = StorageStatusEnum.values[value];
                  viewModel.pageController.jumpToPage(value);
                  nfCtrl.nfsViewModelStream.add(viewModel);
                },
                items: StorageStatusEnum.values
                    .map((e) => BottomNavigationBarItem(
                          icon: Icon(e.icon,
                              color: viewModel.storageStatus == e
                                  ? e.bottomNavColor
                                  : Colors.white),
                          label: e.label,
                        ))
                    .toList()),
            body: PageView(
              controller: viewModel.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: StorageStatusEnum.values
                  .map((s) =>
                      body(s, nfs.where((n) => n.storageStatus == s).toList()))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget body(StorageStatusEnum status, List<NfModel> nfs) {
    if (nfs.isEmpty) return _emptWidget(status);
    if (status == StorageStatusEnum.aberta) {
      nfs.sort((a, b) {
        if (a.editada && !b.editada) return -1;
        if (!a.editada && b.editada) return 1;

        return a.f2Doc.compareTo(b.f2Doc);
      });
    }
    return RefreshIndicator(
      onRefresh: () async => nfCtrl.getNfs(),
      child: ListView.separated(
        itemCount: nfs.length,
        separatorBuilder: (_, i) => const Divider(thickness: 1, height: 1),
        itemBuilder: (_, i) => nfWidget(status, nfs[i]),
      ),
    );
  }

  Widget nfWidget(StorageStatusEnum status, NfModel nf) {
    return Container(
      color: nf.editada && nf.storageStatus == StorageStatusEnum.aberta
          ? status.color.withOpacity(0.04)
          : null,
      child: ListTile(
        onTap: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => NfPage(nf: nf)));
          setState(() {});
        },
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                border: Border.all(color: status.color.withOpacity(0.8)),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long,
              ),
            ),
            if (nf.editada && nf.storageStatus == StorageStatusEnum.aberta)
              Container(
                padding: const EdgeInsets.all(3.5),
                transform: Matrix4.translationValues(4.5, 4.5, 0),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 11,
                ),
              )
          ],
        ),
        title: Text(
          'NF ${nf.f2Doc}',
          style: AppCss.mediumBold,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nf.a1NReduz ?? '',
              style: AppCss.minimumRegular
                  .copyWith(fontSize: 13, color: Colors.grey[800]),
            ),
            const H(2),
            Text(
              nf.address,
              style: AppCss.minimumRegular
                  .copyWith(fontSize: 11, color: Colors.grey[700]),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[300]!,
        ),
      ),
    );
  }

  Widget _emptWidget(StorageStatusEnum status) {
    return ListView(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 54,
                color: Colors.grey[600]!,
              ),
              const H(8),
              Text("Você não possui NF's ${status.label}.",
                  style: TextStyle(color: Colors.grey[600]!)),
            ],
          ),
        )
      ],
    );
  }
}
