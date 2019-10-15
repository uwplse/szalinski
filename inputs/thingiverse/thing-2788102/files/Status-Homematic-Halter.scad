breite=109;
hoehe=100;
tiefe=15;
dicke=5;

difference()
{
    cube([breite+dicke, hoehe+dicke, tiefe+dicke]);
    translate([dicke/2,dicke/2,dicke/2])
    cube([breite, hoehe+10, tiefe]);
    translate([dicke/2+12,dicke/2,dicke/2-10])
    cube([breite-24, hoehe+10, tiefe+10]);
    translate([dicke/2+11,dicke/2+11,dicke/2])
    cube([breite-22, hoehe+10, tiefe+10]);
}