//hole
pegL=9.5;
pegW=9.5;
pegH=15.5;
//middle cylinder
mcH=pegH;
mcD=21.5;
//large cylinder
lcH=pegH;
lcD=22.75;
//small cylinder w hole
scH=pegH;
scD=19;
handleH=pegH;
handleD=5.5;
//distance between ends of cylinders
dist=13;
//connection cylinders
conH=dist+(.5*mcD-.5*pegL);
conD=pegH;
res=60;

union(){
difference(){
cylinder(h=mcH, d=mcD, center=true, $fn=res);
cube([pegL,pegW,pegH], center=true);
}

translate([0,(.5*mcD)+(.5*lcD)+dist,0])
cylinder(h=lcH, d=lcD, center=true, $fn=res);

translate([0,(.5*dist+.5*mcD),0])
rotate([90,0,0])
cylinder(h=conH, d=conD, center=true, $fn=res);

translate([0,-(.5*dist+.5*mcD),0])
rotate([90,0,0])
cylinder(h=conH, d=conD, center=true, $fn=res);

translate([0,-((.5*mcD)+(.5*scD)+dist),0])
difference(){
    cylinder(h=scH, d=scD, center=true, $fn=res);
    cylinder(h=handleH, d=handleD, center=true, $fn=res);
}
}