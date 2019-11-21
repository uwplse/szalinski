// preview[view:south, tilt:top]

// Choose an extruder to preview
part = -1; // [0:Extruder 0,1:Extruder 1,-1:Both]

name = "Your Name";
line_1 = "";
line_2 = "Title";
line_3 = "Organization";
line_4 = "your.email@company.com";
line_5 = "1 555 111 2222 : Office";
line_6 = "1 555 333 4444 : Cell";

// 0 to disable
border = .8; // [0:.2:2]

// Thingavers supported fonts: https://www.google.com/fonts

font_name = 1; // [0:Arial Rounded, 1:Fredoka One]]

font = font_name==0?"Arial Rounded MT Bold:style=Regular"
                   :"Fredoka One:style=Regular";

logo = 0; // [0:Disable,1:Enable]

/* [Back] */

company = "Company Name";
back_line_1 = "Address";
back_line_2 = "";
back_line_3 = "";
back_line_4 = "";
back_line_5 = "";
back_line_6 = "";

back_justify = 1; // [0:left,1:center]

/* [Card] */

// size of business cards:
//    http://designerstoolbox.com/designresources/businesscards/

// Width
card_x = 89; // [74:1:91]

// Height
card_y = 51; // [50:1:55]

// Depth
card_z = 1; // [.4:.2:2]

// Corner radius
corner_radius = 2;

/* [Text Style] */

// Name & Company
font_size_1 = 6; // [4:1:10]

// Lines 1 to 6
font_size_2 = 4; // [4:1:10]

// Depth
text_z = .4;

// Line spacing
space  = 1.5;

// Margin for text
margin = 5;

/* [Hidden] */

color0="Blue";
color1="White";

logo_margin = 5;
logo_size = 25;

// Company logo - format: [path1_points],[path2_points],...
logo_points =
[
  [ [-200,5],[200,5],[5,100] ],
  [ [-200,-5],[200,-5],[-5,-100] ]
];

size_x = max_x(logo_points) - min_x(logo_points);
size_y = max_y(logo_points) - min_y(logo_points);
size_scale = logo_size/max([size_x,size_y]);

function min_x(pts) = min([ for (x = pts) min([for (y = x) y[0] ]) ]);
function max_x(pts) = max([ for (x = pts) max([for (y = x) y[0] ]) ]);
function min_y(pts) = min([ for (x = pts) min([for (y = x) y[1] ]) ]);
function max_y(pts) = max([ for (x = pts) max([for (y = x) y[1] ]) ]);

module company_logo(logo)
{
  translate([card_x-logo_margin-(size_x*size_scale/2),
             card_y-logo_margin-(size_y*size_scale/2),
             card_z])
  scale([size_scale, -size_scale, 1])
  union()  {
    for (path = logo) linear_extrude(height=text_z) polygon(path);
  }
}

// can't use with customizer
/*
function sum_text(t,i,s=0) = (i==s ? t[i][1] : t[i][1] + sum_text(t,i-1,s));

module print_line_old(line,font_size)
  linear_extrude(text_z)
  text(str(line),font_size,font,halign="left", $fn=50);

module print_text_old(side=0,lines) // side: 0=front, 1=back
  rotate(side==0?0:180,[0,1,0])
  translate(side==0 ? [margin,card_y-margin,card_z]
                    : [margin-card_x,card_y-margin,-text_z])
  for(n=[0:len(lines)-1])
  translate([0,-(sum_text(lines,n,0)+n*space),0])
  print_line(lines[n][0],lines[n][1]);

front_text = [
    ["Your Name",6],
    ["",4],
    ["Title",4],
    ["Organization",4],
    ["your.email@company.com",4],
    ["1 555 111 2222 : Office",4],
    ["1 555 333 4444 : Cell",4],
];

back_text = [
    ["",20],
    ["Company",5],
    ["1234 Street Address",5],
    ["City, ST USA  12345",5],
];
*/

module print_line(line,font_size,side,line_num)
  rotate(side==0?0:180,[0,1,0])
  translate([(side==1&&back_justify==1?card_x/2:margin)-(side==0?0:card_x),
             card_y-margin-(font_size_1+(line_num*(font_size_2+space))),
             side==0?card_z:-text_z])
  linear_extrude(text_z)
  text(str(line),font_size,font,halign=(side==1&&back_justify==1?"center":"left"), $fn=50);

module print_text(side) {
   if(side==0) {
     print_line(name,font_size_1,side,0);
     print_line(line_1,font_size_2,side,1);
     print_line(line_2,font_size_2,side,2);
     print_line(line_3,font_size_2,side,3);
     print_line(line_4,font_size_2,side,4);
     print_line(line_5,font_size_2,side,5);
     print_line(line_6,font_size_2,side,6);
   } else {
     print_line(company,font_size_1,side,0);
     print_line(back_line_1,font_size_2,side,1);
     print_line(back_line_2,font_size_2,side,2);
     print_line(back_line_3,font_size_2,side,3);
     print_line(back_line_4,font_size_2,side,4);
     print_line(back_line_5,font_size_2,side,5);
     print_line(back_line_6,font_size_2,side,6);
   }
}

module card(size,radius,border_width) {
    scale_x = 1 - 2*(border_width/card_x);
    scale_y = 1 - 2*(border_width/card_y);
    translate([border_width,border_width,0])
    scale([scale_x,scale_y])
    linear_extrude(height=size.z)
    hull()
    {
      translate([radius,        radius,        0]) circle(r=radius,$fn=100);
      translate([size.x-radius, radius,        0]) circle(r=radius,$fn=100);
      translate([radius,        size.y-radius, 0]) circle(r=radius,$fn=100);
      translate([size.x-radius, size.y-radius, 0]) circle(r=radius,$fn=100);
    }
}

module draw_border(radius)
{
  if(border>0)
  difference() {
    translate([0,0,.01]) card([card_x,card_y,card_z-.02],radius,0);
    translate([0,0,-card_z/2]) scale([1,1,2]) card([card_x,card_y,card_z],radius,border);
  }
}

module draw_card(size, radius, b)
  difference()
  {
    card(size,radius,b);
    // cut out recessed text
    translate([0,0,-text_z]) scale([1,1,2]) print_text(1);
  }

module extrude(e)
  if (part==e||part==-1)
    color(e==0?color0:color1) children();

// Make it so!
extrude(1) draw_card([card_x,card_y,card_z],corner_radius,border);
extrude(0) draw_border(corner_radius);
extrude(0) print_text(0);
extrude(0) print_text(1);
// not sure how to use with customizer, so default disabled
if (logo==1) extrude(0) company_logo(logo_points);

