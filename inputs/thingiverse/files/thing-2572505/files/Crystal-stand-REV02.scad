/*

Random crystal generator for Thingiverse Customizer

Fernando Jerez 2016

*/

// This is only to force Customizer create many files. Changes doesn´t matter. Just click CREATE THING
part = "two"; // [one:Crystal #1, two:Crystal #2, three:Crystal #3, four:Crystal #4,five:Crystal #5,six:Crystal #6,seven:Crystal #7,eight:Crystal #8,nine:Crystal #9,ten:Crystal #10]

//Customizer Variables
offset=8; // How big should the distribution of crystals be

large_crystals=8; // Number of Large Crystals
large_sides=5;
medium_crystals=32; //
medium_sides=4;
small_crystals=64; //
small_sides=7;

angleX = 35; // Angle range X axis
angleY = 35;

base_radius=30; // Size of the base

crystalrock();
 

;

module crystalrock(){
    union(){
        //Large Crystals
        for(i=[1:large_crystals]){
            g1=rands(-angleX,angleX,1)[0];
            g2=rands(-angleY,angleY,1)[0];
        
            sides=large_sides;//round(rands(4,8,1)[0]);
            radius1=rands(1.5,2.1,1)[0];
            radius2=rands(1.1,2.1,1)[0]*radius1;
            radius3=rands(0,0.5,1)[0]*radius2;
            height=radius1*rands(1,2,1)[0]*5*(0.5+pow((abs(cos(g1)*cos(g2))),4));
            peak=rands(0.1,0.4,1)[0]*height;    
        
            rotate([0,0,rands(-180,180,1)[0]])translate([rands(0,offset,1)[0],0,3])
            rotate([g1,g2,0])
            crystal(sides,radius1,radius2,radius3,height,peak);
        }
        //Medium Crystals
        for(i=[1:medium_crystals]){
            g1=rands(-angleX,angleX,1)[0];
            g2=rands(-angleY,angleY,1)[0];
        
            sides=medium_sides;//round(rands(4,8,1)[0]);
            radius1=rands(1,2,1)[0];
            radius2=rands(1.1,1.6,1)[0]*radius1;
            radius3=rands(0,0.5,1)[0]*radius2;
            height=radius1*rands(1,2,1)[0]*5*(0.5+pow((abs(cos(g1)*cos(g2))),4));
            peak=rands(0.1,0.4,1)[0]*height;    
        
            rotate([0,0,rands(-180,180,1)[0]])translate([rands(0,offset*1.5,1)[0],0,3])
            rotate([g1,g2,0])
            crystal(sides,radius1,radius2,radius3,height,peak);
        }
        //Small Crystals
        for(i=[1:small_crystals]){
            g1=rands(-angleX,angleX,1)[0];
            g2=rands(-angleY,angleY,1)[0];
        
            sides=small_sides;//round(rands(4,8,1)[0]);
            radius1=rands(.75,1.5,1)[0];
            radius2=rands(.85,1.6,1)[0]*radius1;
            radius3=rands(0,0.5,1)[0]*radius2;
            height=radius1*rands(1,2,1)[0]*5*(0.5+pow((abs(cos(g1)*cos(g2))),4));
            peak=rands(0.1,0.4,1)[0]*height;    
        
            rotate([0,0,rands(-180,180,1)[0]])translate([rands(0,offset*2,1)[0],0,3])
            rotate([g1,g2,0])
            crystal(sides,radius1,radius2,radius3,height,peak);
        }
        //Base
        semisphere(base_radius,$fn=50);
    }
}




module crystal(sides,radius1,radius2,radius3,height,peak){
    cylinder(r1=radius1,r2=radius2,h=height,$fn=sides);
    translate([0,0,(height)]) cylinder(r1=radius2,r2=radius3,h=peak,$fn=sides);
    
}

module semisphere(r){
    difference(){
        translate([0,0,-r*.75]) sphere(r);  
        translate([0,0,-r-1]) cube([2*r,2*r,2*r],center = true);
    }
}
