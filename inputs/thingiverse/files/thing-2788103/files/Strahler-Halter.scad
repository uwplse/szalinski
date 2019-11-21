$fn=200;

breite=93;
hoehe=64-3-(24/2);
tiefe=24-6;
dicke=6;

difference()
{
    cube([breite+dicke, hoehe+dicke, tiefe+dicke]);
    translate([dicke/2,dicke/2,dicke/2-5])
    cube([breite, hoehe+10, tiefe+10]);
    
    translate([0,hoehe+dicke,tiefe/2+dicke/2])
    rotate([0,90,0])
    linear_extrude(dicke/2)
    circle(3);
    
    translate([breite+dicke/2,hoehe+dicke,tiefe/2+dicke/2])
    rotate([0,90,0])
    linear_extrude(dicke/2)
    circle(3);
    
    translate([breite/2+dicke/2,5,tiefe/2+dicke/2])
    rotate([90,90,0])
    linear_extrude(10)
    circle(3);

}


difference()
{
    linear_extrude(tiefe+dicke)
    circle(10);
    rotate(90)
    cube([10,10,tiefe+dicke]);
    rotate(180)
    cube([10,10,tiefe+dicke]);
    rotate(270)
    cube([10,10,tiefe+dicke]);
}

difference()
{
    translate([breite+dicke,0,0])
    linear_extrude(tiefe+dicke)
    circle(10);
    translate([breite+dicke,0,0])
    rotate(270)
    cube([10,10,tiefe+dicke]);
    translate([breite+dicke,0,0])
    rotate(180)
    cube([10,10,tiefe+dicke]);
    translate([breite+dicke,0,0])
    rotate(0)
    cube([10,10,tiefe+dicke]);
}

difference()
{
    translate([0,hoehe+dicke,tiefe/2+dicke/2])
    rotate([0,90,0])
    linear_extrude(dicke/2)
    circle(tiefe/2+dicke/2);

    translate([0,hoehe+dicke,tiefe/2+dicke/2])
    rotate([0,90,0])
    linear_extrude(dicke/2)
    circle(3);
}

difference()
{
    translate([breite+dicke/2,hoehe+dicke,tiefe/2+dicke/2])
    rotate([0,90,0])
    linear_extrude(dicke/2)
    circle(tiefe/2+dicke/2);

    translate([breite+dicke/2,hoehe+dicke,tiefe/2+dicke/2])
    rotate([0,90,0])
    linear_extrude(dicke/2)
    circle(3);
}