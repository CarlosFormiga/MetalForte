import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:metal_forte/app/core/components/app_field.dart';
import 'package:metal_forte/app/core/components/app_scaffold.dart';
import 'package:metal_forte/app/core/components/app_text_button.dart';
import 'package:metal_forte/app/core/components/h.dart';
import 'package:metal_forte/app/core/models/text_controller.dart';
import 'package:metal_forte/app/core/utils/app_colors.dart';
import 'package:metal_forte/app/modules/sign/sign_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextController cpf = TextController.cpf(text: kDebugMode ? '26780585149' : '');
  final TextController senha = TextController(text: kDebugMode ? '123456' : '');

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return AppScaffold(
      backgroundColor: AppColors.primaryMain,
      body: Container(
        color: AppColors.primaryMain,
        child: Center(
          child: Container(
            width: 300,
            margin: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const H(20),
                Image.asset('assets/images/logo.png', width: 200),
                const H(20),
                AppField(
                  color: Colors.white,
                  controller: cpf,
                  label: 'CPF',
                ),
                const H(8),
                AppField(
                  color: Colors.white,
                  controller: senha,
                  label: 'Senha',
                  obscure: true,
                  maxLines: 1,
                  minLines: 1,
                ),
                const H(16),
                AppTextButton(
                  style: ButtonStyle(
                    fixedSize: const WidgetStatePropertyAll(
                        Size(double.maxFinite, 43)),
                    foregroundColor:
                        WidgetStatePropertyAll(AppColors.primaryMain),
                    backgroundColor: WidgetStatePropertyAll(AppColors.white),
                  ),
                  label: 'Entrar',
                  onPressed: () => signCtrl.onClickLogin(cpf.text, senha.text),
                ),
                const H(8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
