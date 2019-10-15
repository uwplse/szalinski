//Socket size
L=62.5;
l=58;
h=16;

//Lipo size
lipol=l-2;
lipoL=29;
lipoh=h;

wallThickness=2;

//hole for connectors
secondaryHolel=(L-lipoL-4*wallThickness)/2;

difference(){
    translate([4,0,0])cube([L,l,h]);
    translate([L-wallThickness-secondaryHolel*1.5+1,wallThickness,1])cube([secondaryHolel*1.5,lipol,lipoh]);
    translate([wallThickness+secondaryHolel/2+wallThickness-1,wallThickness,1])cube([lipoL,lipol,lipoh]);
}
