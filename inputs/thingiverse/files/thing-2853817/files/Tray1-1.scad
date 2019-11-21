$fn=60;
//Version Text
Version = "Acetone Vape Tray v1.1";
FontFace = "Bauhaus 93:style=Regular"; //["Agency FB:style=Bold", "Arial:style=Black", "Arial:style=Bold", "Arial Rounded MT Bold:style=Regular", "Bauhaus 93:style=Regular", "Belgium:style=Regular", "Bermuda Script:style=Regular", "Bradley Hand ITC:style=Regular", "Brush Script MT:style=Italic", "Harlow Solid Italic:style=Italic", "HP Simplified:style=Bold", "Stencil:style=Regular", "Orbitron:style=Black"]
//Tray width(x)
TrayX = 200;
//depth(y)
TrayY = 160;
//tray height(z)
TrayZ= 6;
//rod diameter
Rod_D = 6.40;  //6.35 = 1/4" rod

//Rounding value in mm
Offset1 = 4.0;

//Slat Width (currently rod diameter)
SlatWidth = 4;


difference(){
  union(){
    //frame
    linear_extrude(TrayZ){
      difference(){
        offset(Offset1) offset(-Offset1) square([TrayX, TrayY],center=true);
        offset(Offset1) offset(-Offset1) square([TrayX -Rod_D*4, TrayY -Rod_D*4],center=true);
      }
    }
    //cross member
    linear_extrude(TrayZ/2, scale=[1.0, 0.1]){
      square([TrayX, Rod_D], center=true);
    }
  }
  //holes Can this be optimized?
  color("red")
  linear_extrude(TrayZ){
//<text>
    translate([0, -TrayY/2 +Rod_D, 0]) rotate([0,0,0]) text(Version, font=FontFace, size=8, valign="center", halign="center");
    translate([0, +TrayY/2 -Rod_D, 0]) rotate([0,0,0]) text(Version, font=FontFace, size=8, valign="center", halign="center");
//</text>
    for(x = [-1, 1]) for(y = [-1, 0, 1]){
      translate([x*(TrayX/2 -Rod_D -Offset1/2), y*(TrayY/2 -Rod_D -Offset1/2), 0]) circle(d=Rod_D);
    }
  }
}

//slats
for (x = [-Rod_D*13 : Rod_D*1.5 : +Rod_D*13]){
  translate([x,0,0]){
    linear_extrude(TrayZ, scale=[0.1, 1.0]){
      square([SlatWidth, TrayY], center=true);
    }
  }
}