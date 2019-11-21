
/*
v2 offsets the openings
*/

/*
print body in Spiralized/Vase Mode with bottom but no top!
print lid normally
*/

$fa=.5;
$fs=.5;

body_diameter=40; // remember openings will stick out more
body_height=74;
top_lip=3;

lid_height=2; // how much it sticks up; down in will be same

line_width=.8;
slop=.2;

opening_radius=5; // this should probably be related to particle size; mine is 2-4mm, but remember opening is reduced by wall thickness
opening_height=5;
openings_per_level=16;
gap_between_levels=-1.6;

stagger_degrees=360/openings_per_level/2;

levels=floor( (body_height-top_lip)/(opening_height+gap_between_levels) );

//translate([0,0,body_height+lid_height]) rotate([180,0,0])
//lid();
body();

module lid() {
    cylinder(d=body_diameter+opening_radius/2,h=lid_height);
    translate([0,0,lid_height]) {
        cylinder(d=body_diameter-2*(line_width+slop),h=lid_height);
    }
}

module body() {
    cylinder(d=body_diameter,h=body_height);
    for(i = [0:1:levels-1]) {
        rotate([0,0,i*stagger_degrees]) {
            translate([0,0,i*(opening_height+gap_between_levels)]) {
                points() {
                    cylinder(d1=0, d2=opening_radius,h=opening_height);
                }
            }
        }
    }
}

module points() {

    // https://gist.github.com/cgspeck/8cbb4fd8ac958f15ad9327088750d002

    //radius = 10;
    radius = body_diameter/2;
    //circle(radius);

    //sectors = 8;
    sectors = openings_per_level;
    sector_degrees = 360 / sectors;

    for(sector = [1 : sectors]) {
        angle = sector_degrees * sector;
        //echo(str("--- Angle:", angle));
        x_pos = radius * sin(angle);
        y_pos = radius * cos(angle);
        //echo(str("x:", x_pos));
        //echo(str("y:", y_pos));
        
    //    translate([x_pos,y_pos,-1]){
        translate([x_pos,y_pos]){
    //        cube(2, center=true);
            children();
        }
    }

}