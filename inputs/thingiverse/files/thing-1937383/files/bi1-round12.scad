// bodyinteraction toy form and mold form generator
// radius of bottom part
r_bottom=25; // [15:5:80] 
// height of bottom part
h_bottom=30; // [10:5:80] 
// top rounding of bottom part
rounding=10; // [10:5:20]
// radius of ball 1 
r_ball1=21; // [15:5:50]  
// radius of ball 2
r_ball2=15;  // [15:5:50] 
//radius of ball 3 
r_ball3=11;  // [15:5:50] 
// radius of connecting cylinders
connector_radius=8; // [10:2:20]
// distance between balls and bottom part
ball_distance=15; // [10:2:40]
// offset (thickness of hull)
o=2; 
// offset (thickness of hull)
frame_thickness=4; 

height=h_bottom+3*ball_distance+r_ball1*2+r_ball2*2+r_ball3*2; echo(height);


// form part A
translate([0,0,height+frame_thickness])rotate([0,180,0])
difference() {
    complete_form(r_bottom,h_bottom,rounding,r_ball1,r_ball2,r_ball3,connector_radius,ball_distance,o,frame_thickness,height);
union(){
    translate([-r_bottom-o-10,0,-5])
    color("red")cube([2*r_bottom+2*o+20,r_bottom+2*o,height+frame_thickness+5]);
    holes(height,h_bottom);
    }
}
//form part B
translate([90,0,height+frame_thickness])rotate([0,180,0])
difference() {
    complete_form(r_bottom,h_bottom,rounding,r_ball1,r_ball2,r_ball3,connector_radius,ball_distance,o,frame_thickness,height);
union(){
    translate([-r_bottom-o-10,-r_bottom-o-2-10,-5])
    color("red")cube([2*r_bottom+2*o+20,r_bottom+2*o+10,height+frame_thickness+5]);
    holes(height,h_bottom);
    }
}

module holes (height,h_bottom){
for (i=[h_bottom+30:10:height])
    translate([r_bottom-1,5,i])rotate([90,90,0])
    color("green")cylinder(h=15,r=1,$fn=20);

for (i=[0:10:h_bottom+20])
    translate([r_bottom-3+10,5,i])rotate([90,90,0])
    color("blue")cylinder(h=15,r=1,$fn=20);

for (i=[h_bottom+30:10:height])
    translate([-r_bottom+1,5,i])rotate([90,90,0])
    color("green")cylinder(h=15,r=1,$fn=20);
for (i=[0:10:h_bottom+20])
    translate([-r_bottom-6,5,i])rotate([90,90,0])
    color("blue")cylinder(h=15,r=1,$fn=20);
}

module complete_form (r_bottom,h_bottom,rounding,r_ball1,r_ball2,r_ball3,connector_radius,ball_distance,o,frame_thickness,height) {
    difference() {
        union() {
        base(r_bottom+o,h_bottom+o,rounding,connector_radius+o,ball_distance-2*o,r_ball1+o,r_ball2+o,r_ball3+o);
        //complete frame
        frame(2*r_bottom+2*o,o,height,frame_thickness,r_bottom,h_bottom,rounding);
        };
    base(r_bottom,h_bottom,rounding,connector_radius,ball_distance,r_ball1,r_ball2,r_ball3);
        
       
};
}

module frame(width,o,height,frame_thickness,r_bottom,h_bottom,rounding) {
            //plate
        translate([-width/2,-width/2-2*o,height]) cube(size=[width,width+2*o,frame_thickness]);
        //frame1
        translate([-width/2,-frame_thickness/2,0]) cube(size=[width,frame_thickness,height]);
    //frame 1 extensions
    translate([-width/2-010,-frame_thickness/2,-5]) color("blue")cube(size=[12,frame_thickness,60]);
    translate([-width/2-10,-frame_thickness/2,55]) color("red")rotate([0,45,0]) cube(size=[12,frame_thickness,20]);
    
    translate([+width/2-2,-frame_thickness/2,-5]) color("green")cube(size=[12,frame_thickness,60]);
    translate([+width/2+01,-frame_thickness/2,47]) color("green")rotate([0,-45,0]) cube(size=[12,frame_thickness,20]);
        //frame2
        translate([-frame_thickness/2,-width/2,0]) cube(size=[frame_thickness,width,        ,
        height]);
        // stabilize bottom with cylinder
    color("green")translate([0,0,h_bottom])rotate([00,0,0180])
    cylinder(h=r_bottom*2-rounding*.5, r1= r_bottom-rounding, r2=0);

}

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