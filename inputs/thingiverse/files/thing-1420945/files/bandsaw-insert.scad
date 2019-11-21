thick=3; //thickness of plate to table
topdia=63; //diameter of plate

edge=2; //thickness of bottom edge
botdia=56; //diameter of the bottom edge

key=2.8; //diameter of bump for key

blade=1; //width of the blade metal

cutx=6.4; //width of cutaway for turning of blade
cuty=18; //depth of cutaway
offset=0; //offset direction of cutaway for blade
res=60;

difference(){
difference(){
union(){
cylinder(thick, d=topdia, $fn=res);
translate([0,0,thick]) cylinder(edge, d=botdia, $fn=res);
translate([(topdia/2),0,0]) cylinder(thick, d=key, $fn=res);
}
translate ([0,topdia/4, (thick+edge)/2]) cube(size=[blade, topdia/2, thick+edge], center=true);
}
translate ([-cutx/2,-offset/2,0]) cube(size=[cutx,cuty,thick+edge], center=false);
}