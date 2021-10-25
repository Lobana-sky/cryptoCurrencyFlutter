// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'currecny_exchange.dart';
import 'currency_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  CurrencyExchange crypto = CurrencyExchange();
  
  String selectedValue = 'USD';

  List<double> rateList = [0, 0, 0];

  DropdownButton androidDropdwon() {
    List<DropdownMenuItem<String>> dropdownItems =
        currenciesList.map((currency) {
      return DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
    }).toList();

    return DropdownButton(
      value: selectedValue,
      items: dropdownItems,
      onChanged: (value) {
        updateUI(value);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = currenciesList.map((currency) {
      return Text(currency);
    }).toList();

    return CupertinoPicker(
      itemExtent: 32.0,
      children: pickerItems,
      onSelectedItemChanged: (selectedIndex) {
        updateUI(currenciesList[selectedIndex]);
      },
      backgroundColor: Colors.lightBlue,
    );
  }

  void updateUI(String selectedCurrency) async {
    var BTCrate = await crypto.getExchangeData('BTC', selectedValue);
    var ETHrate = await crypto.getExchangeData('ETH', selectedValue);
    var LTCrate = await crypto.getExchangeData('LTC', selectedValue);

    setState(() {
      if (rateList[0] == null) {
        rateList = [0, 0, 0];
        return;
      }
      selectedValue = selectedCurrency;
      rateList[0] = BTCrate['rate'];
      rateList[1] = ETHrate['rate'];
      rateList[2] = LTCrate['rate'];
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI('USD');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CurrencyCard(
              cryptoCurrency: 'BTC',
              rateList: rateList[0],
              selectedValue: selectedValue),
          CurrencyCard(
              cryptoCurrency: 'ETH',
              rateList: rateList[1],
              selectedValue: selectedValue),
          CurrencyCard(
              cryptoCurrency: 'LTC',
              rateList: rateList[2],
              selectedValue: selectedValue),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: false ? iOSPicker() : androidDropdwon(),
          ),
        ],
      ),
    );
  }
}
