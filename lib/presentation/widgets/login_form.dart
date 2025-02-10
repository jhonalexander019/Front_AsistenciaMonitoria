import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Function(String accessCode) onLogin;
  final bool isLoading;

  const LoginForm({super.key, required this.onLogin, required this.isLoading});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final accessCode = _controllers.map((c) => c.text).join();
      widget.onLogin(accessCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: SizedBox(
                  width: 60,
                  height: 50,
                  child: TextFormField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(84, 22, 43, 1.000),
                            width: 2.0),
                      ),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: (widget.isLoading) ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(84, 22, 43, 1.000),
              minimumSize: const Size(double.infinity, 40),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: (widget.isLoading)
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : const Text('Ingresar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
