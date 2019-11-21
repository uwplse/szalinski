/*dimensioni base*/
larghezzab=86;
lunghezzab=100;
altezzab=8;
raggioviti=2.7;
heightpump=16;
radiusoutcyl=25;
radiushole=15;
radiusholebig=19;
radiusoutcylbig=30;
heightscrewcube=20;
widthscrewcube=22;
screwdistancefromborder=4;
tuberadius=2.4;
tubeposition=2;
skirtthickness=3;
skirtradius=radiushole-2;
screwradius=1.55;
separazione=-10;
enterangle=35;
altezzarett=22;
larghezzarett=10;


difference(){

 
union(){

translate([radiusoutcylbig-altezzab/2,0,-(lunghezzab/2-heightpump/2)])cube([altezzab,larghezzab,lunghezzab],true);


color("green") cylinder(h=heightpump,r=radiusoutcylbig,center=true,$fn=100);
color ("blue") translate ([0,radiusoutcyl,0]) cube([heightscrewcube,widthscrewcube,heightpump],true);
color ("blue") translate ([0,-radiusoutcyl,0]) cube([heightscrewcube,widthscrewcube,heightpump],true);

translate([11,23,0]) cube([altezzarett,larghezzarett,heightpump],true);
mirror([0,1,0]){
    translate([11,23,0]) cube([altezzarett,larghezzarett,heightpump],true);
    }
}
color("red") cylinder(h=heightpump+10,r=radiusholebig,center=true,$fn=100);
translate([0,radiusoutcyl+widthscrewcube/2-screwdistancefromborder,0]) rotate([0,90,0]) cylinder(h=heightscrewcube+10,r=screwradius,$fn=30,center=true);
translate([0,-(radiusoutcyl+(widthscrewcube/2-screwdistancefromborder)),0]) rotate([0,90,0]) cylinder(h=heightscrewcube+10,r=screwradius,$fn=30,center=true);
translate([-radiusoutcylbig/2,0,0]) cube([radiusoutcylbig,radiusoutcylbig*2+heightscrewcube+20,heightpump+20],center=true);
translate([0,radiusholebig-tuberadius,tubeposition]) rotate([0,90,15]) cylinder(h=radiusholebig*4,r=tuberadius,$fn=30,center=true);
translate([0,-radiusholebig+tuberadius,tubeposition]) rotate([0,90,-15]) cylinder(h=radiusholebig*4,r=tuberadius,$fn=30,center=true);
translate([15.5,15.5,0]) cylinder(h=60,r=1.5,center=true,$fn=20);
translate([15.5,-15.5,0]) cylinder(h=60,r=1.5,center=true,$fn=20);

/*fori per le viti posteriori, distanza dal fondo=4,5cm, raggio foro=2.5, distanza tra i fori 6,6cm */

rotate([0,90,0]) translate([(lunghezzab-heightpump/2-20),15,24]) cylinder(h=12,r=raggioviti,$fn=20,center=true);

mirror([0,1,0]){
rotate([0,90,0]) translate([(lunghezzab-heightpump/2-20),15,radiusoutcylbig-altezzab/2]) #cylinder(h=12,r=raggioviti,$fn=20,center=true);
        }
rotate([0,90,0]) translate([(19.5),-24,24]) cylinder(h=12,r=1.7,$fn=20,center=true);
}


