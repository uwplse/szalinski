// Hello name tag
// lucina
// 2017-08-29
// preview[view:south, tilt:top]
/* [settings] */
// the name (can be blank, write with pen)
name = "AWESOME";
// the line after Hello
myNameIs = "I am";   //[my name is, I am]
// select which part
selection = "white";  //[white, black]
// scale factor to fit name onto the tag
scaleText = 1.8; //[.2:.1:4]
// space to allow around text (mm) .15 works well with .3mm layer height
allow = .15;  //[0:.05:.4]

/* [hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
inch = 25.4;
textZ = 1.8;
back = .6;
tag = [(3+3/8)*inch,  (2+11/32)* inch, back];
hello = "Hello";
helloYOff = .9;
myNameYOff = .75;
sizeHello = 7.5;
sizeMyName = 5.7;
textSize = 6;
back = .6;
rad = 5;
postD = ((1/8)*tag[y])/3;
holeD =  postD + allow;
postOff = postD + .5*postD;

sans = "Open Sans:style=Bold";
bold = "Open Sans:style=ExtraBold";
marker = "Permanent Marker:style=Regular";

module rcube(cc, rr) {
   translate([cc[x]/2, cc[y]/2, 0])
   hull() {
      translate([-cc[x]/2+rr, cc[y]/2-rr, 0])
         cylinder(h=cc[z], r=rr);
      translate([-cc[x]/2+rr, -cc[y]/2+rr, 0])
         cylinder(h=cc[z], r=rr);
      translate([cc[x]/2-rr, cc[y]/2-rr, 0])
         cylinder(h=cc[z], r=rr);
      translate([cc[x]/2-rr, -cc[y]/2+rr, 0])
         cylinder(h=cc[z], r=rr);
   }
}
module renderText(txt, ht, font, fontSize) {
     linear_extrude(ht, center=true)
       text(txt, font = font, size = fontSize, halign="center", valign="center");
}
module black() {
   intersection() {
      translate([tag[x]/2, 1/8*tag[y]+tag[y]*(13/24)/2, textZ/2])
         renderText(name, textZ, marker, scaleText*textSize);
      translate([.05*tag[x]/2, 1/8*tag[y], 0])
         cube([tag[x]*.95, tag[y]*(13/24), textZ]);
   }
}
module white() {
   // back
   rcube(tag, rad);

   // hello, my name is
   translate([tag[x]/2, helloYOff*tag[y], textZ/2+back])
      renderText(hello, textZ, bold, sizeHello);
   translate([tag[x]/2, myNameYOff*tag[y], textZ/2+back])
      renderText(myNameIs, textZ, sans, sizeMyName);

   // cutout name
   difference() {
      translate([0, 1/8*tag[y], tag[z]])
         cube([tag[x], tag[y]*(13/24), textZ]);
      if ( allow == 0 ) {
         intersection() {
            translate([tag[x]/2, 1/8*tag[y]+tag[y]*(13/24)/2, textZ/2+back])
               renderText(name, textZ, marker, scaleText*textSize);
            translate([.05*tag[x]/2, 1/8*tag[y], back])
               cube([tag[x]*.95, tag[y]*(13/24), textZ]);
         }
      }
      else {
         intersection() {
            union() {
               for ( yy = [-allow:allow:allow] ) {
                  for ( xx = [-allow:allow:allow] ) {
                     translate([tag[x]/2+xx, 1/8*tag[y]+tag[y]*(13/24)/2+yy, textZ/2+back])
                        renderText(name, textZ, marker, scaleText*textSize);
                  }
               }
            }
            translate([.05*tag[x]/2, 1/8*tag[y], back])
               cube([tag[x]*.95, tag[y]*(13/24), textZ]);
         }
      }
   }
   // posts
   translate([postOff, postOff, back])
      cylinder(h=textZ/2, d=postD);
   translate([tag[x]/2, postOff, back])
      cylinder(h=textZ/2, d=postD);
   translate([tag[x]-postOff, postOff, back])
      cylinder(h=textZ/2, d=postD);
   translate([postOff, tag[y]-postOff, back])
      cylinder(h=textZ/2, d=postD);
   translate([tag[x]-postOff, tag[y]-postOff, back])
      cylinder(h=textZ/2, d=postD);

}
module red() {
   // top
   translate([tag[x], 0, textZ])
   rotate([0, 180, 0])
   difference() {
      difference() {
         rcube([tag[x], tag[y], textZ], rad);
         cube([tag[x], 2/3*tag[y], textZ]);
      }
      union() {
         // cutout Hello my name is
         if ( allow == 0 ) {
            union() {
               translate([tag[x]/2, helloYOff*tag[y], textZ/2])
                  renderText(hello, textZ, bold, sizeHello);
               translate([tag[x]/2, myNameYOff*tag[y], textZ/2])
                  renderText(myNameIs, textZ, sans, sizeMyName);
            }
         }
         else {
            union() {
               for ( yy = [-allow:allow:allow] ) {
                  for ( xx = [-allow:allow:allow] ) {
                     translate([tag[x]/2+xx, helloYOff*tag[y]+yy, textZ/2])
                        renderText(hello, textZ, bold, sizeHello);
                     translate([tag[x]/2+xx, myNameYOff*tag[y]+yy, textZ/2])
                        renderText(myNameIs, textZ, sans, sizeMyName);
                  }
               }
            }
         }
         //post holes
         translate([postOff, tag[y]-postOff, -textZ/2])
            cylinder(h=textZ, d=holeD);
         translate([tag[x]-postOff, tag[y]-postOff, -textZ/2])
            cylinder(h=textZ, d=holeD);
      }

   }

   // bottom
   difference() {
      difference() {
         rcube([tag[x], tag[y], textZ], rad);
         translate([0, 1/8*tag[y], 0])
            cube([tag[x], 7/8*tag[y], textZ]);
      }
      union() {
         translate([postOff, postOff, textZ/2])
            cylinder(h=textZ, d=holeD);
         translate([tag[x]/2, postOff, textZ/2])
            cylinder(h=textZ, d=holeD);
         translate([tag[x]-postOff, postOff, textZ/2])
            cylinder(h=textZ, d=holeD);
      }
   }
}

if ( selection == "red" ) {
   red();
}
if (selection == "black") {
   black();
}
if (selection == "white" ) {
   white();
}
