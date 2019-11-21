cone_id=15.4; //inner diameter of the stripping cone. The cone has a cylindrical pathway for the dart exit.
cone_od=35; //the outer diameter of the cone.
cone_length=80; //length of the cone
body_length=90; //length of the large cylindrical shell
body_thickness=2; //thickness of the outer shell. (2*body_thickness)+cone_od= overall diameter of the air stripper
body_neck_length=30; //length of the neck-down reduction cone
body_barrel_grip_length=30; //length of the portion that slips over the barrel
barrel_diam=14.6; //diameter of your barrel. this will vary a little between printers.
port_width=20; // width of the three air ports in the outer shell
port_length=65; // overall length of the ports

union()
{
    cone();
    difference()
        {
            body();
            ports();
        }
}



module ports()
{
    for(i=[0:2])
{rotate([0,0,120*i])
    {
    translate([cone_od/2,0,-(cone_length/3)-port_width])
    {
hull()
{
translate([0,0,-port_length+20])sphere(d=port_width);
sphere(d=port_width);
}
}
}
}
}

//this is the cylindrical 'shell' plus the neck-down reduction, and the part that slips onto the barrel

module body()
{
translate([0,0,-body_length/2])
{
difference()
    {   
        cylinder(h=body_length,d=cone_od+2*body_thickness,center=true);
        cylinder(h=body_length,d=cone_od,center=true);
    }
        
}
translate([0,0,-(body_neck_length/2)-body_length])
{
    difference()
    {   cylinder(h=body_neck_length,d1=barrel_diam+2*body_thickness,d2=cone_od+2*body_thickness,center=true);
        cylinder(h=body_neck_length,d1=barrel_diam,d2=cone_od,center=true);
    }
}
translate([0,0,-(body_barrel_grip_length/2)-body_length-body_neck_length])
{
    difference()
    {   cylinder(h=body_barrel_grip_length,d=barrel_diam+2*body_thickness,center=true);
        cylinder(h=body_barrel_grip_length,d=barrel_diam,center=true);
    }
}
}
module cone()
{
difference()
{
union()
    {
        translate([0,0,-cone_length/6]) cylinder(h=cone_length/3,d=cone_od,center=true);
        translate([0,0,-2*cone_length/3])
        {
            cylinder(h=(2*cone_length/3),d1=cone_id+1,d2=cone_od,center=true);
        }
    }
translate([0,0,-cone_length/2])
    {
        cylinder(h=cone_length,d=cone_id,center=true);
    }
}
}

