int x_pos,y_pos;
boolean DEBUG;
Gravity gravity;
Scroll world_scroll;

void setup()
{
  // set debug mode
  DEBUG = true;
  
  // set the window size
  size(800,600);
  
  // set the frame rate
  frameRate(60);
  
  // initiate x and y cordinate of the main character
  x_pos = width/2;
  y_pos = 500;
  
  // draw the main character
  rect(x_pos,y_pos,50,50);
  
  // initialize gravity
  gravity = new Gravity();
  
  // initialize the world scroll
  world_scroll = new Scroll();
  
  world_scroll.startScroll();
}

void draw()
{
  gravity.calculatePhysics();
  world_scroll.update();
  
  print("x = ");
  println(world_scroll.getX());
  
  background(180);
  rect(world_scroll.getX(),gravity.getY(),50,50);
}

class Scroll
{
  int x;
  boolean scroll;
  int scroll_rate;
  int time_delay;
  int time_now;

  Scroll()
  {
    // initiate the world scroll
    x = 0;
    
    // make sure we dont scroll when we start
    scroll = false;
    
    // set the initial rate
    scroll_rate = 4;
    
    // time delay
    time_delay = 1; // i.e. 2/60 frames
    
    // time now 
    time_now = 0;
   
  }
  void startScroll()
  {
    scroll = true; 
  }
  void update()
  {    
    if(time_now >= time_delay)
    {
      // reset the timer
      time_now = 0;
      
      // check if we should scroll (should be done before the time_now >= time_delay)
      if(scroll)
      {
        // add to the x
        x = x + scroll_rate; 
      }
    }
    time_now++;
  }
  int getX()
  {
    return x;
  }
}

class Gravity
{
  int y_pos;
  float gravity;
  int vertical_velocity;
  int ground;
  float delta_time;
  boolean in_jump;
  
  Gravity()
  {
    // set the initial object position
    y_pos = 500;
    
    // set the ground to be 500
    ground = 500;
    
    // set the gravity for the system
    gravity = 9.8f;
    
    // initial vertical velocity is zero
    vertical_velocity = 0;
    
    // initiate delta time
    delta_time = 0.0f;
    
    // initialize in jump to false
    in_jump = false;
  }
  void calculatePhysics()
  {
    delta_time = delta_time + 0.01f;
   // Vf^2 = Vi^2 + a * d - we need to calculate the velocity given a = -9.8 - Vf = Vi + a*t
    vertical_velocity = int(vertical_velocity + (gravity * (delta_time)));
    this.y_pos = this.y_pos + vertical_velocity;
    
    if(this.y_pos > ground)
    {
        this.y_pos = ground;
        vertical_velocity = 0;
        in_jump = false;
        delta_time = 0.0f;
    }
    
    // print out vertical velocity and time delta
    if(DEBUG)
    {
      print("velocity = ");
      print(vertical_velocity);
      print("\t time = ");
      println(delta_time);
    }
  
  }
  
  void initiateJump()
  {
    // add to the vertical velocity
    if(!in_jump)
    {
      vertical_velocity = -20;
      delta_time = 0.0f;
      in_jump = true;
    }
  }
  
  int getY()
  {
    return this.y_pos; 
  }
  
}

void mousePressed()
{
  gravity.initiateJump();
}

