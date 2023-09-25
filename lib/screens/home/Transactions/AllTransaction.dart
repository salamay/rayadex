import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryipay/component/app_component.dart';
import 'package:ryipay/component/texts/MediumText.dart';
import 'package:ryipay/component/texts/SmallText.dart';
import 'package:ryipay/screens/home/Wallets/coins_controller/TransactionController.dart';
import 'package:ryipay/screens/home/Wallets/model/supported_coin.dart';

class AllTransaction extends StatelessWidget {
  SupportedCoin asset;
  AllTransaction({Key? key,required this.asset}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10.sp),
          height: height,
          width: width,
          child: Center(
            child: Consumer<TransactionController>(
              builder: (context, txCtr, child) {
                return txCtr.transactions[asset.wallet_address]!.isEmpty?Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.call_missed_outgoing,
                      color: primary_color_light,
                      size: 40.sp,
                    ),
                    SizedBox(height: 10.sp,),
                    SmallText(
                      text: "You have no transactions",
                      color: w60_text_color,
                      weight: FontWeight.normal,
                      align: TextAlign.start,
                      maxLines: 1,
                    ),
                  ],
                ):Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: txCtr.transactions[asset.wallet_address]!.map((e){
                    return ListTile(
                      onTap: (){

                      },
                      title: SmallText(
                        text: "From: ${e.from}",
                        color: w_text_color,
                        weight: FontWeight.w700,
                        align: TextAlign.start,
                        maxLines: 1,
                      ),
                      subtitle: SmallText(
                        text: "To: ${e.to}",
                        color: w_text_color,
                        weight: FontWeight.w700,
                        align: TextAlign.start,
                        maxLines: 1,
                      ),
                      trailing: SmallText(
                        text: e.amount!,
                        color: w_text_color,
                        weight: FontWeight.w700,
                        align: TextAlign.start,
                        maxLines: 1,
                      )
                    );
                  }).toList()
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
