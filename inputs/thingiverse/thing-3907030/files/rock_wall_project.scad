//Customizer assignment, dlbrinks
//Some code used from "Bolt for MTU-777 Rock Wall Assignment", see https://www.thingiverse.com/thing:481050
//Licensed under the Creative Commons - Attribution - Share Alike license

//Bolt head diamter with clearance for tool
B=25;

// Bolt head height
h=9;
//[5:50]

// Bolt overall length
l=69.5;
//[65:0.5:100]

// Bolt diameter
d=11;
//[10,11,12,13,14,15]

$fn=100;

// How tall should the cup be?
cuphieght=96;
//[50:500]                    

// What should the cup radius be?                    
cupradius=40;
//[10:250]

//Bolt inlay - use to align bolt hole with model after rotation:
boltinlay = -48;
//[-60:0]

//Upper handle radius
    topr=20;
    //[15:50]
    
    //Bottom handle radius
    bottomr=20;
    //[15:50]
    
        //How tall would you like your handle?
    handlehieght=42;
    //[30:400]
    
    //Handle "Z" adjust - modify handle height:
    handlezadj=9;
    //[0:50]

module bolt(){
union(){
		translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
		cylinder(h=l, r=d/2); // bolt shaft
		}
					}



                    
module cup(){
//cuphieght=96;
//cupradius=40;
wall=3.2;
    
    
    //subtract a smaller cylinder from a larger one, form cup
    //fill the inside with translate +z to make strong climb hold
difference(){cylinder(h=cuphieght,r=cupradius,center = true);
    translate([0,0,cuphieght-25])cylinder(h=cuphieght-3,r=cupradius-wall, center = true);
    }
translate([0,cupradius,cuphieght/8])handle();
}


difference(){
difference(){
translate([0,-10,-11])rotate([99,76,0])cup();
    translate([-150,-150,-300])cube([300,300,300], center=false);
}
translate([0,0,boltinlay])bolt();
}
//handle
module handle(){
    //params
    
    
    
    offset=0;
    handlewidth=3.2;

    
    //Slice out a section of 2 spheres, hulled together
    intersection(){
        difference(){
        translate([0,0,handlezadj])hull(){
            sphere(r=topr);
            translate([offset,0,-1*(handlehieght)])sphere(r=bottomr);
        };
        translate([0,0,handlezadj])hull(){
            sphere(r=topr-handlewidth);
            translate([offset,0,-1*(handlehieght)])sphere(r=bottomr-handlewidth);
        };
    }
translate([0,topr/2,-1*(topr-2.5)])cube(size = [10, topr, handlehieght*3], center = true);
}
}
