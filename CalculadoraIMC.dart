import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraIMCApp());
}

class CalculadoraIMCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculadoraIMCScreen(),
    );
  }
}

class CalculadoraIMCScreen extends StatefulWidget {
  @override
  _CalculadoraIMCScreenState createState() => _CalculadoraIMCScreenState();
}

class _CalculadoraIMCScreenState extends State<CalculadoraIMCScreen> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  double resultado = 0;
  String categoria = '';

  void calcularIMC() {
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    if (altura > 0) {
      setState(() {
        resultado = peso / (altura * altura);

        if (resultado < 18.5) {
          categoria = 'Abaixo do peso';
        } else if (resultado >= 18.5 && resultado < 25) {
          categoria = 'Peso normal';
        } else if (resultado >= 25 && resultado < 30) {
          categoria = 'Acima do peso';
        } else {
          categoria = 'Obesidade';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularIMC,
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            resultado == 0
                ? Container()
                : Column(
                    children: <Widget>[
                      Text(
                        'Seu IMC: ${resultado.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Categoria: $categoria',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: categoria == 'Obesidade'
                              ? Colors.red
                              : Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
               ),
          ],
        ),
      ),
    );
  }
}
