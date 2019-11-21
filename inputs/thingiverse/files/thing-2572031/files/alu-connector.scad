
profile_thickness = 1.5;

dimensions = [22,22, 60]; // 
jackl_dimensions = [25,25,25];
type = "middle_part"; // [middle_part, end_part, upper_part, lower_part, connector_part]

$fn=60;

module base() {
    cube(dimensions);
    
//    translate([0,22/4,0]) cylinder(r=1, h=dimensions[2]);
//    translate([0,22/4*2,0]) cylinder(r=1, h=dimensions[2]);
//    translate([0,22/4*3,0]) cylinder(r=1, h=dimensions[2]);

}

module lower_part() {
    translate([profile_thickness,profile_thickness,0]) base();
    translate([0,profile_thickness,dimensions[0]]) rotate([0,90,0]) base();
    translate([dimensions[0],0,dimensions[0]]) rotate([0,180,0]) base();
    translate([profile_thickness,0,dimensions[0]]) rotate([-90,0,0]) base();

    translate([0,0,-profile_thickness]) cube(jackl_dimensions);
    translate([0,0,-dimensions[2]+dimensions[1]]) cube([jackl_dimensions[0], jackl_dimensions[1], dimensions[2]]);
}

//lower_part();

module middle_part() {
    translate([0,0,0]) base();
    translate([0,0,dimensions[0]]) rotate([0,90,0]) base();
    translate([dimensions[0],0,dimensions[0]]) rotate([0,180,0]) base();
    translate([0,0,dimensions[0]]) rotate([-90,0,0]) base();

    translate([-profile_thickness,-profile_thickness,-profile_thickness]) cube(jackl_dimensions);

}

//middle_part();

module upper_part() {
    translate([0,0,0]) base();
    translate([0,0,dimensions[0]]) rotate([0,90,0]) base();
    translate([0,0,dimensions[0]]) rotate([-90,0,0]) base();

    translate([-profile_thickness,-profile_thickness,-profile_thickness]) cube(jackl_dimensions);

}

module t_part() {
    translate([0,0,0]) base();
    translate([0,0,dimensions[0]]) rotate([0,90,0]) base();
    translate([dimensions[0],0,dimensions[0]]) rotate([0,180,0]) base();

    translate([-profile_thickness,-profile_thickness,-profile_thickness]) cube(jackl_dimensions);
}

module end_part() {
    cube([dimensions[0], dimensions[1], 12]);
    translate([-profile_thickness, -profile_thickness, -3]) cube([jackl_dimensions[0], jackl_dimensions[1], 3]);
}

module connector_part() {
    translate([0,0,0]) base();
    translate([dimensions[0],0,dimensions[0]]) rotate([0,180,0]) base();

    translate([-profile_thickness,-profile_thickness,-profile_thickness]) cube(jackl_dimensions);
}


if (type=="connector_part") {
    connector_part();
}
if (type=="end_part") {

    end_part();
}


if (type=="upper_part") {
    upper_part();
}

if (type=="lower_part") {
    lower_part();
}
if (type=="middle_part") {
    middle_part();
}
if (type=="t_part") {
    t_part();
}
