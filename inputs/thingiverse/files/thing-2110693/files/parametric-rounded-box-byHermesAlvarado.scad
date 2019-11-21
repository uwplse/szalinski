/* [ Mini Rounded Box v.1 ]
written by: Hermes Alvarado <hermesalvarado@gmail.com
*/
//Define dimensions:
$fn=50; //resolution
thickness = 1;
bottomthickness = 1;
tolerance = 0.4;
width = 45;
length = 25;
height = 25;
lidheight = 7;

//Make box:
difference(){
    minkowski(){
        cube([width,length,height]);
        cylinder(r=1,h=1);
        }
        translate([thickness/2,thickness/2,bottomthickness]){
            minkowski(){
                cube([width-thickness,length-thickness,height]);
                cylinder(r=1-thickness/2,h=1);
            }
        }
    }
//Make lid:
    translate([0,length*1.5,0]){    
    difference(){
        minkowski(){
            cube([width+thickness*2+tolerance*2,length+thickness*2+tolerance*2,lidheight]);
            cylinder(r=1,h=1);
        }
        translate([thickness/2,thickness/2,bottomthickness]){
            minkowski(){
                cube([width+tolerance*2+thickness,length+tolerance*2+thickness,lidheight]);
                cylinder(r=1+tolerance-thickness,h=1);
            }
        }
    }
}