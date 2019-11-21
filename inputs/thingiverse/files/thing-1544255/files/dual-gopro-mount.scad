// minimum 15 for positive connector angles, minimum 40 for negative connector angles
BeamWidth = 40;
// degrees
Connector1Angle = 45;
// degrees
Connector2Angle = 45;
NutDiameter = 8;
NutType = "hexagonal"; //[hexagonal, pentagonal, square, none]




module makeMount(){
    $fn = 90;
    
    slotSize = 3;
    width=slotSize * 5;
    holeSize = 5;
    
    difference(){
        union(){
            makeBeam(slotSize, holeSize);
            translate([BeamWidth / 2, 0, 0]) rotate([0, 0, Connector1Angle]) makeConnector(slotSize, holeSize, "3tab");
            translate([-BeamWidth / 2, 0, 0]) rotate([0, 0, -Connector2Angle + 180]) makeConnector(slotSize, holeSize, "3tab");
        }
        for(i = [0:2:5]){
            hull(){
                translate([0, 0, slotSize * i]) cylinder(h = slotSize, d = width + 1);
                translate([12 , -width / 2 - 0.5, slotSize * i]) cylinder(h = slotSize, d = 1);
                translate([-12, -width / 2 - 0.5, slotSize * i]) cylinder(h = slotSize, d = 1);
            }
        }
        cylinder(h = width, d = holeSize);
    }
}

module makeConnector(slotSize, holeSize, type = "3tab"){

    width = slotSize * 5;
    union(){
        difference(){
            hull(){
                cylinder(h = width, d = width);
                translate([width + 1, 0, 0]) cylinder(h = width, d = width);
            }
            if(type == "3tab"){
                for(i = [1:2:3]){
                    translate([width / 2 , -width / 2, slotSize * i]) cube([width + 1, width, slotSize]);
                }
            }  else if(type == "2tab"){
                for(i = [0:2:5]){
                    translate([width / 2 , -width / 2, slotSize * i]) cube([width + 1, width, slotSize]);
                }
            }
            translate([width + 1, 0, 0]) cylinder(h = width, d = holeSize);
        }
        
        makeNutHolder(slotSize, holeSize);
    }
}

module makeNutHolder(slotSize, holeSize){
    
    width = slotSize * 5;
    d1 = 14.5;
    d2 = 10.5;
    
    if(NutType == "hexagonal"){
        difference(){
            $fn = 6;
            translate([width + 1, 0, slotSize * 5]) cylinder(h = slotSize, d1 = d1, d2 = d2);
            translate([width + 1, 0, slotSize * 5]) cylinder(h = width, d = NutDiameter);
        }
    } else if(NutType == "pentagonal"){
        difference(){
            $fn = 5;
            translate([width + 1, 0, slotSize * 5]) cylinder(h = slotSize, d1 = d1, d2 = d2);
            translate([width + 1, 0, slotSize * 5]) cylinder(h = width, d = NutDiameter);
        }
    } else if(NutType == "square"){
        difference(){
            $fn = 4;
            translate([width + 1, 0, slotSize * 5]) cylinder(h = slotSize, d1 = d1, d2 = d2);
            translate([width + 1, 0, slotSize * 5]) cylinder(h = width, d = NutDiameter);
        }
    }
}

module makeBeam(slotSize, holeSize){
    width = slotSize * 5;

        hull(){
            translate([-BeamWidth / 2, 0, 0]) cylinder(h = width, d = width);
            translate([BeamWidth / 2, 0, 0]) cylinder(h = width, d = width);
        }
}

makeMount(BeamWidth);