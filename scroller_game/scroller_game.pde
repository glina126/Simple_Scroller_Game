int x_pos,y_pos;
float gravity;
int vertical_velocity;
int ground;
float delta_time;
boolean in_jump;

void setup()
{
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
    
  size(800,600);
  frameRate(60);
  
  x_pos = width/2;
  y_pos = 500;
  
  
  rect(x_pos,y_pos,50,50);
}

void draw()
{
  calculatePhysics();
  background(180);
  rect(x_pos,y_pos,50,50);
  
}

void calculatePhysics()
{
   delta_time = delta_time + 0.01f;
   // Vf^2 = Vi^2 + a * d - we need to calculate the velocity given a = -9.8 - Vf = Vi + a*t
    vertical_velocity = int(vertical_velocity + (gravity * (delta_time)));
    y_pos = y_pos + vertical_velocity;
    
    if(y_pos > ground)
    {
        y_pos = ground;
        vertical_velocity = 0;
        in_jump = false;
        delta_time = 0.0f;
    }
    
  // print out vertical velocity and time delta
  #if 0
    print("velocity = ");
    print(vertical_velocity);
    print("\t time = ");
    println(delta_time);
  #endif
}

void mousePressed()
{
  // add to the vertical velocity
  if(!in_jump)
  {
    vertical_velocity = -20;
    delta_time = 0.0f;
    in_jump = true;
  }
}

