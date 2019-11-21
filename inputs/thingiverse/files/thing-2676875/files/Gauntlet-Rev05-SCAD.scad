// - Screw Diameter (mm) (default=3)
screwsize = 3; //[3,4,5]
// - Major Diameter (mm) (default=82.56)
majordia = 82.56; // [82.56:100]
// - Forearm Diameter (mm) (default=76.2)
forearmdia = 76.2; // [76.2:95]
// - Faceplate Diameter (mm) (default=50)
faceplatedia = 50; // [50:100]
// - Wall Thickness (mm) (default=6.35)
wallthickness = 6.35; // [6.35:10]
// - Arm Length (mm) (default=187)
armlength = 187; // [100:200]
// - Strap Slot Width (mm) (default=25.4)
strapwidth = 25.4; // [12:30]
// - Strap Slot Height (mm) (deafult=6.35)
strapthickness = 6.35; // [4:8]
module faceplate(){
cylinder (h=12.7,r1=faceplatedia/2, r2=majordia/2);
}
module mountingholes (){ 
translate([0,19.05,0]) cylinder(h=50,r1=screwsize/2,r2=screwsize/2); 
translate([-16.50,-9.530,0]) cylinder(h=50,r1=screwsize/2,r2=screwsize/2);
translate([16.50,-9.530,0]) cylinder(h=50,r1=screwsize/2,r2=screwsize/2);
}   
module outerdia(){
translate([0,0,12.7])
cylinder (h=armlength,r1=majordia/2,r2=forearmdia/2);
}
module innerdia (){
translate([0,0,12.7])
cylinder (h=armlength,r1=(majordia/2)-wallthickness,r2=(forearmdia/2)-wallthickness);
}
module armslot(){
translate([0,-80,12.7])
rotate([0,0,45])
cube([75,75,armlength]);
}
module straps (){
translate ([-150,0,armlength/5])
cube ([300,strapthickness,strapwidth]);
translate ([-150,0,armlength-(armlength/5)])
cube ([300,strapthickness,strapwidth]);    
}
difference (){
    faceplate();
    mountingholes();
}
difference(){
    outerdia();
    innerdia();
    armslot();
    straps();
}