Height=33; //
X=42.3; //
Y=42.3; //

difference() {
        
    cube([50,50,Height],center=true);
    translate([0,0,3])
    cube([X,Y,Height],center=true);
}