// Screen Model
model = "basic"; //[basic:Basic, enhanced:Enhanced]

// SD Card cut-out
sdcard = "y"; //[y:Yes, n:No]

// XT Connectors
connector = "both"; //[none: None, left:Left Only, right:Right Only, both: Both Sides]

// Direction
direction = "stand"; //[print: Printable, stand: Standing]

module inner_plug(h=0.51) {
    linear_extrude(height=h,center=true)
    polygon(
    [
        [0,0],
        [8.4,0],
        [8.4,13.25],
        [8.4-(8.4-2.5)/2,13.25+2.5],
        [(8.4-2.5)/2,13.25+2.5],
        [0,13.25],
    ])
    ;
}

module outer_plug(h=0.5) {
linear_extrude(height=h,center=true)
    translate([4.2,0])
    polygon(
    [
        [-5.7,	-1.5],
        [-5.7,	13.945],
        [-1.945,	17.25],
        [1.945,	17.25],
        [5.7,	13.945],
        [5.7,	-1.5],
    ]
   );
}

module plug(h=0.5) {
    translate([65.9619407771256,-5.96194077712558,0])
    rotate([0,0,-45+180])
    translate([10,10])
    difference(){    
        outer_plug(h);
        inner_plug(h+0.1);
    }
}

module plug_cut(h=0.5) {
    translate([65.9619407771256,-5.96194077712558,0])
    rotate([0,0,-45+180])
    translate([10,10])
    inner_plug(h+0.1);
}

module sidepanel() {   
    //rotate([0,90,0])
    linear_extrude(height=2.5,center=true)
    polygon(
    [
        [0,0],
        [0,40],
        [20,40],
        [65.9619407771256,-5.96194077712558],
        [31.9218203308052,-40.002061223446],
        [0.00182033080519517,-40.002061223446],
        [0.00182033080518537,-0.00206122344599891],
    ]);
}

module sd_cut() {
    translate([5.8+0.75,-74.4/2+13.94+8,24])
    cube([2,14,5],center=true);
}
    
module bolt_cut() {
    
    $fn=20;
    translate([5.8-1.6-3/2,-74.4/2+2.1+1.8/2,36.72/2])
    rotate([0,90,0])
    cylinder(r=1.8,h=3,center=true);
    
    translate([5.8-1.6-3/2,-74.4/2+2.1,-36.72/2])
    rotate([0,90,0])
    cylinder(r=1.8,h=3,center=true);
}


module hasp() {
    difference() {
    union() {
        color("lightgray")
    translate([0,0,-23]) sidepanel();
        color("darkgray")
    translate([0,0,23-0*2.50]) sidepanel();

    //bottom slope
    translate([10,40-1.25,0]) cube([20,2.5,23*2+2.5],center=true);
    //top slope
    translate([31.92/2,-40+1.25,0]) cube([31.92,2.5,23*2+2.5],center=true);

    // front
    translate([4.2/2,0,0]) cube([4.2,80,23*2+2.5],center=true);
 
    // floor
    
    
    translate([20,40,-23-2.5/2]) rotate([0,0,45+180]) cube([2.5,65,23*2+2.5],center=false);
        
        
        
    //bottom lip large
    /*translate([7.2,40-2.5,24-17/2])
    rotate([0,0,45])
    cube([3,3,17+2.5],center=true);*/

    //bottom lip small
    translate([7.2,40-2.5,0])
    rotate([0,0,45])
    cube([3,3,22.5*2+2.5],center=true);
    }

    //pcb cutout
    translate([4.2+1,0,0]) cube([2,75,42.72+0.5],center=true);

    //translate([9.2,-35,0]) cube([10,10,20],center=true);

    //screen cutout
    translate([4.2/2,0,0]) color("black") cube([4.25,61.5,43.7],center=true);


    if (connector == "both" || connector == "left") 
    color("cyan") translate([0,0,23+1.25-16/2+0.005]) plug_cut(20);

    if (connector == "both" || connector == "right") 
    color("orange")translate([0,0,-23-1.25+8/2-0.005]) plug_cut(20);
    
    
    if (sdcard == "y") sd_cut();

    bolt_cut();
    }

    if (connector == "both" || connector == "left") 
    color("cyan") translate([0,0,23+1.25-16/2+0.005]) plug(16);

    if (connector == "both" || connector == "right") 
    color("orange")translate([0,0,-23-1.25+8/2-0.005]) plug(8);


/*
    // plug supports
    hull() {
    translate([35.2,-13.75,9.25],center=true)
    cube([1,4.5,1.5]);

    translate([35.2,-13.75,23],center=true)
    cube([1,4.5,1.5]);

    translate([35-10
    ,-13.5+10,23],center=true)
    cube([0.1,0.1,0.1]);
    };

    hull() {
    translate([35.2,-13.75,-18.75],center=true)
    cube([1,4.5,1.5]);

    translate([35.2,-13.75,-23],center=true)
    cube([1,4.5,1.5]);

    translate([35-8,-13.5+10,-23],center=true)
    cube([0.1,0.1,0.1]);
    };*/
}

if (direction == "print") {
    rotate([0,-90,0]) hasp();
} else {
    translate([0,0,40+2.5])
    rotate([0,90,0]) rotate([0,0,-45]) hasp();
}