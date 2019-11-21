//number of records
records=1;

for(i=[0:1:records-1])
{
    translate([0,25*i,0])    difference(){
difference(){
    $fn=100;
rotate([90,0,0])cylinder(38.1+10,114.3/1.85,114.3/1.85,center=true);
translate([0,0,-314.3/2-10])rotate([90,0,0])cube([314.3*2+50,314.3+20,314.3],center=true);
}
translate([0,0,114.3+60])rotate([-90,0,0])cube([314.3,314.3,3.5], center=true);
}
}