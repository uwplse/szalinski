part = "2"; // [1: Clock Face, 2:Clockwork Bracket, 3:Diffusor Bracket, 4:Diffusor Panel, 5:Diffusor Seam, 6: Diffusor Seam with cable hole]


//in mm
diameter = 200; // [150:300]

//hole diameter in mm
core_inner = 95; // [50:150]

//diameter in mm (The surface that the Filament sits on)
core_outer = 100; // [82:152]

//in mm (Measure only the slot, not the walls of the spool!)
spool_width = 62; // [40:100] 


//in mm
clockwork_size = 56; // [30:80]



print_part();


module print_part(){
    
    if (part == "1") {
        clockface();
    }
    else if (part == "2") {
        clockwork();
    }
    else if (part == "3") {
        diff_bracket();
    }
    else if (part == "4") {
        diff_panel();
    }
    else if (part == "5") {
        diff_seam();
    }
    else if (part == "6") {
        diff_seam_02();
    }  
    }




module clockface() {

union() {

difference()   {
    $fn = 50;
    cylinder(2,d = diameter- 1, d = diameter-1);
    
    translate([0,0,-0.5])cylinder(3, d = diameter - 10, d = diameter-10);
    
               }
               
for (i = [1:60]) {
    rotate(a = i * 6, v = [0, 0, 1])translate([-1, diameter/2-10 , 0]) cube([2,6,2]);
                 }
 
for (i = [1:12])  {
    rotate(a = i * 360/12, v = [0, 0, 1])translate([-2, diameter/2-13 , 0]) cube([4,9,2]);
                 }
       }}






module clockwork() {
    
union() {

difference() {

$fn = 50;

cylinder(14, d = core_inner, d = core_inner);

translate ([0, 0, 2]) cylinder(14, d = core_inner- 4, d = core_inner - 4);
    
difference() {
    translate([0, 0, -2]) cylinder(15, 15, 15);
    
    }}
    
difference() {
    translate([-(clockwork_size+5)/2,-(clockwork_size+5)/2,0]) cube(size = [clockwork_size+5,clockwork_size+5,12]);
    translate([-(clockwork_size+2)/2,-(clockwork_size+2)/2,2]) cube([clockwork_size+2,clockwork_size+2,20]);
    
$fn = 50;
    
difference() {
    translate([0, 0, -2]) cylinder(15, 15, 15);
            }}}}
            
            



module diff_bracket() {

    
difference() {
           
        
intersection() {
    translate([1,1,0]) cube([diameter,diameter,diameter]);

    difference() {
        $fn = 50;
        difference() {
            cylinder(4, d = diameter-4, d = diameter-4);
            translate ([0,0,1]) cylinder(4.1, d = diameter-6, d =   diameter-6);
            }
        translate([0,0,-1]) cylinder(5, d =  core_outer+0.5 , d = core_outer+0.5);
        }}
        
intersection() {
        translate([15,15,-1]) cube([diameter, diameter, diameter]);
        $fn = 50;
    difference() {
        translate([0,0,-1])cylinder(diameter+2, d = diameter-30, d = diameter-30);
    difference() {
        translate([0,0,-1]) cylinder( diameter+2, d = core_outer+30, d = core_outer+30);
        
    }}}}}
           




module diff_panel() {

cube(size = [spool_width-1, diameter* 3.1415/4-4, 0.21]);
    
                    }
                    
                    
                    
module diff_seam() {
    
cube([spool_width, 5, 2]);
    
                   }


module diff_seam_02() {
    
difference() {
    
union() {

cube([spool_width, 5, 2]);

translate([0,-2,0]) cube([9, 9, 2]);
    
        }
    
translate([-0.01,0,-2])cube([6,5,10]);
            }}