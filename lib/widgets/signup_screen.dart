import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _wantsEcoNews = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String email = _emailController.text;
      String subscriptionStatus = _wantsEcoNews ? "підписаний" : "відмовився";

      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Реєстрація'),
            content: Text("Ім'я: $name, Email: $email. \nСтатус підписки: $subscriptionStatus. \nУспішна валідація!"),
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
            Icon(Icons.person_add, color: Colors.green),
            SizedBox(width: 8),
            Text("Реєстрація"),
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
                const Text(
                  "Створення нового акаунту",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),


                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Ім\'я користувача'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ім\'я користувача є обов\'язковим полем.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),


                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Логін або Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email є обов\'язковим полем.';
                    }

                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Введіть коректний Email (example@domain.com).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),


                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Пароль'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пароль є обов\'язковим полем.';
                    }
                    if (value.length < 7) {
                      return 'Пароль має бути не менше 7 символів.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),


                Row(
                  children: [
                    Checkbox(
                      value: _wantsEcoNews,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _wantsEcoNews = newValue ?? false;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    const Text("Отримувати еко-новини та поради"),
                  ],
                ),
                const SizedBox(height: 24),


                ElevatedButton(
                  onPressed: _signUp,
                  child: const Text("Зареєструватися"),
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