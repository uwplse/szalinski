// model variables
$fa=0.5*1; // default minimum facet angle is now 0.5 deg
$fs=0.5*1; // default minimum facet size is now 0.5 mm
tolx=0.25; // tolerance for mating parts.

    // Maximum diameter
    max_dia = 25; // [15:50]
    // Thickness of slab
    thickness = 6; // [1:25]
    // Central Bore diameter
    bore = 6; // [3:24]
    // Spiral: higher values are more circular
    spiral=5; // [3:30]
    // coarseness: higher values take longer to render
    dt=5; // [1:20]

    b=(1/spiral)*(2*PI)/360;
    a=1/exp(b*360);

module positive_elements(){
    for (t=[dt:dt:360]){
        r_minus=a*exp(b*(t-(dt+tolx)));
        r_plus=a*exp(b*t);
        hull(){
            rotate([0,0,t-(dt+tolx)]) cube([r_minus*max_dia,tolx,thickness]);
            rotate([0,0,t]) cube([r_plus*max_dia,tolx,thickness]);
        }
    }
    translate([max_dia-12.5,-3+tolx,0]) cube([10,3,thickness*2]);

    translate([-max_dia/2,max_dia,0]){
        cube([max_dia*3,bore*3,thickness]);
        translate([max_dia*2,0,thickness]) cube([max_dia,bore*3,thickness]);
        }
}


module negative_elements(){
    translate([0,0,-tolx]) cylinder(r=bore/2,h=thickness+2*tolx);

    translate([-max_dia/2+bore,max_dia+bore,-tolx]){
        cube([max_dia*2-2*bore,bore,thickness+2*tolx]);}
}

difference(){
    positive_elements();
    negative_elements();
}