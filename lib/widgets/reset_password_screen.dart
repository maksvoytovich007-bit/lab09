import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Ключ для валідації форми

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) { // Перевірка валідності
      final String email = _emailController.text;

      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Скидання пароля'),
            content: Text("Інструкції для скидання пароля надіслано на: $email. \nУспішна валідація!"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('ОК'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_reset, color: Colors.blueGrey),
            SizedBox(width: 8),
            Text("Відновлення Паролю"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: availableHeight,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                const Icon(Icons.lock_reset, size: 60, color: Colors.blueGrey),
                const SizedBox(height: 30),

                const Text(
                  "Введіть Email або Логін для відновлення доступу:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),


                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Ваш Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email або логін є обов\'язковим полем.'; // Усі поля обов'язкові
                    }

                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Введіть коректний Email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),


                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.yellow.shade700),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "Ми надішлемо посилання лише на зареєстровану пошту. Не діліться цим посиланням ні з ким.",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),


                ElevatedButton(
                  onPressed: _resetPassword,
                  child: const Text("Відновити Пароль"),
                ),
                const SizedBox(height: 16),


                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Повернутися до входу"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}