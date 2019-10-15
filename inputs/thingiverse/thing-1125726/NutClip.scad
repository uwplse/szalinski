ScrewDiameter = 10;
Thikness = 1.5;

/* [HIDDEN] */
$fn = 50;

clip();

module clip(){
    difference(){
        cylinderHole(ScrewDiameter/2,Thikness);        
        translate([ScrewDiameter/4,-ScrewDiameter/4,-0.25]) 
            cube([ScrewDiameter*1.5,ScrewDiameter/2,Thikness+0.5]);
        
    }
    translate([ScrewDiameter/2+Thikness*0.35,ScrewDiameter*0.75+Thikness,0])
        rotate([0,0,-95])
            quarterCylinder();
    rotate([180,0,0])    
        translate([ScrewDiameter/2+Thikness*0.35,ScrewDiameter*0.75+Thikness,-Thikness])
            rotate([0,0,-95])
                quarterCylinder();
}

module cylinderHole(external, thickness){
    difference(){
        cylinder(r=external+thickness,h=thickness);
        translate([0,0,-0.25]) 
            cylinder(r=external,h=thickness+0.5);
    }
}
module quarterCylinder(external=ScrewDiameter/2,thickness=Thikness){
    intersection(){
        cylinderHole(external,thickness);
        translate([0,0,-0.5]) cube([external*2,external*2,thickness+1]);
    }    
}