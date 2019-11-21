/*
*  disable
!  show only
#  highlight / debug
%  transparent / background
*/
/*
 Wire Clamps: To clamp wire to board. Clamps are created in a grid,
 depending on row and col parameters. E.g. if row = 4 and col = 5, 
 20 clamps would be created.
*/
// Default number of facets
$fn=40;  
// Number of rows of clamps 
row = 8; 
// Number of clamps in each row
col = 5;  
// Gap between each clamps (max 2)
sep = .75; 
// clamp width
c_width = 20;
// clamp depth
c_depth = 10;
// clamp height (thickness)
c_height = 4;       
/*
Suggested Screw parameters (Pan Head Screws). These may require some 
experimentation, depending on your printer:
Screw 
Gauge           Diam            Head
 #4             4.0             7.0
 #6             4.5             7.5
 #8             5.0             8.5
*/
// Screw diameter
diam = 4.0;
// Screw head diameter - for countersink
head = 7.0; 
// Add recesses for screw heads? (y/n)
recessyn = "y"; // [y,n]
// Depth of wire recesses    
recess = 1.0;
// Create with screw holes face down (y/n)
facedown = "y";   // [y,n]  


module clamp(dox,doy,yn){
    difference(){
    cube([c_width,c_depth,c_height],center=false);
        // Make a couple of wire recesses
        translate([1,0,0]){
            cube([((c_width-diam)/2)-2,c_depth,recess],center=false);
        }
        translate([((c_width+diam)/2)+1,0,0]){
            cube([((c_width-diam)/2)-2,c_depth,recess],center=false);
        }

        // Add a hole for a screw
        translate([c_width/2,c_depth/2,0]) cylinder(d=diam,h=c_height);
        if(yn=="y"){
            // And a recess for the head
            translate([c_width/2,c_depth/2,c_height-1]) cylinder(d=head,h=1);
        }
    }
    if(dox==1){
        // add the connection tabs
        translate([c_width-((4-sep)/2),(c_depth-.5)/2]){
            cube([4,0.5,0.5],center=false);
        }
    }
    if(doy==1){
        translate([(c_width-.5)/2,c_depth-((4-sep)/2)]){
            cube([0.5,4,0.5],center=false);
        }
    }
}
module main(){
    for (y=[0:1:row-1]){
        for (x=[0:1:col-1]){
            translate([x*(c_width+sep),y*(c_depth+sep),0]){
                if(x<col-1 && y<row-1){
                    clamp(1,1,recessyn);  // Do both connectors
                }
                else if(y<row-1 && x==col-1){
                    clamp(0,1,recessyn);  // Do the row connector
                }
                else if(y==row-1 && x<col-1){
                    clamp(1,0,recessyn);  // Do the Col connector
                }
                else if(y==row-1 && x==col-1){
                    clamp(0,0,recessyn);  // No connectors
                }
            }
        }
    }
}
if(facedown=="y"){
    translate([0,0,4]){mirror([0,0,1]){main();}}
}else{
    main();
}
