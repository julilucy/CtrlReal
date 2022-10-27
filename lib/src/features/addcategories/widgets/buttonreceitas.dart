import 'package:ctrl_real/src/controllers/themes/darmodcontroller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class ButtomReceitas extends StatefulWidget {
  const ButtomReceitas({super.key});

  @override
  State<ButtomReceitas> createState() => _ButtomReceitasState();
}

class _ButtomReceitasState extends State<ButtomReceitas> {
  double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(220, 104, 89, 205),
        ),
        child: const Text('Receita'),
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  height: 640,
                  color: DarkController.instance.darkmod
                      ? const Color.fromARGB(255, 41, 41, 41)
                      : const Color.fromARGB(187, 255, 255, 255),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 40),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Receitas',
                            style: TextStyle(
                              fontSize: 20,
                              color: DarkController.instance.darkmod
                                  ? const Color.fromARGB(207, 255, 255, 255)
                                  : const Color.fromARGB(220, 104, 89, 205),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 40,
                                validator: (value) {
                                  if (value!.length < 3 || value.length > 40) {
                                    return "Informe uma descrição";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  helperText: "Campo obrigatório",
                                  labelText: 'Descrição',
                                  hintText: "Hora extra...",
                                  labelStyle: TextStyle(
                                    color: DarkController.instance.darkmod
                                        ? const Color.fromARGB(
                                            207, 255, 255, 255)
                                        : const Color.fromARGB(
                                            220, 104, 89, 205),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(220, 104, 89, 205),
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                CurrencyTextInputFormatter(
                                    locale: 'pt-BR',
                                    decimalDigits: 2,
                                    symbol: '')
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(220, 104, 89, 205),
                                  ),
                                ),
                                labelText: "Valor",
                                labelStyle: TextStyle(
                                  color: DarkController.instance.darkmod
                                      ? const Color.fromARGB(207, 255, 255, 255)
                                      : const Color.fromARGB(220, 104, 89, 205),
                                ),
                                hintText: "0,00",
                                prefix: const Text("R\$"),
                                helperText: "Máximo de 999.999,99 digitos",
                              ),
                              maxLength: 10,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Informe um valor";
                                }
                                ;
                                final valueDouble = double.parse(value
                                    .replaceAll(".", "")
                                    .replaceAll(",", "."));
                                if (valueDouble == 0) {
                                  return "Informe um valor diferente de 0";
                                }
                                return null;
                              },
                              onSaved: ((newValue) => value = double.parse(
                                  newValue!
                                      .replaceAll(".", "")
                                      .replaceAll(",", "."))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 130,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(220, 104, 89, 205),
                                    ),
                                    child: const Text('Voltar'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 48, 201, 43)),
                                    child: const Text('Registrar'),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}