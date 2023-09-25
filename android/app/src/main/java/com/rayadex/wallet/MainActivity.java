package com.rayadex.wallet;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    public MainActivity(){
        System.loadLibrary("TrustWalletCore");
    }

}
