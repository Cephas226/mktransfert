import 'package:flutter/material.dart';
import 'package:mktransfert/src/page/existingCardsPage.dart';
import 'package:mktransfert/src/services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stripe_payment/stripe_payment.dart';



class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => new _PaymentPageState();
}

class _PaymentPageState  extends State<PaymentPage>{
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = null; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  onItemPress(BuildContext context, int index) async {
    switch(index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ExistingCardsPage()));
        break;
    }
  }
  void setError(dynamic error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Patiencer svp...'
    );
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        StripePayment.confirmPaymentIntent(
          PaymentIntent(
            clientSecret: _currentSecret,
            paymentMethodId: _paymentMethod.id,
          ),
        ).then((paymentIntent) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Received ${paymentIntent.paymentIntentId}')));
          setState(() {
            _paymentIntent = paymentIntent;
          });
        }).catchError(setError)
    );
    await dialog.hide();
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payement'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Icon icon;
              Text text;

              switch(index) {
                case 0:
                  icon = Icon(Icons.add_circle, color: theme.primaryColor);
                  text = Text('Payez via une carte');
                  break;
                case 1:
                  icon = Icon(Icons.credit_card, color: theme.primaryColor);
                  text = Text('Pay via une carte existante');
                  break;
              }

              return InkWell(
                onTap: () {
                  onItemPress(context, index);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: theme.primaryColor,
            ),
            itemCount: 2
        ),
      ),
    );
  }
  }

