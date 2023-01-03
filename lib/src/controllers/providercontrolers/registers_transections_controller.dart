import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctrl_real/src/model/registers_model.dart';
import 'package:ctrl_real/src/services/firebase_auth.dart';
import 'package:ctrl_real/src/view/databases/firestore_database.dart';
import 'package:flutter/cupertino.dart';

class HistoryController extends ChangeNotifier {
  final List<TotalandCategory> registersList = [];
  late FirebaseFirestore datb;
  late UsersService authentinc;

  HistoryController({required this.authentinc}) {
    _initdataFire();
  }

  _initdataFire() async {
    await _firebaserepository();
  }

  _firebaserepository() {
    datb = FireStoreDb.get();
  }

  final List<TotalandCategory> registerUser = [];

  double valorLimite = 0;
  double renda = 5000;
  double saldoDisponivel = 0;
  double saida = 0;
  double supermerc = 0;
  double lazer = 0;
  double transpor = 0;
  double gastosex = 0;
  double pagament = 0;
  double farmac = 0;
  String nome = "";
  String email = "";
  String senha = "";

  String nomeUser(String user) {
    return nome = user;
  }

  String emailUser(String emailUser) {
    return email = emailUser;
  }

  String senhaUser(String senhaUser) {
    return senha = senhaUser;
  }

  double rendaInicial(double rendaInicial) {
    return renda = rendaInicial;
  }

  addNewUser(TotalandCategory user) {
    registerUser.add(user);
    notifyListeners();
  }

  addTotaltransection(TotalandCategory trans) async {
    await datb
        .collection("usuarios/${authentinc.usuario!.uid}/transacoes")
        .doc(trans.id)
        .set(trans.toMap());
    registersList.add(trans);
    notifyListeners();
  }

  addCategoriesPrimary() async {
    String id = 'categoriesid';
    await datb
        .collection("usuarios/${authentinc.usuario!.uid}/categories")
        .doc(id)
        .set({
      'supermercado': supermerc,
      'lazer': lazer,
      'transporte': transpor,
      'farmacia': farmac,
      'pagamentos': pagament,
      'gastosex': gastosex,
    });
  }

  addValueCategory(double result, String categorynames) async {
    String id = 'categoriesid';
    if (categorynames == 'Supermercado') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .update({
        'supermercado': supermerc + result,
      });
      supermerc += result;
    } else if (categorynames == 'Lazer') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .update({
        'lazer': lazer + result,
      });
      lazer += result;
    } else if (categorynames == 'Transporte') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .update({
        'transporte': transpor + result,
      });
      transpor += result;
    } else if (categorynames == 'Farmacia') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .update({
        'farmacia': farmac + result,
      });
      farmac += result;
    } else if (categorynames == 'Pagamentos') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .update({
        'pagamentos': pagament + result,
      });
      pagament += result;
    } else {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .update({
        'gastosex': gastosex + result,
      });
      gastosex += result;
    }
    notifyListeners();
  }

  Future<void> transaction() async {
    if (authentinc.usuario != null) {
      QuerySnapshot read = await datb
          .collection('usuarios/${authentinc.usuario!.uid}/categories')
          .get();
      for (var element in read.docs) {
        supermerc = element.get('supermercado');
        lazer = element.get('lazer');
        transpor = element.get('transporte');
        farmac = element.get('farmacia');
        pagament = element.get('pagamentos');
        gastosex = element.get('gastosex');
      }
    }
    notifyListeners();
  }

  Future<void> transactionsread() async {
    if (authentinc.usuario != null && registersList.isEmpty) {
      QuerySnapshot read = await datb
          .collection('usuarios/${authentinc.usuario!.uid}/transacoes')
          .get();
      for (var element in read.docs) {
        TotalandCategory lista = TotalandCategory.fromFirestore(
            element.data() as Map<String, dynamic>);
        registersList.add(lista);
      }
    }
  }

  void removeByID(String id) async {
    await datb
        .collection("usuarios/${authentinc.usuario!.uid}/transacoes")
        .doc(id)
        .delete();
    registersList.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  removePorcentChart(String index) {
    var element = registersList.where((element) => element.id == index).first;
    menosValueCategory(element.valor, element.categoryname ?? '');
  }

  double atualizarLimite(double result) {
    return (valorLimite += result) * 100 / renda;
  }

  double novaRenda(double result) {
    return renda += result;
  }

  double novoSaldoEntrada(double result) {
    return saldoDisponivel += result;
  }

  double novoSaldoSaida(double result) {
    return saldoDisponivel -= result;
  }

  double totalSaida(double result) {
    return saida += result;
  }

  menosValueCategory(double result, String categorynames) async {
    String id = 'categoriesid';
    if (categorynames == 'Supermercado') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .set({
        'supermercado': supermerc - result,
        'lazer': lazer,
        'transporte': transpor,
        'farmacia': farmac,
        'pagamentos': pagament,
        'gastosex': gastosex,
      });
      supermerc -= result;
    } else if (categorynames == 'Lazer') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .set({
        'supermercado': supermerc,
        'lazer': lazer - result,
        'transporte': transpor,
        'farmacia': farmac,
        'pagamentos': pagament,
        'gastosex': gastosex,
      });
      lazer -= result;
    } else if (categorynames == 'Transporte') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .set({
        'supermercado': supermerc,
        'lazer': lazer,
        'transporte': transpor - result,
        'farmacia': farmac,
        'pagamentos': pagament,
        'gastosex': gastosex,
      });
      transpor -= result;
    } else if (categorynames == 'Farmacia') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .set({
        'supermercado': supermerc,
        'lazer': lazer,
        'transporte': transpor,
        'farmacia': farmac - result,
        'pagamentos': pagament,
        'gastosex': gastosex,
      });
      farmac -= result;
    } else if (categorynames == 'Pagamentos') {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .set({
        'supermercado': supermerc,
        'lazer': lazer,
        'transporte': transpor,
        'farmacia': farmac,
        'pagamentos': pagament - result,
        'gastosex': gastosex,
      });
      pagament -= result;
    } else {
      await datb
          .collection("usuarios/${authentinc.usuario!.uid}/categories")
          .doc(id)
          .set({
        'supermercado': supermerc,
        'lazer': lazer,
        'transporte': transpor,
        'farmacia': farmac,
        'pagamentos': pagament,
        'gastosex': gastosex - result,
      });
      gastosex -= result;
    }
    notifyListeners();
  }

  double porcentSupermerc(double result) {
    return result = supermerc * 100 / renda;
  }

  double porcentLazer(double result) {
    return result = lazer * 100 / renda;
  }

  double porcentTranspor(double result) {
    return result = transpor * 100 / renda;
  }

  double porcentGastosex(double result) {
    return result = gastosex * 100 / renda;
  }

  double porcentPagament(double result) {
    return result = pagament * 100 / renda;
  }

  double porcentFarmac(double result) {
    return result = farmac * 100 / renda;
  }

  double porcentSaida(double result) {
    return result = (saida * 100 / renda) / 100;
  }

  double porcentAtualizar(double result) {
    return result = saida * 100 / renda;
  }

  double porcentAtualizardisp(double result) {
    return result = renda * 100 / renda;
  }
}
