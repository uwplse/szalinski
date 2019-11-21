heightpump=16;
radiusoutcyl=20; /*era 25*/
radiushole=17;
heightscrewcube=20;
widthscrewcube=22;
screwdistancefromborder=4;
tuberadius=2.3;
tubeposition=3.2;
skirtthickness=3;
skirtradius=radiushole-2;
screwradius=1.65;
separazione=-10;
enterangle=35;


translate([separazione,0,0]) rotate([180,0,0]) difference(){
union(){
cylinder(h=heightpump,r=radiusoutcyl,center=true,$fn=100);
    
/*nel translate dei due cubi successivi al posto di 25 era radiusoutcyl*/ 
color ("blue") translate ([0,25,0]) cube([heightscrewcube,widthscrewcube,heightpump],true); 
color ("blue") translate ([0,-25,0]) cube([heightscrewcube,widthscrewcube,heightpump],true);
}
 color("cyan") cylinder(h=heightpump*2,r=skirtradius,center=true,$fn=100);
translate([0,0,-skirtthickness]) color("red") cylinder(h=heightpump,r=radiushole,center=true,$fn=100);
translate([0,radiusoutcyl+widthscrewcube/2-screwdistancefromborder,0]) rotate([0,90,0]) cylinder(h=heightscrewcube+10,r=screwradius,$fn=30,center=true);
translate([0,-(radiusoutcyl+(widthscrewcube/2-screwdistancefromborder)),0]) rotate([0,90,0]) cylinder(h=heightscrewcube+10,r=screwradius,$fn=30,center=true);
translate([radiusoutcyl/2,0,0]) cube([radiusoutcyl,radiusoutcyl*2+heightscrewcube+20,heightpump+20],center=true);

/*5mm di rientranza*/
translate([0,35,0]) cube([6,30,heightpump],true);
translate([0,-35,0]) cube([6,30,heightpump],true);



}



