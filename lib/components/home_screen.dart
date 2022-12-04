import 'package:flutter/material.dart';

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
      backgroundColor: const Color.fromRGBO(45, 20, 44, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(128, 19, 54, 1),
        centerTitle: true,
        title: const Text(
          'Alcool ou Gasolina',
          style: TextStyle(
            color: Color.fromRGBO(238, 69, 64, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Image.asset(
                'assets/images/gasoline-pump.png',
                fit: BoxFit.cover,
                // color: const Color.fromRGBO(238, 69, 64, 1),
                height: 150,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Saiba qua a melhor opção para o abastecimento do seu carro!",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(238, 69, 64, 1),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Preço alcool, ex: 1.59',
                    style: TextStyle(
                      color: Color.fromRGBO(238, 69, 64, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(81, 10, 50, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLength: 5,
                      style: const TextStyle(
                        color: Color.fromRGBO(238, 69, 64, 1),
                      ),
                      cursorColor: const Color.fromRGBO(238, 69, 64, 1),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      controller: _alcoholController,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Preço gasolina, ex: 3.15',
                    style: TextStyle(
                      color: Color.fromRGBO(238, 69, 64, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(81, 10, 50, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      style: const TextStyle(
                        color: Color.fromRGBO(238, 69, 64, 1),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromRGBO(238, 69, 64, 1),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: _gasolineController,
                    ),
                  ),
                ),
              ],
            ),
            Container(
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
    );
  }
}
