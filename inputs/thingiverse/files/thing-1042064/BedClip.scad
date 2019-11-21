//The height of the bed (mm)
bed_height=7.6; 

//Diameter of the circle (mm)
diameter= 25; // [10:50]

//The depth of the rift
rift=0.6; // [0.1:0.1:0.9]

//The thickness of the clamp (mm)
clampheight=2; // [1:0.1:5]

//The thickness of the claw (mm)
clawheight=0.5; // [0:0.1:1.5]

//The width of the claw (mm)
clawwidth= 2; // [1:0.1:5]


/* [Advanced] */

text="M2";
font = "Liberation Sans";
letter_size = 5; 
letter_height = 0.5; //mm





height= bed_height+clampheight*2;
radius = diameter/2;



module letter(l) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  linear_extrude(height = letter_height+height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}


 
difference()
{
    union()
    {
 color("gray") cylinder(height,radius,radius,false );
 color("red")    translate([0, -radius/2, 0]) rotate([0, 0, 180]) letter(text);
    }

translate([-radius,0,0])
cube([diameter,radius,height]);


union()
{
translate([-radius,-radius*rift,(height-bed_height)/2])
cube([diameter, radius*rift-clawwidth,bed_height]);

translate([-radius,-radius*rift,(height-bed_height+clawheight*2)/2])
cube([diameter, radius*rift,bed_height-clawheight*2]);
}

}



