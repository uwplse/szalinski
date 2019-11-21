// What size you want to gauge to be for
t_size=1.625;


// Conversion Factor for Inches(25.4) or MM (1)
conversion = 25.4; // [25.4,1]


jaws= t_size * conversion;

height=(.125) * conversion;

top=jaws * .25;
side=jaws * .25; // .40

arm=side;



union() {
// If you want to see the cylinder
//cylinder(h=height,d=jaws,center=true);


// Handle
translate([((jaws/2)+side+top/2),0,0]) cube(size=[top, jaws+arm+side, height], center=true);


// Top bar
translate([(jaws/2)+(side/2),0,0]) cube(size=[side, jaws, height], center=true);

// Side Bar (Right)
translate([side-(arm/2),(((jaws/2))+(side/2))*1,0]) cube(size=[jaws+arm, side, height], center=true);
// Side Bar (Left)
translate([side-(arm/2),(((jaws/2))+(side/2))*-1,0]) cube(size=[jaws+arm, side, height], center=true);


};



