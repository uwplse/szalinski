//Pitch of the spiral
pitch = 2;

//Radius of the cylinder
radius = 15;

//Height of the cylinder
height = 30;

//Spiral Thickness
sp = 1.75;

thickness = radius*.7;

cylinder(h=height/10,r=radius,c=true);
translate([0,0,height]){
    cylinder(h=height/10,r=radius,c=true);
}

translate([0,0,height/10]){
    difference(){
        //Create The spiral
        linear_extrude(height*(9/10), center = false, convexity = 10, twist = pitch*100)
        translate([radius-thickness/2, 0, 0]){
        circle(r = thickness);}
        //Cut out the inside
        cylinder(h=height,r=radius-sp,c=false);
        //Cut out the outside
        difference(){
            cylinder(h=height,r=2*radius,c=false);
            cylinder(h=height,r=radius,c=false);
        }
    }
        
    
}

translate([0,0,height/10]){
    difference(){
        //Create The spiral
        linear_extrude(height*(9/10), center = false, convexity = 10, twist = pitch*100)
        translate([-(radius-thickness/2), 0, 0]){
        circle(r = thickness);}
        //Cut out the inside
        cylinder(h=height,r=radius-sp,c=false);
        //Cut out the outside
        difference(){
            cylinder(h=height,r=2*radius,c=false);
            cylinder(h=height,r=radius,c=false);
        }
    }
        
    
}
    