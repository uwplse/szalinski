//Copyright Mateo Carreras 2016. All rights reserved.
//
//PokeyOne's Hexagonal Connectors

//customize these:

//height of block DEFAULT=15
height = 15; 
//space between male and female connector ends DEFAULT=1
gap = 1; 
//scale of the model DEFAULT=1
pieceScale = 1; 

piece();

module piece(){
    //Don't touch unless you know what you're doing
    //DEFAULT=3 NOTE="must be multiple of 3, and odd"
    sides = 3; 
    //Don't touch unless you know what you're doing
    //totalSides
    totalSides = sides*2;
    //Don't touch unless you know what you're doing
    //size of connectors DEFAULT=12.5
    connectorRadius = 12.5; 
    //Don't touch unless you know what you're doing
    //size of block DEFAULT=50
    pieceRadius = 50; 

    scale(pieceScale){
        difference(){
            cylinder(h=height, r=pieceRadius, center=false, $fn=totalSides);
            for(i = [0 : sides-1]) {
                rotate([0, 0, (360/sides)*i]){
                    translate([0, -1*pieceRadius+connectorRadius, 0]){
                        cylinder(h=height*2.5, r=connectorRadius+gap, center=true, $fn=4);
                    }
                }
            }
        }

        for(i = [0 : sides-1]) {
            rotate([0, 0, (360/sides)*i]){
                translate([0, pieceRadius, 0]){
                    cylinder(h=height, r=connectorRadius, center=false, $fn=4);
                }
            }
        }
    }
}