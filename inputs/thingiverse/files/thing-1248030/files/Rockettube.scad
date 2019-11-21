//Length of the Section - in mm
length_of_section = 20; //[20:150]
//
//Diameter of the Section - in mm
section_diameter = 100; //[15:150]
//
//Thickness of the skin and supports - in mm
skin_thickness = 1; //[1:3]
//
//Top Connector Type: 1=connector,2=socket,0=none
top_connector_type = 1;//[1,2,0]
//
//Bottom Connector Type: 1=connector,2=socket,0=none
bottom_connector_type = 2;//[1,2,0]
//
//Number of internal Braces
number_of_braces =6;//[0,2,3,4,5,6,8,12]

//// Draw The Part

part_cylinder(length_of_section,section_diameter,skin_thickness,top_connector_type,bottom_connector_type,number_of_braces);
    
//// Modules////

///////Cylinder Fuselage Part////////

module part_cylinder(length,diam,thick,toptype,bottomtype,numbraces){
    
        union(){
            part_cylinder_braces(length,diam,thick,toptype,bottomtype,numbraces);
            part_cylinder_skin_final(length,diam,thick,toptype,bottomtype,numbraces);
            }
      
        
    }
//
    
module part_cylinder_skin_final(length,diam,thick,toptype,bottomtype,numbraces){
   difference(){
    part_cylinder_skin(length,diam,thick,toptype,bottomtype);
      flange_holes(length,numbraces,diam/2);
            };
    }  
//
 
    module part_cylinder_skin(length,diam,thick,toptype,bottomtype){
  rotate_extrude(convexity = 10,$fn=64)
    part_cylinder_skin_outline(length,diam,thick,toptype,bottomtype);
    }  
//
 
module part_cylinder_skin_outline(length,diam,thick,toptype,bottomtype){union(){
    translate([diam/2,0]){
    endcap(bottomtype,thick,diam/2);
    sidewall(thick,length);
    translate([0,length]){mirror([0,1]){endcap(toptype,thick,diam/2);};}
        }}
    }
//
    
module sidewall (thick,length){
    translate([0,0]){square([thick,length]);}
    }
//
   
module flange_holes(length,numholes,radius){
    rotate([0,0,360/numholes/2]){
        //translate([0,0,0]){
            for (i=[1:numholes]){
                rotate([0,0,i*360/numholes]){
                    translate([radius-2.75,0,-10]){
                        cylinder(r=1,h=length+15,$fn=64);
                        }
                    }
                }
            //}
        }
    }
    
//

module part_cylinder_braces(length,diam,thick,toptype,bottomtype,numbraces){
    for (i=[1:numbraces]) {rotate([0,0,i*360/numbraces]){
    3d_brace(length,diam,thick,toptype,bottomtype);}
    }}
//
    
    
module 3d_brace(length,diam,thick,toptype,bottomtype){
    translate([diam/2-5+thick/2,thick/2,0]){rotate([90,0,0]){
        linear_extrude(height = thick,0,convexity = 10){
            flat_brace(length,toptype,bottomtype,thick);
            }
        }
    }
}
//

//////brace additions for connectors////
module type1_brace_adds(toptype,bottomtype,length,thick){
    if (toptype==1){
        translate([-thick+.25,length-thick]){square([4,4]);}}
    if (bottomtype==1){
        translate([-thick+.24,-4+thick]){square([4,4]);}}}
//
        
        
module type2_brace_outs(toptype,bottomtype,length,thick){
    if (toptype==2){
        translate([0,length-4]){square([4,4]);}}
    if (bottomtype==2){
        translate([0,0]){square([4,4]);}}}
        
//

        
module flat_brace(length,toptype,bottomtype,thick){
    type1_brace_adds(toptype,bottomtype,length,thick);
    difference(){
        flat_brace_basic(length);
        type2_brace_outs(toptype,bottomtype,length,thick);
        }
    }


//

module flat_brace_basic(length){
    difference(){square([4,length]);
        for (i=[1:6]) {
            translate([2,i*length/10*2]){
                circle(r=1.5,$fn=12);
                }
            }
        }
    }
//
  
//////endcaps/////  
module endcap(type,thick,rad){
    if (type==1){
        type1_end(5,thick,rad);}
        if (type==2){
            type2_end(5,thick,rad);}
            if (type==0){;}
    }
//
    
module type2_end(width,thick,rad){
    translate([-width,width-thick]){square([width+thick,thick]);}
    translate([0,0]){square([thick,width]);}
    }
//
    
module type1_end(width,thick,rad){
    translate([-width-.25,-width+thick]){square([width,thick]);}
    
    translate([-thick-.25,-width+thick]){square([thick,width]);}
    
    translate([-.25,.25]){square([thick,thick]);}
    }
//
    
///////////////////  
    
