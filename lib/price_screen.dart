import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  List rateList = [];
  String btcRate = '?';

  Widget getAndriodDropdown() {
    List<DropdownMenuItem<String>> dataList = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dataList.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dataList,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            var selectedCoin =
                rateList.indexWhere((item) => item.endsWith(value));
            print(selectedCoin);
            try {
              btcRate = rateList[selectedCoin] ?? "?";
            } catch (e) {
              print(e);
            }
            print(value);
          });
        });
  }

  Widget getIosPicker() {
    List<Widget> dataList = [];
    for (String currency in currenciesList) {
      dataList.add(Text((currency)));
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32,
        children: dataList,
        onSelectedItemChanged: (index) {
          selectedCurrency = rateList[index];
          try {
            btcRate = rateList[index] ?? "?";
          } catch (e) {
            print(e);
          }
        });
  }

  void getData() async {
    try {
      List<dynamic> data = await CoinData().getCoinData();
      setState(() {
        rateList = data;
        print(rateList);
        btcRate = rateList[0];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var rate = await CoinData().getData();
    //print(rate);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcRate $selectedCurrency',
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
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? getAndriodDropdown() : getIosPicker(),
          ),
        ],
      ),
    );
  }
}


// Platform.isAndroid ? getAndriodDropdown() :