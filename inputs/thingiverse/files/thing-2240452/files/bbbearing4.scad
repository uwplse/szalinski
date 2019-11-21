// <senorjp@gmail.com> April 2017
// Printable Lazy Suzan Bearing
//
$fn = 100;

module lazysusan(
    hole_diameter = 20,
    screw_diameter = 3,
    bearing_diameter = 0.177*25.4,
    assembly = true // false for flat print
) {
      
pi = 3.141592653589793238;

    
    
screw_hole_diameter =  screw_diameter * 1.3;
screw_spacing = screw_hole_diameter * 8; // circumferential screw spacing 
screw_inset = screw_hole_diameter /2;

nut_size = screw_diameter*1.4;
nut_trap_depth = nut_size*.3;


raceway_thickness = bearing_diameter * .8;
raceway_inset = screw_hole_diameter /4;



function screw_inset() = screw_inset;
function screw_diameter() = screw_diameter;
function screw_hole_diameter() = screw_hole_diameter;
function raceway_inset() = raceway_inset;
function bearing_diameter() = bearing_diameter;
function bearing_race_diameter() = bearing_race_diameter;
function hole_diameter() = hole_diameter;
function raceway_thickness() = raceway_thickness;
function number_of_screws() = ceil(raceway_screw_diameter()*pi/screw_spacing);
function inner_number_of_screws() = ceil(inner_raceway_screw_diameter()*pi/screw_spacing);
function fixed_number_of_screws() = ceil(fixed_raceway_screw_diameter()*pi/screw_spacing);


function bearing_race_diameter() = 
    hole_diameter()
    + raceway_inset()*2
    + bearing_diameter()
    + screw_inset()*2
    + screw_hole_diameter()*2
    ;

    function raceway_diameter() =
    bearing_race_diameter()
    + bearing_diameter()
    + raceway_inset()*2
    ;

    function raceway_screw_diameter() =
        hole_diameter() 
        + screw_inset()*2 
        + screw_hole_diameter();
    
    function inner_raceway_hole_diameter() = 
    bearing_race_diameter()
    - bearing_diameter()
    - raceway_inset()*2
    ;

    function inner_raceway_screw_diameter() = 
    bearing_race_diameter()
    + bearing_diameter()
    + screw_hole_diameter()
    + raceway_inset()*2
    + raceway_inset()*2 // space between raceway and collar
    + screw_inset()*2
    ;
    
    function inner_raceway_diameter() =
    bearing_race_diameter()
    + bearing_diameter()
    + raceway_inset()*2
    + raceway_inset()*2 // space between raceway and collar
    + screw_inset()*4
    + screw_hole_diameter()*2
   ;
    
    function fixed_raceway_diameter() =
    inner_raceway_diameter()
    + raceway_inset()*2
    + screw_inset()*2
    + screw_hole_diameter()*2
   ;
   
    function fixed_raceway_screw_diameter() =
    inner_raceway_diameter()
    + raceway_inset()*2
    + screw_hole_diameter()
   ;


module screw() {
        cylinder(r=(screw_hole_diameter()/2), h = 300, center=true);
}

module screws(){
    angle=360/number_of_screws();


    for (i=[0:1:number_of_screws()-1]){
        //echo (str("ang ", angle*i));
        //echo (str("disp ", disp));
        rotate(angle*i, [0,0,1])
        translate ([0,raceway_screw_diameter()/2,0])
        screw();
    }
}

module inner_screws(){
    angle=360/inner_number_of_screws();
        

    for (i=[0:1:inner_number_of_screws()-1]){
        rotate(angle*i, [0,0,1])
        translate ([0,inner_raceway_screw_diameter()/2,0])
        screw();
    }
}

module fixed_screws(
){
        angle=360/fixed_number_of_screws();
        

    for (i=[0:1:fixed_number_of_screws()-1]){
        rotate(angle*i, [0,0,1])
        translate ([0,fixed_raceway_screw_diameter()/2,0])
        screw();
    }
}




module bearing_race() {
    rotate_extrude(convexity = 1)
    translate([bearing_race_diameter()/2, 0, 0])
    circle(r = bearing_diameter()/2);
}



module raceway() {
    
    difference() {
    cylinder(r=raceway_diameter()/2, h=raceway_thickness());
        
    translate([0,0,raceway_thickness()*1.2])
    negative();
        
    }

}



module inner_raceway_half(collar = 0, nut_size = 0) {
    difference() {
        union() {
            cylinder(r=inner_raceway_diameter()/2, h=raceway_thickness());

            if (collar > 0) {
                
                translate([0,0,raceway_thickness()-1])
                cylinder(r=inner_raceway_diameter()/2, h=collar+1);
            }
        }
        
         if (collar > 0) {
            echo(str("collar ",collar));
            translate([0,0,raceway_thickness()])
            cylinder(r = raceway_diameter()/2+raceway_inset(), h=collar*2);
         }
         
         if (nut_size > 0) {
        angle=360/inner_number_of_screws();


        for (i=[0:1:inner_number_of_screws()-1]){
            rotate(angle*i, [0,0,1])
            translate ([0,inner_raceway_screw_diameter()/2,raceway_thickness()-nut_trap_depth])
            nut_trap();
        }

     }
        
    translate([0,0,raceway_thickness()*1.2])
        
    inner_negative();

    }

}


module inner_raceway() {

    inner_raceway_half(collar = raceway_thickness()*2);

    rotate(180,[1,0,0])
    inner_raceway_half();

}


module fixed_raceway(nut_size=0) {
    echo(str("Diameter of fixed raceway: ", fixed_raceway_diameter(), "mm"));
    difference() {

        cylinder(r=fixed_raceway_diameter()/2, h=raceway_thickness());
            
        translate([0,0,raceway_thickness()*1.2])  
        negative();
        fixed_screws();
         if (nut_size > 0) {
        angle=360/number_of_screws();


        for (i=[0:1:number_of_screws()-1]){
            rotate(angle*i, [0,0,1])
            translate ([0,raceway_screw_diameter()/2,nut_trap_depth-nut_size])
            nut_trap();
        }
    }

    }

}

module channel(){
    //echo(str("hole_diameter ", hole_diameter()));
    translate([0,0,-raceway_thickness])
    cylinder(r=hole_diameter()/2, h=raceway_thickness()*4, center=true);
}

module inner_channel() {
    cylinder(r=inner_raceway_hole_diameter()/2, h=inner_raceway_hole_diameter()*2, center=true);
}




module negative() {
    channel();
    bearing_race();
    screws();
}


module inner_negative() {

    inner_channel();
    bearing_race();

    inner_screws();
}

module nut_trap() {
    cylinder(r = nut_size, h = nut_size, $fn = 6);
}

module bearings() {
    bearings = floor((bearing_race_diameter()*pi)/bearing_diameter());
    echo(str("Bearings per race: ", bearings));
    angle = 360/bearings;
    for (i=[0:1:bearings]){
        rotate(angle*i, [0,0,1])
        translate([bearing_race_diameter()/2,0,0])
        sphere(r=bearing_diameter()/2);
    }

}
module assembly(hole = hole_diameter()
) {
    $hole_diameter = hole;
    
    raceway();

    translate([0,0,bearing_diameter()*4])
    color("orange")
    bearings();

    translate([0,0,bearing_diameter()*10])
    rotate(180,[1,0,0])
    rotate((360/inner_number_of_screws()), [0,0,1]) // line up holes
    inner_raceway_half(collar = raceway_thickness()*3);

    translate([0,0,bearing_diameter()*12])
    inner_raceway_half(nut_size=nut_size);

    translate([0,0,bearing_diameter()*16])
     color("orange")
   bearings();

    translate([0,0,bearing_diameter()*20])
    rotate(180,[1,0,0])
    rotate(360/number_of_screws()/2, [0,0,1]) // line up holes
    fixed_raceway(nut_size=nut_size);
    
    //%screws();
    //%inner_screws();

}

module quad_print(hole = hole_diameter()) {
    $hole_diameter = hole;
translate([0,-2])
    raceway();
    
translate([inner_raceway_diameter()/2+fixed_raceway_diameter()/2+2,0])
    inner_raceway_half(collar = raceway_thickness()*3);

translate([inner_raceway_diameter()/2+fixed_raceway_diameter()/2+2,inner_raceway_diameter()+2])
    inner_raceway_half(nut_size=nut_size);

translate([0,raceway_diameter()/2+fixed_raceway_diameter()/2])
    fixed_raceway(nut_size=nut_size);

}

    // This is the output //
    if (assembly) {
        translate([0,0,bearing_diameter()*20])
        rotate(180,[1,0,0])
        assembly();
    }
    else {
        quad_print();
    }
}

lazysusan(assembly=false);


/* ////////// demo ////////////////
for (x = [1:1:5]) {
    translate([x*160,0,0])
    lazysusan(
        hole_diameter = 20*x,
        //screw_diameter = 5,
        //bearing_diameter = 20,
        assembly=true // false for printable layout
    );
}

for (x = [1:1:5]) {
    translate([x*160,250,0])
    lazysusan(
        //hole_diameter = 20*x,
        //screw_diameter = 5,
        bearing_diameter = 5*x,
        assembly=true // false for printable layout
    );
}

for (x = [1:1:5]) {
    translate([x*160,-250,0])
    lazysusan(
        //hole_diameter = 20*x,
        screw_diameter = 1.5*x,
        //bearing_diameter = 5*x,
        assembly=true // false for printable layout
    );
}
*/

