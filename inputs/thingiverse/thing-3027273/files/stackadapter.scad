//Flight stack adapter (Customizer enabled)

//Variables
//Make printable without supports. If you choose to have any standoffs below the model, it will be split and flipped to print in two pieces.
print_without_supports = 1; //[0:No, 1:Yes]
//Overall size of adapter (mm)
overall_size = 38; // [38:50]
//Thickness of adapter plate (mm)
thickness = 2; //[1:0.5:5]
//Size of outer holes
outer_hole_size = 3.4; //[2.4:M2, 3.4:M3, 5.5:M5]
//Outer standoff above plate (mm)
outer_standoff_top_height = 0; //[0:10]
//Outer standoff below plate (mm)
outer_standoff_bottom_height = 0; //[0:10]
//Size of inner holes
inner_hole_size = 2.4; //[2.4:M2, 3.4:M3, 5.5:M5]
//Inner standoff above plate (mm)
inner_standoff_top_height = 2; //[0:10]
//Inner standoff below plate (mm)
inner_standoff_bottom_height = 0; //[0:10]

/* [Hidden] */
$fn=50;
corner_radius = 2.9;
outer_hole_space = 30.5;
inner_hole_space = 20;
standoff_thickness = 1.2;
plate_hole_size = 22;


//Main object

if ((outer_standoff_bottom_height==0)&&(inner_standoff_bottom_height==0)) translate([0,0,thickness/2]) adapter();
    else if (print_without_supports==1){
        translate([50,0,0])
            rotate([0,180,0])
                intersection(){
                    adapter();
                    translate([0,0,-50]) cube(100,true);
                }
        intersection(){
            adapter();
            translate([0,0,50]) cube(100,true);
        }
    }
    else translate([0,0,thickness/2]) adapter();


//Modules
    
module adapter(){
    difference(){
        union(){
            plate();
            outer_standoff_top();
            outer_standoff_bottom();
            inner_standoff_top();
            inner_standoff_bottom();
        }
        outer_holes();
        inner_holes();
        rotate([0,0,45]) plate_hole();
    }
}

module plate(){
    hull() {
        for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(overall_size/2)-corner_radius,(overall_size/2)-corner_radius,0]) cylinder(h=thickness, r=corner_radius, center=true);
        }
    }
}

module plate_hole(){
    hull() {
        for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(plate_hole_size/2)-corner_radius,(plate_hole_size/2)-corner_radius,0]) cylinder(h=thickness+2, r=corner_radius, center=true);
        }
    }
}

module outer_holes() {
    for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(outer_hole_space/2),(outer_hole_space/2),0]) cylinder(h=25, r=outer_hole_size/2, center=true);
        }
}

module outer_standoff_top() {
    for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(outer_hole_space/2),(outer_hole_space/2),(thickness+outer_standoff_top_height)/2]) cylinder(h=outer_standoff_top_height, r=(outer_hole_size/2)+standoff_thickness, center=true);
        }
}

module outer_standoff_bottom() {
    for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(outer_hole_space/2),(outer_hole_space/2),-(thickness+outer_standoff_bottom_height)/2]) cylinder(h=outer_standoff_bottom_height, r=(outer_hole_size/2)+standoff_thickness, center=true);
        }
}

module inner_holes() {
    for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(inner_hole_space/2),(inner_hole_space/2),0]) cylinder(h=25, r=inner_hole_size/2, center=true);
        }
}

module inner_standoff_top() {
    for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(inner_hole_space/2),(inner_hole_space/2),(thickness+inner_standoff_top_height)/2]) cylinder(h=inner_standoff_top_height, r=(inner_hole_size/2)+standoff_thickness, center=true);
        }
}

module inner_standoff_bottom() {
    for (i=[0:3]) {
            rotate([0,0,90*i]) translate([(inner_hole_space/2),(inner_hole_space/2),-(thickness+inner_standoff_bottom_height)/2]) cylinder(h=inner_standoff_bottom_height, r=(inner_hole_size/2)+standoff_thickness, center=true);
        }
}