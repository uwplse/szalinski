//BEGIN CUSTOMIZER VARIABLES
/*[Vase Settings]*/
height = 150;
radi = 50;
//I like the counter clockwise twists personally.
num_of_twists = -2;
//need to have this times num_of_colors >3
times_each_color_appears = 2;
thickness = 4;
/*[Color Settings]*/
//need to have this times times_each_color_appears >3, I realize 8 color support is overkill for now, but still fun to consider
num_of_colors = 4;//[2:8]
//pick what colors appear in the CUSTOMIZER
colors = [[0,0,1],[0,1,0],[1,0,0],[1,1,0],[0,1,1],[1,0,1],[0,0,0]];
/*[display]*/
//8 displays all, 0-8 displays lone parts
part = 8;//[0:0,1:1,2:2,3:3,8:8]
//END CUSTOMIZER VARIABLES

make_part();

module vase_segment() {
  angle = 360/(times_each_color_appears*num_of_colors);

  difference()
  {
    for(i=[1:times_each_color_appears])
    { 
      rotate([0,0,360/times_each_color_appears*i])
        linear_extrude(height=height, twist = num_of_twists*360, convexity = 10)
        {
          intersection(){
            circle(radi, $fn=25);
            polygon(radi*[[0,0],[0,1],2*[sin(angle/2),cos(angle/2)],
                    [sin(angle),cos(angle)]]);
          }
        }
    }
    translate([0,0,thickness])
      cylinder(r=radi-thickness/2, height);
  }
}
module make_part() {
  echo(part);
  if(part ==8)
  {
    for(i=[0:num_of_colors-1])
    {
      color(colors[i])
        rotate([0,0,360/(num_of_colors*times_each_color_appears)*i])
          vase_segment();
    }
  }
  else
  {
    color(colors[part])
        rotate([0,0,360/num_of_colors*part])
          vase_segment();
  }
}
