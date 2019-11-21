diameter=140;
thickness=8;
bolt=6;
picavet_all();

module picavet()
{
    color([0,1,0]);
    color([0,1,0]) cube([diameter,thickness,thickness],center=true);
    rotate([0,0,90]) color([0,1,0]) cube([diameter,thickness,thickness],center=true);
    color([0,0,1]) cylinder(d=thickness*2+bolt,h=thickness,center=true);
        
   translate([-0.42*diameter,-3,thickness/2]) text("PICAVET",size=6,center=true);
    translate([12,-2,thickness/2]) text("www.mechanicape.nl",size=4,center=true);
    
}

module haakje()
{
    color([1,0,0]) cylinder(d=thickness/2,h=thickness*2,center=true);
}

module haakjes_all()
{
    distance_haakje_center=diameter/2-thickness/2;
    translate([1* distance_haakje_center,0,0]) haakje();
    translate([-1* distance_haakje_center,0,0]) haakje();
    translate([0,1* distance_haakje_center,0]) haakje();
    translate([0,-1* distance_haakje_center,0]) haakje();
}


module picavet_all()
{
    difference()
    {
        rotate([0,0,45]) picavet();
        rotate([0,0,45]) haakjes_all();
        cylinder(d=bolt+1,h=thickness+2,center=true);
    }
}

