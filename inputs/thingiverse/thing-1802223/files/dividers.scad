include <MCAD/boxes.scad>
// Base Height
base_height=2;

//Base Width
base_width=49.75;

//Base Length
base_length=110.25;

//Divider Height
div_height=18;

// Cutout Height
cut_height=5;

// Cutout Width
cut_width=8;

//Number of sections
sections=4;

/* [Hidden] */
dividers=sections-1;

//base

difference(){
    roundedBox([base_width, base_length, base_height*3], base_height, false, $fn=100);
   
    translate([0,0,base_height]){   roundedBox([base_width+2*base_height,base_length+.1,base_height*3],base_height,false,$fn=100);
    }
}

//dividers

for (count=[1:dividers]){
    translate([0,-count*(base_length/sections)+base_length/2,0]){
        divider(div_height,base_height,cut_width,cut_height);
    }
}

module divider(total_height,width,cutout_width,cutout_height){
    height=total_height-(base_height/2);
    difference(){ 
        union(){ 
            difference(){
                //central block
                translate([-base_width/2,-width-base_height/2,-base_height/2]){
                    cube([base_width,width+base_height*2,total_height]);
                }
                translate([0,width+base_height/2,height/2+base_height/4]){
                    roundedBox([base_width+2*base_height,2*base_height,total_height+base_height],base_height,$fn=100);
                }
                translate([0,-width-base_height/2,height/2+base_height/4]){
                     roundedBox([base_width+2*base_height,2*base_height,total_height+base_height],base_height,$fn=100);
                }
            }
            //rounded top
            translate([-(base_width/2),0,total_height-base_height/2]){
                rotate(a=90, v=[0,1,0]){
                    cylinder(h=base_width, r=base_height/2, $fn=100);
                }
            }
        }
        translate([base_width/2-cutout_width,-width/2-1,total_height-cutout_height]){
            cube([cutout_width+1,width+2,cutout_height]);
        }
        translate([-base_width/2-1,-width/2-1,total_height-cutout_height]){
            cube([cutout_width+1,width+2,cutout_height]);
        }  
    }
}  