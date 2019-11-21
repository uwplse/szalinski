//to make more smooth if you need
$fn=35;

bearing_height = 7+0;
bearing_radius = 11+0;

//adjust this for your machine's tolerance to fit the bearing in
r_buffer = 1.15;

bearing_cap_height = bearing_height + 4;
bearing_cap_radius = bearing_radius+r_buffer;
echo(bearing_cap_radius-1);

//Adjust the length of your stick. (Image shown is 90)
stick_height = 90;
//Adjust the thickness of the stick
stick_radius = 5.5;
nub_height = 5.5+0;
shaft_height = stick_height+nub_height;
cubeSize = 4+0;
module bearing_nub(){
    cylinder(h = nub_height+.1, r = 4.05);
    translate([-cubeSize/2,-cubeSize/2,nub_height]) cube(cubeSize-.2,center=false);
}
module stick(){
    //difference(){
    difference(){
        cylinder(h = stick_height, r = stick_radius);
        translate([-cubeSize/2,-cubeSize/2,-.1]) cube(cubeSize+.2,center=false);
        translate([-cubeSize/2,-cubeSize/2,stick_height-cubeSize+.1]) cube(cubeSize+.2,center=false);
    }
        
        //translate([0,0,-.1]) bearing_nub();
        //translate([0,0,stick_height-nub_height]) bearing_nub();
    //}
}
grip_height = 15+0;
module grip(){
    cylinder(h=grip_height, r1=5.5,r2=2);
    translate([0,0,grip_height]) sphere(2);
    cylinder(h=2.5, r=5.5);
}

module cap(){
    difference(){
        translate([0,0,-bearing_cap_height]) cylinder(h= bearing_cap_height, r=bearing_cap_radius);
    
        translate([0,0,-bearing_cap_height-2]) cylinder(h=bearing_cap_height, r=bearing_cap_radius-1);
    }
    
    //stick gripper
    /**difference(){
        translate([0,0,-3.9]) cylinder(h=2, r=bearing_cap_radius);
        translate([0,0,-5]) cylinder(h=7, r=4.8);
    }**/
}
module bearing(){
    difference(){
        translate([0,0,-bearing_cap_height]) color("DarkSlateGray") cylinder(h = bearing_height, r = bearing_radius);
        
        translate([0,0,-bearing_cap_height]) color("DarkSlateGray") cylinder(h = bearing_height, r = bearing_radius);
    }
}
module thumbZone(){
    cap();
    translate([0,0,-.1])grip();
}
translate([stick_radius*3,stick_radius*3,grip_height-4]) thumbZone();
translate([-stick_radius*3,-stick_radius*3,grip_height-4]) thumbZone();
stick();
translate([stick_radius*3,-stick_radius*3,0]) bearing_nub();
translate([-stick_radius*3,stick_radius*3,0]) bearing_nub();
