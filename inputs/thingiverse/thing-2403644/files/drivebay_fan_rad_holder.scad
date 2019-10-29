//How much the fan is shifted from the center of 3 bays
fan_shift=13; //[-20:0.5:140]

// Cuts part of the upper drawers, so the part fits better on small printer beds
upper_cuttoff=10; //[0:0.5:20]

// For HDD screws (#6-32 UNC)
hor_hole = 2.9; 

// For M3 fan screws to have some wiggle room
fan_hole_d = 4.5; 

// Height of the upper drawer hole relative to the center of 3 bays
horizontal_hole_start = 44;

// The holes on CM Storm Stryker are 12mm apart with 43mm between pairs
horizontal_hole_offsets = [0, 12, 86, 86+12];

// 5mm seems to be the standard, to use with 35mm screws
shroud_thickness = 5;

//105 for the 120mm fans
fan_hole_spacing = 105;

//Diameter of the main fan hole
fan_diam = 116;


main();


module main() {
    shroud();
    translate([0,0,shroud_thickness])
    mirror([0,0,1])
    difference(){
        union() {
            bracing();
            drawers(16);
            mirror([1,0,0]) { bracing();}
        }
        
        for (hole_offset = horizontal_hole_offsets) 
            //uhh, value=list, really, OpenSCAD?
            translate([0,fan_shift-hole_offset+horizontal_hole_start,-10+shroud_thickness])
            rotate([0,90,0]) 
                cylinder($fn=12, d=hor_hole, h= 160,center=true);
        
        if (upper_cuttoff > 0)
        translate([0,-upper_cuttoff+fan_shift+75,-7.55+shroud_thickness])
            cube([150,25,30],center=true);
    
    }
};

module shroud () {
    fh = fan_hole_spacing;
    difference(){
        hull() four_cylinders(xs=fh,ys=fh, d=15, h=shroud_thickness, z=0);
        
        four_cylinders(xs=fh,ys=fh, 
            d=fan_hole_d,h=shroud_thickness+1, z=-0.1);
        
        cylinder($fn=50, d=fan_diam, h=1+2*shroud_thickness,center=true);
    }
}


module four_cylinders(xs,ys, d, h, z) {
    for(x=[0:1]) {
        for (y=[0:1]){
            translate([(0.5-x)*xs,(0.5-y)*ys,z]) 
                cylinder(h=h,d=d, $fn=16);
        }
    }
};

module bracing() {
    fh = fan_hole_spacing;
    for(i=[-1:2:1])
    hull(){
        translate([-68,fan_shift,shroud_thickness-4])
            cube([2, 105, 8],center=true);
        translate([-8.9-fh/2,0,shroud_thickness/2])
            cube([3,fh*0.8,shroud_thickness], center=true);
    }
};


module drawers(depth=20,width=5) {
    // Values taken from SFF-8551 are in comments
    a1= 41.5;   //41.53, ehh, tolerance is +-0.25mm anyway
    a2= 44;     //42.3 plus two ~0.9mm steel divider tabs
    a5= 146.05;  //146.05, fits snugly
    
    for (j = [-1,1])
        translate([0,j*(a1+a2)/2 + fan_shift,-depth/2+shroud_thickness])
            difference() {
                cube([a5,a1,depth], center=true);
                cube([a5-width*2,a1+1,depth+1], center=true); }
    
};