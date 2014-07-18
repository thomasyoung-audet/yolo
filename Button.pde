public class Button
{
  private int x, y, w, h;
  private boolean isPressed = false;
  private String text;

  //constructor
  Button(int x, int y, int w, int h, String text)
  {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.text = text;
  }


  // used to draw the button
  public void update()
  {
    if (isPressed)
    {
      fill(fieldColor);
      rect(x, y, w, h);
    }
    else {
      fill(backgroundColor);
      rect(x, y, w, h);
    }
    fill(textColor1);
    textSize(h*0.8);
    text(text, x, y+(h/4));
  }

  
  // used to determine if the button was pressed by a touchscreen event
  public void checkIfPressed(int xTouch, int yTouch, int action)
  {
    if (action == MotionEvent.ACTION_DOWN)
    {
      if (xTouch >= x-(w/2) && xTouch < x+(w/2) && yTouch >= y-(h/2) && yTouch < y+(h/2))
      {
        isPressed = true;
      }
      else {
        isPressed = false;
      }
    }
    else if (action == MotionEvent.ACTION_UP) {
      if (xTouch >= x-(w/2) && xTouch < x+(w/2) && yTouch >= y-(h/2) && yTouch < y+(h/2))
      {
        changeScreen();
      }
      isPressed = false;     
    }
  }
  
  
  // used to set the text label of the button
  public void setText(String text)
  {
    this.text = text;
  }


  // used to change the screen when the button is pressed
  public void changeScreen()
  {
    if (screen == 0) //currently on the initial setup screen
    {
      try {
        birthday = new Date(int(year.getText())-1900, int(month.getText()), int(day.getText())); //set the birthday based on the values in the textfields
        deathDate = birthday.getTime() + 2524554077976L; //birthday plus 80 years in milliseconds
        screen = 1; //change the screen
        text = "RESET";
        year.setEnabled(false); //disable the text fields
        month.setEnabled(false);
        day.setEnabled(false);
        String out [] = new String [1];
        out[0] = ("" + birthday.getTime());
        saveStrings(Environment.getExternalStorageDirectory().getAbsolutePath() + "/save.txt",out); //save the birthday to the save file
      }
      catch(Exception e) { //if an exception is encountered, stay on the same screen
        screen = 0;
      }
    }
    else { //on the main time keeping screen
      screen = 0; //change the screen
      text = "ENTER";
      year.setEnabled(true); //enable text fields
      month.setEnabled(true);
      day.setEnabled(true);
    }
  }
}

