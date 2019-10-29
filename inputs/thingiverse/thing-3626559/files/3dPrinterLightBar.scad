//parametric lightbar for LED strips
// 2019 Troseph
// https://www.thingiverse.com/thing:3626559

$fn=50;
// LED specifics
ledl=205;
ledw=8.5;
ledh=2.24;
// baseplate specifics
bpw=16;
bph=2;
// screw specifics
//length of screw
screwh=9;
//diameter of screw
screwd=5.25;
//diameter of screwhead
screwhd=10;
//magic to make the baseplate the right length
bpl=ledl+(screwhd*2.5);

difference(){
  baseplate();
  translate([0,0,1])led();
  screwHoles();
}
module screwHoles(){
  translate([((bpl/2)-6),0,0])cylinder(h=screwh,d=screwd,center=true);
  translate([-((bpl/2)-6),0,0])cylinder(h=screwh,d=screwd,center=true);
  translate([-((bpl/2)-6),0,1])cylinder(h=1,d=screwhd,center=true);
  translate([((bpl/2)-6),0,1])cylinder(h=1,d=screwhd,center=true);
}
module baseplate(){
  cube([bpl,bpw,bph],true);
}
module led(){
  cube([ledl,ledw,ledh],true);
}