import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:get/get.dart';
// import '/main.dart';

class WrAlerts {
  // definicion de variables
  //final BuildContext contextoGlobal = navigatorKey.currentContext!;
  late BuildContext contextoGlobal;
  late GlobalKey<NavigatorState> navigatorKey;
  static const confirmBtnText = 'OK';

  // constructor
  WrAlerts(GlobalKey<NavigatorState> navKey){
    navigatorKey = navKey;
    contextoGlobal = navigatorKey.currentContext!;
  }
  //  {
  //   contextoGlobal = context;
  // }


  // metodos  auxiliares
  Duration? _duration (int? time){
    if (time == null || time == 0) {
      return null;
    } else {
      return Duration(seconds: time);
    }
  }
  BuildContext? _contexto (BuildContext? contextoParam) {
    return contextoParam ?? contextoGlobal ;
  }

  // helpers
  // quickAlert
  void qaError(String msg, {String title = '', bool pop = false, BuildContext? contextoOpcional ,}) {
    _show(msg, title: title, type: "error", pop: pop , tool: 'qa') ;
  }
  void qaOk(String msg, {String title = '', int time = 0, bool pop = false, BuildContext? contextoOpcional ,}) {
    _show(msg, title: title, type: "ok", time: time, pop: pop, tool: 'qa');
  }
  void qaInfo(String msg, {String title = '', int time = 0, bool pop = false, BuildContext? contextoOpcional ,}) {
    _show(msg, title: title, type: "info", time: time, pop: pop, tool: 'qa');
  }
  void qaAlerta(String msg,{String title = '', int time = 0, bool pop = false, BuildContext? contextoOpcional ,}) {
    _show(msg, title: title, type: "alerta", time: time, pop: pop, tool: 'qa');
  }
  void qaProcesando(String msg,{String title = '', int time = 0, bool pop = false, BuildContext? contextoOpcional ,}) {
    _show(msg, title: title, type: "procesando", time: time, pop: pop, tool: 'qa');
  }
  void qaCallback(String msg,{String title = '', int time = 0, bool pop = true, BuildContext? contextoOpcional ,dynamic ruta}) {
    _show(msg, title: title, type: "callback", time: time, pop: pop, tool: 'qa' , ruta: ruta);
  }
  void simpleError(String msg) {
    _show(msg,type: 'error', tool: 'widget');
  }
  void simpleOk(String msg) {
    _show(msg,type: 'ok', tool: 'widget');
  }
  void simpleInfo(String msg) {
    _show(msg,type: 'info', tool: 'widget');
  }
  void simpleAlerta(String msg) {
    _show(msg,type: 'alerta', tool: 'widget');
  }
  void snack(String msg) {
    _show(msg, tool: 'snack');
  }
  void snackSimple(String msg) {
    _show(msg, type:'simple', tool: 'snack');
  }
  void snackFormato(String msg, {int time = 4 }) {
    _show(msg, type:'formato', tool: 'snack' , time: time);
  }

  void getSnackTop(String msg, {int time = 4 ,String title ='AVISO', Widget icono = const Icon(Icons.pan_tool)}) {
    _get(msg, tool: 'snack' , time: time , position: 'top' , icono:icono, title:title);
  }
  void getSnackBottom(String msg, {int time = 4 ,String title ='AVISO', Widget icono = const Icon(Icons.pan_tool)}) {
    _get(msg, tool: 'snack' , time: time, icono:icono, title:title);
  }

    void getDialog(String msg, {String title ='AVISO IMPORTANTE!!'}) {
    _get(msg, tool: 'dialog' , title:title);
  }

  // métodos principales

  // lista de iconos
  // https://fonts.google.com/icons?selected=Material+Icons:pan_tool:

  void _get(String msg , { String tool = 'snackbar',String title ='AVISO' , int time = 5,
  dynamic position = 'bottom', Widget icono = const Icon(Icons.pan_tool),
  }){

    if (position == 'top') {
      position = SnackPosition.TOP;
    } else {
      position = SnackPosition.BOTTOM;
    }
    // TO DO: falta agregarle mas opciones de formato
    if (tool == 'snack') {
      Get.snackbar(title, msg,
        snackPosition: position,
        icon: icono,
        shouldIconPulse: true,
        barBlur: 20,
        isDismissible: true,
        duration:  _duration(time),
        // dismissDirection: SnackPosition.BOTTOM,
      );
    } else {
      Get.defaultDialog(title: title,middleText: msg);
    }
  }

  void _show(
      String msg, 
      {String title = '', int time = 0, String tool = 'get', 
      String type = 'info',bool pop = false, 
      BuildContext? contextoOpcional , dynamic ruta,})
    {
    try {
      // preparacion variables
      BuildContext? contexto = _contexto (contextoOpcional);
      if (contexto == null) {
        tool = 'get';
      }


      switch (tool) {
        case 'get': 

        break;

        case 'snack':
          switch (type) {
            case 'simple':
              ScaffoldMessenger.of(contexto!).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  action: SnackBarAction(
                    textColor: Colors.yellow.shade400,
                    label: 'Cerrar',
                    onPressed: () {
                      // TO DO: Snackbar implement action onPressed
                    },
                  ),
                ),
              );
              break;
            case 'formato':
              // TO DO: Snackbar - mejorar formato
              ScaffoldMessenger.of(contexto!).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  // animation: ,
                  dismissDirection: DismissDirection.up,
                  showCloseIcon: true,
                  closeIconColor: Colors.yellowAccent,
                  duration: _duration(time)!,
                  width: 280.0, // Width of the SnackBar.
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, // Inner padding for SnackBar content.
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
              break;
            default:
              ScaffoldMessenger.of(contexto!).showSnackBar(SnackBar(content: Text(msg)));
              break;
          }
        
        break;
        case 'qa':
          Map<String, dynamic> types = {
            'ok': QuickAlertType.success,
            'error': QuickAlertType.error,
            'alerta': QuickAlertType.warning,
            'info': QuickAlertType.info,
            'confirma': QuickAlertType.confirm,
            'procesando': QuickAlertType.loading,
          };
          if (pop) {
            // Navigator.pop(contexto!);
            Get.back();
          }
          switch (type) {
            case 'confirma':
              QuickAlert.show(
                context: contexto!,
                type: types[type],
                text: msg,
                title: title,
                confirmBtnText: 'Si',
                cancelBtnText: 'No',
                confirmBtnColor: Colors.green,
              );
              break;
            case 'loading':
              QuickAlert.show(
                context: contexto!,
                type: types[type],
                text: msg,
                title: title,
                autoCloseDuration: _duration(time),
              );
              break;
            case 'callback':
              QuickAlert.show(
                context: contexto!,
                type: QuickAlertType.success,
                text: msg,
                title: title,
                showCancelBtn : true,
                cancelBtnText: 'Cancelar',
                cancelBtnTextStyle: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                confirmBtnText: confirmBtnText,
                autoCloseDuration: _duration(time),
                onConfirmBtnTap: () {
                  if (pop) {
                    Navigator.pop(contexto);
                    // Get.back();
                  }
                  Get.to(ruta);
                },
              );
              break;

            default:
              QuickAlert.show(
                context: contexto!,
                type: types[type],
                text: msg,
                title: title,
                confirmBtnText: confirmBtnText,
                autoCloseDuration:  _duration(time),
              );
              break;
          }
          break;
        case 'widget':
          Color bkgColor = Colors.blue.shade900;
          switch (type) {
            case 'error':
              bkgColor = Colors.red.shade700;
              break;
            case 'ok':
              bkgColor = Colors.green.shade800;
              break;
            case 'alerta':
              bkgColor = Colors.yellow.shade800;
              break;
          }
          showDialog(
            context: contexto!,
            builder: (contexto) {
              return AlertDialog(
                backgroundColor: bkgColor,
                title: Center(
                  child: Text(msg, style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          );
          break;



        default:

      }
    } catch (e) {
      msg = "Error mostrando alerta \n Código de error: ${e.toString()}";
      Get.snackbar('Atención', msg,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.alarm),
        shouldIconPulse: true,
        barBlur: 20,
        isDismissible: true,
        //duration: const Duration(seconds: 10)
        // dismissDirection: SnackPosition.BOTTOM,
        );
    }  
  }

}

/*
    ejemplo de callback con MaterialPageRoute
    
    final MaterialPageRoute ruta = MaterialPageRoute(builder: (context) {
      return const LoginOrRegisterPage();
    });
    WrAlerts().callback(
      'Te enviamos un correo con el link para resetear tu contraseña.',
      ruta,
      title: "Por favor, revisá tu correo"
    );


  void callbackOld(String msg, MaterialPageRoute ruta,
      {String title = '', int time = 0, bool pop = false}) {


    if (pop) {
      Navigator.pop(contexto);
    }
    QuickAlert.show(
      context: contexto,
      type: QuickAlertType.success,
      text: msg,
      title: title,
      confirmBtnText: 'OK',
      autoCloseDuration: _duration(time),
      onConfirmBtnTap: () {
        Navigator.push(contexto, ruta);
      },
    );
  }
*/