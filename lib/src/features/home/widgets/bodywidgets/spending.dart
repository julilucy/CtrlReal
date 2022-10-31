import 'package:ctrl_real/src/controllers/themes/darmodcontroller.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Speding extends StatelessWidget {
  const Speding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, left: 16, right: 16),
      child: AnimatedBuilder(
          animation: DarkController.instance,
          builder: (BuildContext context, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: DarkController.instance.darkmod
                        ? const Color.fromARGB(213, 19, 19, 19)
                        : const Color.fromARGB(220, 104, 89, 205),
                    boxShadow: kElevationToShadow[0.8],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  height: 32,
                  child: const Center(
                    child: Text(
                      "Limite",
                      style: TextStyle(fontSize: 24, color: Color(0xdfffffff)),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  decoration: BoxDecoration(
                    color: DarkController.instance.darkmod
                        ? const Color.fromARGB(213, 19, 19, 19)
                        : const Color.fromARGB(220, 104, 89, 205),
                    boxShadow: kElevationToShadow[4],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  height: 124,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 34,
                      ),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 10,
                        animation: true,
                        lineHeight: 30.0,
                        animationDuration: 2500,
                        percent: 0.7,
                        center: const Text(
                          "70.0%",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        barRadius: const Radius.circular(16),
                        progressColor: const Color.fromARGB(255, 63, 138, 224),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Você tem 30% para o limite total',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)))
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
