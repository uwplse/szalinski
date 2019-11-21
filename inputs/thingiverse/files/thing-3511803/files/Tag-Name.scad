// Create your own tag for your or your children's backpacks

// Name to be printed
name ="Aurora";

// False in case you want it extruded
extrude_name = false;

// Height of the tag and letters
h=2.5;

// Width of the strap, it should be 5 more than the  
strap=23;

// Width of the tag, adjust to your like
width =strap+4+5;

// Modify to fit the letters on the tag
letters_adjust = 18;

length=len(name)*letters_adjust;

if (extrude_name) {
    difference(){
        translate([0,0,h/2]) cube([length,width,h], center=true);
        linear_extrude(height=2*h, convexity=4) translate([0,0,h/2]) text(name, size=width*3/4, halign="center", valign="center");
    }
} else {
    translate([0,0,h/2]) cube([length,width,h], center=true);
    translate([0,0,h]) linear_extrude(height=h) text(name, size=width*3/4, halign="center", valign="center");
}

difference() {
    translate([length/2+2*h,0,h/2]) cube ([2*2*h,width,h], center=true);
    linear_extrude(height=2*h, convexity=4) translate ([length/2+3*h/2,0,h/4]) square([h,strap], center=true);    
}
      
echo(version=version());
