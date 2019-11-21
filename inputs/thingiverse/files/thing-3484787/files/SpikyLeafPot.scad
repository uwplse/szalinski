// Spiky Leaf Pot by @Chompworks
// Original at: https://www.thingiverse.com/thing:3484787
// Released under the Creative Commons CC - BY 3.0 licence
// Details here: https://creativecommons.org/licenses/by/3.0/


$fn=360;
//Diameter of the Vase
diameter=60; //millimeters
//Height of the Vase
height=100; //millimeters
//Number of Spikes to create around the circumference per each layer
spikes_per_layer=5; //[2:20]
//Number of spikes to create within the height
spikes_in_height=10;//[5:20]

//randomly offset the spikes. 0 for uniform alignment
random_offset=0; //[0,2,4,6,8,10]

//Thickness of the base in non-vase mode prints
base_thickness=10;
//how defined the spikes are from the body. 
taper_ratio=0.7; //[0.5,0.6,0.7,0.8,0.9,1]
leaf_thickness=3;

//Minimum wall thickness. 
wall_thickness=1;


    
difference(){
    intersection(){ 
        union(){
            difference(){
                cylinder(d=(diameter*taper_ratio)+leaf_thickness,h=height);
                cylinder(d=(diameter*taper_ratio)-leaf_thickness,h=height);
            }
            intersection(){
            translate([0,0,height/spikes_in_height])
            for(spikes=[1:spikes_per_layer]){
                rotate([0,0,(spikes*360/spikes_per_layer)+rands(-random_offset,random_offset,1)[0]+(180/spikes_per_layer)])
                    scale([1,1,4])
                intersection(){
                    scale([diameter,diameter/sqrt(2*pow(height/spikes_in_height,2)),1]) rotate([-135,0,0]) cube(size=height/spikes_in_height);
                    translate([0,0,-10]) cylinder(d1=diameter*taper_ratio,d2=diameter,h=height/spikes_in_height);
                }
            }
            cylinder(d=2*diameter,h=3);
        }


            for(layers=[1:spikes_in_height+1]){
                translate([0,0,layers*height/spikes_in_height])
                for(spikes=[1:spikes_per_layer]){
                    rotate([0,0,(spikes*360/spikes_per_layer)+rands(-random_offset,random_offset,1)[0]+layers%2*180/spikes_per_layer])
                    scale([1,1,4])
                    intersection() {
                        scale([diameter,diameter/sqrt(2*pow(height/spikes_in_height,2)),1]) rotate([-135,0,0]) cube(size=height/spikes_in_height);
                        difference(){
                            translate([0,0,-height/spikes_in_height]) cylinder(d1=diameter*taper_ratio,d2=diameter,h=height/spikes_in_height);
                            translate([0,0,-height/spikes_in_height]) cylinder(d1=(diameter*taper_ratio)-leaf_thickness,d2=diameter-leaf_thickness,h=height/spikes_in_height);
                        }
                        
                    
                    }
                }
            }
        }
        cylinder(d=2*diameter,h=height);
    }        
    if (wall_thickness>0) translate([0,0,base_thickness]) cylinder(d=max(diameter*taper_ratio-wall_thickness,0),h=height);
}    
        




