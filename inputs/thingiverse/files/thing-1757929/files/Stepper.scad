Height=33; //[5:1:100]
X=42.3; //[5:1:100]
Y=42.3; //[5:1:100]

difference() {
        
    cube([50,50,Height],center=true);
    translate([0,0,3])
    cube([X,Y,Height],center=true);
}