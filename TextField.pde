public class TextField
{
  private int x, y, w, h;
  private String text="";
  private boolean selected = false;
  private int limit;
  private boolean enabled = true;


  // constructor
  TextField(int x, int y, int w, int h, int limit)
  {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.limit = limit;
  }


  // draws the textfield to the screen
  public void update()
  {
    fill(fieldColor);
    rect(x, y, w, h);
    fill(textColor1);
    textSize(h*0.8);
    text(text, x, y+(h/4));
  }


  // updates the text based on the last key pressed
  public void updateText()
  {
    if (selected)
    {
      if (key == CODED)
      {   
        if (keyCode == char(67)) //backspace
        {
          if (text.length() > 0) //if there is more than one character in the string
          {
            text = text.substring(0, text.length()-1); //remove last character
          }
        }
      }
      else if (key == '\n') { //enter key (done editing textfield)
        selected = false; 
        hideVirtualKeyboard(); //hide keyboard
      }
      else if (text.length() < limit) { //keep text within limit
        text += key; //add key to text
      }
    }
  }


  // set the text in the textfield
  public void setText(String text) 
  {
    this.text = text;
  }


  // get the text in the textfield
  public String getText()
  {
    return text;
  }


  // enable or disable the textfield
  public void setEnabled(boolean enabled)
  {
    this.enabled = enabled;
  }


  // checks to determine if the field has been pressed
  public void checkIfPressed(int xTouch, int yTouch, int action)
  {
    if (enabled)
    {
      if (xTouch >= x-(w/2) && xTouch < x+(w/2) && yTouch >= y-(h/2) && yTouch < y+(h/2)) //check if the touch event occured in the boundaries of the textfield
      {
        if (action == MotionEvent.ACTION_UP) // up motion
        {
          selected = true; //select this textbox
          showVirtualKeyboard(); //bring up keyboard
        }
      }
      else if (selected) { // un-select textfield and hide the keyboard if a touch event occured elsewhere
        selected = false;
        hideVirtualKeyboard();
      }
    }
  }
}

