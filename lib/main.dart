import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_share/image_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Gerar recibo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _nomeCliente = '';
  String _enderecoEntrega = '';
  String _pedido = '';
  double _valor = 0.0;
  double _entrada = 0.0;
  double _restante = 0.0;
  DateTime _datetime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _setRestante() {
    setState(() {
      _restante = _valor - _entrada;
    });
  }

  @override
  void initstate() {
    super.initState();
  }

  Future<void> _generateReceipt() async {
    await ImageShare.shareImage(filePath: "assets/images/logo.png");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'Nome do cliente...',
                labelText: 'Cliente',
              ),
              onChanged: (value) {
                setState(() {
                  _nomeCliente = value;
                });
              },
            ),

            TextFormField(
              decoration: InputDecoration(
                filled: true,
                hintText: 'Endereço de entrega...',
                labelText: 'Endereço',
              ),
              onChanged: (value) {
                setState(() {
                  _enderecoEntrega = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                filled: true,
                hintText: 'Lista do pedido...',
                labelText: 'Pedido',
              ),
              onChanged: (value) {
                _pedido = value;
              },
              maxLines: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Valor',
                hintText: "Valor do pedido... ",
              ),
              onChanged: (input) {
                _valor = double.parse(input);
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Entrada',
                hintText: "Primeiro pagamento... ",
              ),
              onChanged: (input) {
                _entrada = double.parse(input);
                _setRestante();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_datetime == null
                    ? 'Selecione a data...'
                    : _datetime.toString()),
                FlatButton(
                  child: Text('Data'),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate:
                                _datetime == null ? DateTime.now() : _datetime,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2021))
                        .then((date) {
                      setState(() {
                        _datetime = date;
                      });
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_timeOfDay == null
                    ? 'Selecione a hora...'
                    : _timeOfDay.toString()),
                FlatButton(
                  child: Text('Hora'),
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime:
                          _timeOfDay == null ? TimeOfDay.now() : _timeOfDay,
                    ).then((time) {
                      setState(() {
                        _timeOfDay = time;
                      });
                    });
                  },
                ),
              ],
            ),
            Text(
              'Resta: $_restante',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _generateReceipt(),
        child: Icon(Icons.share),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
