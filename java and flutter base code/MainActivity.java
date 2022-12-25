package com.example.light;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;

public class MainActivity extends AppCompatActivity {

    boolean isLightOn = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void switchLight(View view) {
        if (isLightOn) {
            ((ImageButton) view).setBackground(getDrawable(R.drawable.red));
        }
        else
            ((ImageButton) view).setBackground(getDrawable(R.drawable.green));

        isLightOn = !isLightOn;
    }
}