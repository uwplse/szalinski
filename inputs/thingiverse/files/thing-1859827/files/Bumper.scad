// Height of bumper (Hight of the tank)
bumper_height=25; 
// Inner diameter, diamiter of tank
inner_diameter=22;
// Thickness of bumper
wall_thickness=2;
// Lateral width of bars in the bumper
bar_width=3;
// Model clearance
clearance=.3;
// Number of bars in twist
bars=12;
// Edge width, thickness of top and bottom bar.
edge_width=bumper_height/4;
/* [Hidden] */
// maximum model angle
A=6;
// Rotation of Bars
R=360/bars;


intersection() {

difference() {
make();
translate([0,0,-5]) cylinder(bumper_height+10,d=inner_diameter+clearance,$fa=A);
//translate([0,0,-5]) cylinder(bumper_height+10,d=inner_diameter+wall_thickness+2*clearance,$fa=A);
}
translate([0,0,-5]) cylinder(bumper_height+10,d=inner_diameter+wall_thickness+2*clearance,$fa=A);
}

module bars () {
    for(i=[0:bars-1]){ 
        rotate([0,0,360/bars*i])
            translate([0,0,limit_edges()])
                linear_extrude(height = bumper_height-2*limit_edges(), convexity = 10, twist = R, $fn=100)
                    translate([-(inner_diameter+wall_thickness)/2,0,0])
                        polygon([[0,0],[0,bar_width],[wall_thickness,bar_width],[wall_thickness,0]]);
    }
}

module make () {
    cylinder(limit_edges(),d=inner_diameter+wall_thickness+2*clearance, $fa=A);
    translate([0,0,bumper_height-limit_edges()])
        cylinder(limit_edges(),d=inner_diameter+wall_thickness+2*clearance, $fa=A);
    bars();
    rotate([0,0,1.6*limit_edges()-bumper_height])mirror()bars(); 
}

function limit_edges()=
    max(wall_thickness,edge_width);