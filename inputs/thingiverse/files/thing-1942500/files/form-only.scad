// bodyinteraction toy form 

// radius of bottom part
r_bottom=60; // [50:5:80] 
// height of bottom part
h_bottom=30; // [10:5:80] 
// top rounding of bottom part
rounding=10; // [10:5:20]
// radius of ball 1 
r_ball1=45; // [15:5:50]  
// radius of ball 2
r_ball2=35;  // [15:5:50] 
//radius of ball 3 
r_ball3=20;  // [15:5:50] 
// radius of connecting cylinders
connector_radius=10; // [10:2:20]
// distance between balls and bottom part
ball_distance=30; // [10:2:40]
 

base(r_bottom,h_bottom,rounding,connector_radius,ball_distance,r_ball1,r_ball2,r_ball3);

module base (r_bottom,height,rounding,connector_radius,ball_distance, c1,c2,c3) {
    union () {
        // connector
        color("white")cylinder(h=height+2*ball_distance+c1*2+c2*2+c3*2,r=connector_radius,$fn=60);
        //base
        color("DarkSlateBlue") cylinder (h=height-0,r=r_bottom-rounding,$fn=60);
        color("MediumSlateBlue")cylinder (h=height-rounding,r=r_bottom,$fn=60);
        translate([0,0,height-rounding]) color("SlateBlue") rotate_extrude() 
            translate([r_bottom-rounding,0,0]) circle(r=rounding,$fn=120);
        // circle (ball) 1, 2 and 3
        translate([0,0,height+ball_distance+c1]) color("Indigo")sphere(r=c1,center=true,$fn=60);
        translate([0,0,height+2*ball_distance+2*c1+c2]) color("Violet")sphere(r=c2,center=true,$fn=60);
            translate([0,0,height+3*ball_distance+2*c1+2*c2+c3]) color("Purple")sphere(r=c3,center=true,$fn=60);
    }
}