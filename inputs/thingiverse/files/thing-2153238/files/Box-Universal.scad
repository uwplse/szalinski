x=100;
y=100;
z=30;
wall=1.5;
bottom=2;
cornerdia=5;
gradient=1;
difference()
{    hull(){
        translate([(cornerdia/2)+gradient,(cornerdia/2)+gradient,0]) cylinder(d=cornerdia, h=1);
        translate([(cornerdia/2)+gradient,y-(cornerdia/2)-gradient,0]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2)-gradient,(cornerdia/2)+gradient,0]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2)-gradient,y-(cornerdia/2)-gradient,0]) cylinder(d=cornerdia, h=1);

        translate([(cornerdia/2),(cornerdia/2),z-1]) cylinder(d=cornerdia, h=1);
        translate([(cornerdia/2),y-(cornerdia/2),z-1]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2),(cornerdia/2),z-1]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2),y-(cornerdia/2),z-1]) cylinder(d=cornerdia, h=1);
    }
    hull(){
        translate([(cornerdia/2)+gradient+wall,(cornerdia/2)+gradient+wall,bottom]) cylinder(d=cornerdia, h=1);
        translate([(cornerdia/2)+gradient+wall,y-(cornerdia/2)-gradient-wall,bottom]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2)-gradient-wall,(cornerdia/2)+gradient+wall,bottom]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2)-gradient-wall,y-(cornerdia/2)-gradient-wall,bottom]) cylinder(d=cornerdia, h=1);

        translate([(cornerdia/2)+wall,(cornerdia/2)+wall,z-1+bottom]) cylinder(d=cornerdia, h=1);
        translate([(cornerdia/2)+wall,y-(cornerdia/2)-wall,z-1+bottom]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2)-wall,(cornerdia/2)+wall,z-1+bottom]) cylinder(d=cornerdia, h=1);
        translate([x-(cornerdia/2)-wall,y-(cornerdia/2)-wall,z-1+bottom]) cylinder(d=cornerdia, h=1);
     }
 }