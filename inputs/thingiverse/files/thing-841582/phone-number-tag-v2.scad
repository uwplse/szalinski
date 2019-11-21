// Key or luggage tag with phone number
// preview[view:south west, tilt:top diagonal]

// and country code if desired
area_code = "800" ; 

prefix = "555" ;

number = "1234" ;

font = "Liberation Sans" ; // [Liberation Sans, Roboto, Lato, Slabo 27px, Oswald, Lora, Droid Sans]

// length (in mm)
length = 50 ; // [30:100]

// rotation of right end
end_type = "Symmetrical" ; // [Symmetrical, Rotated, Both]

// these are all hidden options
s = 13*1 ; // length of sides (y and z)
l = length*1 ;
h = s*sqrt(2)/2 ; // end cube size (hypotenuse = side)
h2 = h*0.65 ; // size of end cutout
cs = 1.7*1  ;// stretch ends
e = 1.5*1 ; // text extrusion height
ts = s*0.75 ; // text size
f = 0.001*1 ; // fudge factor to ensure manifold

difference () {
 union () {
  // main shape
  cube([l,s,s]) ; 
  // left end cube
  scale([cs,1,1])
   rotate([0,0,45]) 
   cube([h,h,s]) ;
  // right end cube
  if (end_type == "Symmetrical" || end_type == "Both") {
    translate([l,0,0])
     scale([cs,1,1])
     rotate([0,0,45]) 
     cube([h,h,s]) ;
  }
  // right end cube rotated
  if (end_type == "Rotated" || end_type == "Both") {
    rotate([90,0,0])
    translate([l,0,-s])
     scale([cs,1,1])
     rotate([0,0,45]) 
     cube([h,h,s]) ;
  }
  // prefix text
  translate([l/2+h2/2,s/2,s-f]) {
   linear_extrude(height = e) {
    text(str("",prefix), font=font, size=ts, 
     valign="center", halign="center");
   }
  }
  // area_code text
  rotate([-90,0,0]) {
   translate([l/2+h2/2,s/-2-f,s]) {
    linear_extrude(height = e) {
     text(str("",area_code), font=font, size=ts, 
      valign="center", halign="center");
    }
   }
  }
  // number text
  rotate([90,0,0]) {
   translate([l/2+h2/2,s/2+f,0]) {
    linear_extrude(height = e) {
     text(str("",number), font=font, size=ts, 
      valign="center", halign="center");
    }
   }
  }
 }
 // difference with end cutout
 translate([0,s/2,s/2]) 
  scale([cs,1,1])
  rotate([0,0,45]) 
  cube([h2,h2,s*1.1], center=true) ;
}
