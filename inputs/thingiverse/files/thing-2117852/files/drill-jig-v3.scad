leg_size = 50.5;
leg_clearance = 0.2;
leg_offset = 1.6;
hole_size = 1.55; //radius, incl. clearance
hole_offset = leg_size/6;
stage_1 = 5;
stage_2 = 4;
stage_3 = 4;
wall = leg_offset;

difference(){

translate([0,0,(stage_1+stage_2+stage_3)/2])
cube([leg_size+(2*leg_clearance)+(2*leg_offset)+(2*wall),
    leg_size+(2*leg_clearance)+(2*leg_offset)+(2*wall),
    stage_1+stage_2+stage_3],center=true);

translate([0,0,((stage_2+stage_3)/2)+stage_1])
cube([leg_size+(2*leg_clearance),
    leg_size+(2*leg_clearance),
    stage_2+stage_3],center=true);

translate([(wall+leg_clearance)/2,(wall+leg_clearance)/2,(stage_3/2+stage_1+stage_2)])
cube([leg_size+(2*leg_offset)+wall+leg_clearance,
    leg_size+(2*leg_offset)+wall+leg_clearance,
    stage_3],center=true);

translate([((leg_size/2)-(hole_offset)),((leg_size/2)-(hole_offset)),stage_1/2])
cylinder(stage_1,hole_size,hole_size,center=true,$fn=50);

translate([-((leg_size/2)-(hole_offset)),((leg_size/2)-(hole_offset)),stage_1/2])
cylinder(stage_1,hole_size,hole_size,center=true,$fn=50);

translate([((leg_size/2)-(hole_offset)),-((leg_size/2)-(hole_offset)),stage_1/2])
cylinder(stage_1,hole_size,hole_size,center=true,$fn=50);

translate([-((leg_size/2)-(hole_offset)),-((leg_size/2)-(hole_offset)),stage_1/2])
cylinder(stage_1,hole_size,hole_size,center=true,$fn=50);
    
}
