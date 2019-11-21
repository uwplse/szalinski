// 
// Customizable Heart
// version 1.0   2/13/2016
// by DaoZenCiaoYen @ Thingiverse
//

// preview[view:south, tilt:top]

/* [Main] */
text_line_1 = "LOVE" ;
text_line_2 = "YOU" ;
text_line_3 = "" ;
show_lines = 2 ; // [1:3]
heart_size = 1 ; // [0.5:0.1:2]
adjust_y = 0 ; // [-5:0.5:5]


color("Red",1) render(3) main() ;

module main() 
{
  difference()
  {
    scale([heart_size,heart_size,1]) heart();
    translate([0,adjust_y,0]) words();
  }
}

module heart()
{
  linear_extrude(5)
  translate([0,20,0])
  rotate([0,0,180+45])
  {
    translate([0,10,0]) circle(10);
    translate([10,0,0]) circle(10);
    square(20);
  }
}

module words()
{
  if (show_lines==1)
  {
    word(text_line_1,0,11*heart_size);
  }
  else
  {
    if (show_lines==2)
    {
      word(text_line_1,0,13*heart_size);
      word(text_line_2,0,6*heart_size);
    }
    else
    {
      word(text_line_1,0,16*heart_size);
      word(text_line_2,0,11*heart_size);
      word(text_line_3,0,6*heart_size);
    }
  }
}

module word(t,x,y)
{
  translate([x,y,3]) linear_extrude(3) 
    text(t,6,font = "Liberation Sans:style=Bold",
      halign="center",valign="center");
}

