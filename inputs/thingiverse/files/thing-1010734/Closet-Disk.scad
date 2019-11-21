include <write/Write.scad>

//CUSTOMIZER VARIABLES

//(Max 8 Characters @ Font Size 10)
message = "Shirts";

Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy,"write/knewave.dxf":Fun]

font_size = 10;//[5:15]

font_spacing = 0; //[-100:100]

Radius = 27; //[21:33]

//CUSTOMIZER VARIABLES END

spacing_factor = font_spacing/100;

//Making the Disk
difference(){
    union(){
        cylinder(h=3, d=75); //Lower Disk
        translate([0,0,2])
        cylinder(h=1, d=75); //Upper disk
    }
    translate([0,0,-1])
    cylinder(h=4, d=37); // Inner cut out
    translate([0,0,2])
    cylinder(h=3, d=72); // Upper cut out ot make raised wall
    rotate([0,90,0])
    cylinder(h=50, r1=5, r2=17, center=false); // Opening
}

// Upper Text
writecircle(message,[0,0,2.5],Radius,h=font_size,space=1.05+spacing_factor, font=Font);

// Upper Text
writecircle(message,[0,0,2.5],Radius,h=font_size,space=1.05+spacing_factor, font=Font, rotate=180);
