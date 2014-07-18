import java.util.Date;
import android.os.Environment;
import android.view.inputmethod.InputMethodManager;
import android.content.Context;
import android.view.MotionEvent;

//*******************GLOBAL VARIABLES**************************
Date birthday = new Date(94, 9, 21);
long deathDate; 
int screen = 0;
boolean pressed = false;

//default colors
color backgroundColor = color(255, 255, 0);
color textColor1 = color(255, 0, 171);
color textColor2 = color(255, 255, 0);
color fieldColor = color(0, 255, 255);

//gui objects
TextField year;
TextField month;
TextField day;
Button button;
//****************END GLOBAL VARIABLES*************************

// initial setup method
void setup()
{
  //set the visual properties for the sketch
  size(displayWidth, displayHeight);
  orientation(PORTRAIT);
  smooth();
  textAlign(CENTER);
  rectMode(CENTER);
  frameRate(15); //limit frame rate for efficiency

  //create textfields and buttons
  year = new TextField(int(displayWidth*0.25), int(displayHeight*0.55), int(displayWidth/2.5), int(displayHeight/8), 4);
  month = new TextField(int(displayWidth*0.6), int(displayHeight*0.55), int(displayWidth/5), int(displayHeight/8), 2);
  day = new TextField(int(displayWidth*0.85), int(displayHeight*0.55), int(displayWidth/5), int(displayHeight/8), 2);
  button = new Button(int(displayWidth/2), int(displayHeight*0.8), int(displayWidth*0.9), int(displayHeight/8), "ENTER");


  File f = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/save.txt"); //if save file doesnt exist, create one
  if (!f.exists())
  {
    PrintWriter output = createWriter(Environment.getExternalStorageDirectory().getAbsolutePath() + "/save.txt");
    output.close();
  }
  else { 
    screen = 1; //if save file exists, go directly to time keeping screen
    year.setEnabled(false); //disable the text fields
    month.setEnabled(false);
    day.setEnabled(false);
    button.setText("RESET");
    String save [] = loadStrings(Environment.getExternalStorageDirectory().getAbsolutePath() + "/save.txt"); //load the birthday from the save file
    birthday.setTime(Long.parseLong(save[0]));
  }


  deathDate = birthday.getTime() + 2524554077976L; //birthday plus 80 years in milliseconds
}


// main program loop
void draw()
{
  switch(screen)
  {
  case 0:
    drawStartScreen(); //draw the initial start screen
    break;
  case 1:
    drawMainScreen(); // draw the main time keeping screen
    break;
  }
}


// used to show the virtual keyboard
void showVirtualKeyboard() {
  InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
  imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);
}


// used to hide the virtual keyboard
void hideVirtualKeyboard() {
  InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
  imm.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0);
}


// used to draw the main time keeping screen
void drawMainScreen()
{
  background(backgroundColor);
  long currentTime = System.currentTimeMillis(); //get current time in milliseconds
  long secondsRemaining = ((deathDate-currentTime)/1000); //take difference, convert to seconds
  String displayText = "~ " + ("" + secondsRemaining) + "\n" + "seconds left"; //convert to string
  fill(textColor1); //magenta yo
  textSize(displayWidth/3.75);
  text("#YOLO", displayWidth/2, displayWidth/2);
  textSize(displayWidth/7);
  text(displayText, displayWidth/2, displayHeight/2); //draw text
  button.update(); //draw the button
}


// used to draw the initial start screen
void drawStartScreen()
{
  background(backgroundColor); //draw background
  fill(textColor1);
  textSize(displayWidth/3.75);
  text("#YOLO", displayWidth/2, displayWidth/2); //draw logo
  textSize(displayWidth/9);
  text("Enter your birthday:", displayWidth/2, displayHeight*0.4); //draw informative text
  text("YYYY", int(displayWidth*0.25), int(displayHeight*0.70));
  text("MM", int(displayWidth*0.6), int(displayHeight*0.70));
  text("DD", int(displayWidth*0.85), int(displayHeight*0.70));
  year.update();
  month.update();
  day.update();
  button.update();
}


// used for handling touch screen events
@Override
public boolean dispatchTouchEvent(MotionEvent event) {
  int action = event.getActionMasked(); // get code for action
  if (action == MotionEvent.ACTION_DOWN || action == MotionEvent.ACTION_UP)
  {
    year.checkIfPressed(int(event.getX()), int(event.getY()), action); //check if a textfield or button was pressed
    month.checkIfPressed(int(event.getX()), int(event.getY()), action);
    day.checkIfPressed(int(event.getX()), int(event.getY()), action); 
    button.checkIfPressed(int(event.getX()), int(event.getY()), action);
  }
  return super.dispatchTouchEvent(event); // pass data along when done!
}


// update textfield text on key release
public void keyReleased()
{
  year.updateText();
  month.updateText();
  day.updateText();
}









