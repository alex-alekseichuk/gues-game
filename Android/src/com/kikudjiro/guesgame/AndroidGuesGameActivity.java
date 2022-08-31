package com.kikudjiro.guesgame;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class AndroidGuesGameActivity extends Activity {
	private TextView _lblMessage;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        _lblMessage = (TextView)findViewById(R.id.lblMessage);

        ((Button)findViewById(R.id.btnStart)).setOnClickListener(new View.OnClickListener() {
			public void onClick(View v) {
				_start();
			}
		});
        
        final int[] btnIds = {
        		R.id.btn1, R.id.btn2, R.id.btn3, R.id.btn4, R.id.btn5,
        		R.id.btn6, R.id.btn7, R.id.btn8, R.id.btn9, R.id.btn10
        };
        for (int i = 0; i < 10; ++i) {
        	final int iButton = i + 1;
	        ((Button)findViewById(btnIds[i])).setOnClickListener(new View.OnClickListener() {
				public void onClick(View v) {
					_play(iButton);
				}
			});
        }
        init();
        _start();
    }
    
    private void _start() {
    	_lblMessage.setText("Try to gues a number between 1 and 10 in 3 attempts.");
    	
    	start();
    	
    	//lua_getglobal(_L, "gameStart");
    	//lua_pcall(_L, 0, 0, 0);
    }
    private void _play(int a) {
    	int result = play(a);
    	
    	//lua_getglobal(_L, "gamePlay");
    	//lua_pushnumber(_L, a);
    	//lua_pcall(_L, 1, 1, 0);
    	//result = lua_tonumber(_L, 1);
    	//lua_pop(_L, 1);
    	switch (result)
    	{
    		case 1: // WIN
    			_lblMessage.setText("Win! :-)");
    			break;
    		case 2: // LOSE
    			_lblMessage.setText("Lose :-(");
    			break;
    		case 3: // GREATER
    			_lblMessage.setText("Greater");
    			break;
    		case 4: // LESS
    			_lblMessage.setText("Less");
    			break;
    		default:
    			_lblMessage.setText("Error");
    			break;
    	}	
    }
    
    public native void init();    
    public native void start();    
    public native int play(int a);
    
    static {
        System.loadLibrary("guesgame-jni");
    }
    
    
}