width=12.8*1;
length=5.7*1;
add=2.2*1;

depth=8*1;

hole=4*1;

t=2*1;

//CUSTOMIZER VARIABLES

// Include a USB holder?
usb="yes"; // [yes:Yes, no:No]

// How many LiPo
count=5; //[1:30]

//CUSTOMIZER VARIABLES END

usbwidth=4.6*1;
usblength=12.2*1;

if (usb == "yes") {
  difference() {
    cube([width+t*2, length+add*2+t*2, depth+t+1]);
    translate([t, t, t+1])
      cube([usblength, usbwidth, depth+2]);
  }
}

for (i=[1:count]) {
  translate([0, (length+add*2+t*2)*i, 0])
    difference() {
    cube([width+t*2, length+add*2+t*2, depth+t+1]);

    translate([t+add, t, t])
      cube([width-add*2, length+add*2, depth+2]);

    translate([t, t+add, t])
      cube([width, length, depth+2]);

    translate([width/2, length/2+hole/2,0])
      cube([hole, hole, depth+t+2]);
  }
}
