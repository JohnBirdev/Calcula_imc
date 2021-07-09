import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controla_peso = TextEditingController();
  TextEditingController controla_altura = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _info_texto = "Informe seus dados!";
  void _ResetaDadosInseridos() {
    controla_peso.text = "";
    controla_altura.text = "";

    setState(() {
      _info_texto = "Informe seus dados!";
        _formKey = GlobalKey<FormState>();
    });
  }

  void _calcula_imc() {
    setState(() {
      double peso = double.parse(controla_peso.text);
      double altura = double.parse(controla_altura.text) / 100;
      double imc_result = peso / (altura * altura);

      if (imc_result < 18.6) {
        _info_texto = "Abaixo do Peso (${imc_result.toStringAsPrecision(3)})";
      } else if (imc_result >= 18.6 && imc_result < 24.9) {
        _info_texto = "Peso Ideal: ${imc_result.toStringAsPrecision(3)}";
      } else if (imc_result >= 24.9 && imc_result < 29.9) {
        _info_texto = "Sobrepeso: ${imc_result.toStringAsPrecision(3)}";
      } else if (imc_result >= 29.9 && imc_result < 34.9) {
        _info_texto = "Obesidade Grau I: ${imc_result.toStringAsPrecision(3)}";
      } else if (imc_result >= 34.9 && imc_result < 39.9) {
        _info_texto = "Obesidade Grau II: ${imc_result.toStringAsPrecision(3)}";
      } else if (imc_result >= 40) {
        _info_texto =
            "Obesidade Grau III: ${imc_result.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
                onPressed: _ResetaDadosInseridos, icon: Icon(Icons.refresh)),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 120,
                    color: Colors.green,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                  controller: controla_peso,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                  controller: controla_altura,
                    validator: (value){
                    if(value!.isEmpty){
                      return "Insira sua altura";
                    }
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _calcula_imc();

                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "$_info_texto",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
