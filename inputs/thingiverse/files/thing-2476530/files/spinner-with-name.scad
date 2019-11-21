text="my Name";
charactersize=6;
font1 = "Liberation Sans"; // here you can select other font type
//font1 = "Carlito"; // here you can select other font type

// left lower corner of the text from the middle
left=17;
lower=22;
textheight=2; // should be lower than 3.5
$fn=100;

difference(){
  union(){
    translate([0,0,0])cylinder(r=14,h=7);
    for(i=[60:120:300]){
      rotate([0,0,i]){
        translate([0,-35,0]){
          cylinder(r=13.5,h=7);
        }
      }
      rotate([0,0,i+60]){
        difference(){
          translate([-28,-26,0]){
            cube([50,14,7]);
          }
          translate([-28,-25,-0.5]){
            cube([50,12,textheight+0.5]);
          }
          translate([-28,-25,7-textheight]){
            cube([50,12,textheight+0.5]);
          }
      }
     
    }
  }
  for(i=[0:120:240]){
    rotate([0,0,i]){
      translate([-left,-lower,7-textheight]){
        printtext(text,charactersize,textheight);
      }
    }
    rotate([0,180,i]){
      translate([-left,-lower,-textheight]){
        printtext(text,charactersize,textheight);
      }
    }
  }
  }
  translate([0,0,-1])cylinder(r=11,h=9);

  for(i=[60:120:300]){
      rotate([0,0,i]){
        translate([0,-35,-0.5]){
          $fn=6;
          cylinder(r=10.9,h=8);
        }
      }
    }
}
module printtext(mytext,mysize,myheight){
   linear_extrude(height = myheight) {
    text(mytext, font = font1, size = mysize, direction = "ltr",  spacing = 1 );
  }
}