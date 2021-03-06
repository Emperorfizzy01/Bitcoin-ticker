import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/price_screen.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var bitcoinValueInUSD = '?';

  CoinData coin = CoinData();

  void getData() async {
    try {
      var data = await CoinData().getCryptoPrice(selectedCurrency);

      setState(() {
        bitcoinValueInUSD = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdown = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var currency = currenciesList[i];
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdown.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdown,
      onChanged: (String newValue) {
        setState(() {
          selectedCurrency = newValue;

          getData();
        });
      },
    );
  }

  CupertinoPicker iosdropdown() {
    List<Text> cupertino = [];
    for (String currency in currenciesList) {
      var newItem = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      cupertino.add(newItem);
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];

            getData();
          });
        },
        children: cupertino);
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iosdropdown();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('???? Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValueInUSD $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
