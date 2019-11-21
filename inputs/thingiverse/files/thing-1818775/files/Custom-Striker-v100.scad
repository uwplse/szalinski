
$fn=80;


// typical values for a slightly oversized handle for a kids 4' by 2' air hockey table
//height = 55;
//handleradius = 18;
//strikerradius = 32.5;
//strikerwallthickness = 3; // also acts as base thickness
//strikerwallheight = 15;



height = 55;
handleradius = 18;
strikerradius = 32.5;
strikerwallthickness = 3; // also acts as base thickness
strikerwallheight = 15;

// handle
translate([0,0,height - handleradius ]) sphere(r=handleradius );
cylinder(height - handleradius ,handleradius ,handleradius );
cylinder(strikerwallthickness, strikerradius ,strikerradius );


// striker wall
difference(){   
    cylinder(strikerwallheight , strikerradius ,strikerradius );
    cylinder(strikerwallheight  + 1, strikerradius-strikerwallthickness ,strikerradius-strikerwallthickness );
}


// striker relief
rotate_extrude(convexity = 10)
translate([strikerradius- (strikerwallheight +strikerwallthickness),0,0])
difference(){
    square(size=[strikerwallheight ,strikerwallheight ]);
    translate([0,strikerwallheight ,0]) circle(r=strikerwallheight );
};

// handle relief
rotate_extrude(convexity = 10)
translate([(-handleradius) - (strikerradius/4),0,0])
difference(){
    square(size=[strikerradius/4 ,strikerradius/4]);
    translate([0,strikerradius/4 ,0]) circle(r=strikerradius/4 );
};