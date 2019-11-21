/*
 * Personal Key Chain
 *   v1.1
 *   December 2015
 *   by Jonathan Meyer (jon@stej.com)
 */
 
// preview[view:south, tilt:top]
 
// The name to display on the key chain.
name = "2017";

/* [Font] */

// The font to write the name in.
font = 1; // [0:Google (give name below), 1:Helvetica, 2:Times, 3:Arial, 4:Courier]

// the name of the font to get from https://www.google.com/fonts/
google_font = "Arial Unicode MS";

// The Font Style. Not all styles work with all fonts.
style = 4; // [0:None, 1:Regular, 2:Bold, 3:Italic, 4:Bold Italic]

/* [Size] */

// How tall the key chain will be.
width = 20; // [15:30]

// How long the key chain will be. 
length = 65;  // [40:100]

// How thick the key chain will be.
thickness = 5; // [3:10]

// How round the corners will be
roundness = 2;   // [1:5]

/* [Hidden] */

font_list = [undef,
             "Helvetica",
             "Times",
             "Arial Unicode MS",
             "Courier",
             "Symbola",
             "Apple Color Emoji",
             "serif",
             "Code2001"];
             
style_list = [undef, 
              "Regular", 
              "Bold", 
              "Italic", 
              "Bold Italic"];

w = width;
l = length;
d = thickness;
r = roundness;
t = str(name);

fn = (font == 0) ? google_font : font_list[font];
sn = (style_list[style] != undef) ? str(":style=",style_list[style]) : "";
f = str(fn,sn);

echo(str("Font Used -> ", f));

union(){
  difference(){
    hull(convexity=10){      
      translate([-((w/2)+(l/2)-2.5),0,0])
      minkowski(convexity=10){
        cylinder(h=d-r,d=w, center=true, $fn=100);
        sphere(d=r, $fn=100);
      }
      
      minkowski(convexity=10){
        cube([l,w,d-r],true);
        sphere(d=r, $fn=100);
      }
    }
  
    translate([-((w/2)+(l/2)-2.5),0,0])
    difference(){
      cylinder(h=d*2, d=w, center=true, $fn=100, convexity=10);
      
      rotate_extrude(convexity=10, $fn=100)
      translate([(w-d+r)/2,0,0])
      minkowski(convexity=10){
        square([d-r,d-r],true);
        circle(d=r,$fn=100);
      }
    }
    
    translate([0,0,0])
    linear_extrude(height=d/2, convexity=10)
    text(t, valign="center", halign="center", font=f, $fn=100, script="dingbats");
  }

  // color the inside of the text
  color([0,1,0,1])
  translate([0,0,(-d/2)+.3])
  linear_extrude(height=d/2)
  text(t, valign="center", halign="center", font=f);
}
