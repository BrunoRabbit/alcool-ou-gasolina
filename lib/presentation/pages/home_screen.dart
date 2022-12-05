import 'package:alcool_ou_gasolina/components/custom_row_input.dart';
import 'package:flutter/material.dart';

extension DoubleHelper on double {}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _alcoholController = TextEditingController();

  final TextEditingController _gasolineController = TextEditingController();

  String errorMessage = "";

  void calculate() {
    double? _alcoholValue = double.tryParse(_alcoholController.text);
    double? _gasolineValue = double.tryParse(_gasolineController.text);

    if (_alcoholValue == null || _gasolineValue == null) {
      setState(() {
        errorMessage =
            "Valor inválido - Insira valores maiores que 0 e separados por ( . )";
      });
    } else {
      if ((_alcoholValue / _gasolineValue) >= 0.7) {
        setState(() {
          errorMessage = "Melhor abastecer com Gasolina";
        });
      } else {
        setState(() {
          errorMessage = "Melhor abastecer com Alcool";
        });
      }
    }
  }

  /*

    Color.fromRGBO(238, 69, 64, 1) - #EE4540 - laranja pouco escuro
    Color.fromRGBO(199, 44, 65, 1) - #C72C41 - vermelho
    Color.fromRGBO(128, 19, 54, 1) - #801336 - vermelho escuro
    Color.fromRGBO(81, 10, 50, 1) - #510A32 - roxo escuro
    Color.fromRGBO(45,20,44,1) - #2D142C - preto/marrom escuro

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text(
          'Alcool ou Gasolina',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Image.asset(
                  'assets/images/gasoline-pump.png',
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
              const Text(
                "Saiba qua a melhor opção para o abastecimento do seu carro!",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomRowInput(
                label: 'Preço alcool, ex: 1.59',
                controller: _alcoholController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomRowInput(
                label: 'Preço gasolina, ex: 3.15',
                controller: _gasolineController,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ElevatedButton(
                        child: const Text(
                          'Calcular',
                          style: TextStyle(
                            color: Color.fromRGBO(238, 69, 64, 1),
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          primary: const Color.fromRGBO(128, 19, 54, 1),
                        ),
                        onPressed: () => calculate(),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Color.fromRGBO(238, 69, 64, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
