package com.example.psn_root;

import android.os.Handler;
import android.os.Message;
import androidx.annotation.Keep;
@Keep
public class PsnH extends Handler {
    @Keep
    public PsnH() {

    }
    @Keep
    @Override
    public void handleMessage(Message message) {
        int r0 = message.what;
        PsnL.PsnB(r0);
    }
}

