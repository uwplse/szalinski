hex=.835; //Inscribed diamter of hex head on bolt
dia=.5; //Bolt diameter
height=.32; //Thickness of the hex head
collar=.125; //Amount around the bolt
res=30;

difference(){
    for(i=[0:6]){
        rotate([0,0,i*360/6])
        translate([hex/2.0,0]) cylinder(d=hex, h=height+collar, $fn=res);
    }
    translate([0,0,collar]) cylinder(d=hex, h=height, $fn=6);
    cylinder(d=dia, h=collar, $fn=res);
}