//Radius of the bottom of the section
base_radius=20; //[6:55]

//Radius of the top of the section
tip_radius=12;//[0:55]

//It may not work correctly with same diameter ends, ex 15,15, use 15.1,15 or similar

//Length of the rocket section
length = 75;//

//Width of the mounting flanges and braces
mounting_lip_width = 4; //[4:6]

//Thickness of the skin
skin_thickness=1; //[1:4]

//Number of internal bracing ribs
quantity_of_internal_braces = 4;//[2:12]
//
//
//

edge = mounting_lip_width+skin_thickness;
s = base_radius-tip_radius;
sa= tip_radius-base_radius;
//
l = length-mounting_lip_width;
//
a1=s*s;
a1a=sa*sa;

a2=l*l;

a3=2*s;
a3a=2*sa;

a4=a1+a2;
a4a=a1a+a2;

taperrad = a4 / a3;
taperrada= a4a/a3a;

////

for (i=[1:quantity_of_internal_braces]) {rotate([0,0,i*360/quantity_of_internal_braces]){brace();}}

module blockout(){
translate([-5000,-2500]){square([5000,5000]);}}



//blockout();

module bracetopblock(){
    translate([tip_radius-mounting_lip_width,length-mounting_lip_width]){
        square([mounting_lip_width,mounting_lip_width]);}
    }
//bracetopblock();
    
module fe_endsolid(){
    translate([0,length-mounting_lip_width]){
        square([tip_radius+.25,mounting_lip_width]);
        };
    }
//fe_endsolid();

    
module fe_basesolid(){
        translate([0,mounting_lip_width]){
            square([base_radius,skin_thickness]);}
        square([base_radius-skin_thickness-.25,mounting_lip_width]);
        }
    
    
//fe_basesolid();

    
module ccvconesolid(){
    difference(){translate([0,edge]){square([tip_radius,length-edge]);}
        mirror([0,1])
    difference(){
        translate([taperrada+base_radius,-edge]){
            circle(r=taperrada,$fn=120);
            }
        translate([base_radius-edge,-edge]){
            square([taperrada*3,taperrada*3]);
            }
        translate([tip_radius,-taperrada-length]){
            square([taperrada*2,length*5]);
            }
        };
        }
    }
            
       
    
//ccvconesolid();

    
module cvxconesolid(){
            difference(){
                translate([-taperrad+base_radius,edge]){circle(r=taperrad,$fn=120);};
                translate ([-2500,length]){square([5000,5000]);};
                translate ([-2500,-5000+mounting_lip_width]){square([5000,5000]);};
                translate ([-5000,-taperrad*2+mounting_lip_width]){square([5000,5000]);};
            }
        };
    
//cvxconesolid();

            
module skin_profilesolid(){union(){
            fe_basesolid();
            fe_endsolid();
            if (base_radius>tip_radius)cvxconesolid(); else if(base_radius<tip_radius) ccvconesolid();}
        
  }  
//skin_profilesolid();
  
module bsil(){difference(){
        skin_profilesolid();
        skin_profilehollow(-mounting_lip_width);
            }
            
        }

//bsil();
       
module brace(){rotate([90,0,0]){
    translate([-skin_thickness/2,0,-skin_thickness/2]){linear_extrude(height=1){flatbrace();};}
    }
    }

//brace();
    
module flatbrace(){
    difference(){
        rawflatbrace();
        translate([skin_thickness,0]){
            blockout();
            }
        }
    }
//flatbrace();
    
module rawflatbrace(){
difference(){
    difference(){bsil();
          translate([-mounting_lip_width,0]){bsil();}}
         bracetopblock(); }}
//rawflatbrace();
  
module skin_profilehollow(thick){
        translate([thick,0]){
            skin_profilesolid();
            }
        }
//skin_profilehollow(-skin_thickness);

module rawskin_profile(){
    top_flange();
    bottom_flange();
    fixerflange();
    difference(){
        skin_profilesolid();
        skin_profilehollow(-skin_thickness);}
        
            
        }
        


//rawskin_profile();
        
module skin_profile(){
    difference(){
        rawskin_profile();
        blockout();}}
//skin_profile(); 

module flange(){
    square([edge,skin_thickness]);
    }     
//flange();
    
module fixerflange(){
    translate([base_radius-skin_thickness*2-.25,mounting_lip_width]){square([skin_thickness+.25,skin_thickness]);}
    }
         
//fixerflange();
    
module top_flange(){
    translate([tip_radius-skin_thickness*1.5-mounting_lip_width,length-mounting_lip_width-skin_thickness]){flange();}
}
//top_flange(); 

module bottom_flange(){
    translate([base_radius-edge-skin_thickness-.25,0]){flange();}
}
//bottom_flange(); 

module nc_skin3d(){
    rotate_extrude()skin_profile();
    }
//nc_skin3d();
    
module fuse_part(){
    nc_skin3d();
    brace();
    }
fuse_part();

module rocketpart(){
translate([40,0,0]){
    fuse_part();
    translate([0,0,length-mounting_lip_width]){
        fuse_part();
        }
    }
}
   
//rocketpart();

