// Steepness of the DNA helix, (between 30-90 degrees)
 dnangle =50;
 // Number of DNA levels
linknum = 20;
// Radius of the DNA helix
dnarad = 40;
// Number of DNA colors, (anywhere from 1-9)
colornum = 4;

rc1 = 6; cen1 = 0;
wcube = 8; lcube = 40; hcube = 16;

module dnadouble(){
    module dnalink() {
        rotate([0,90,0]) cylinder(dnarad,rc1,rc1,cen1);
        difference()
        {
            rotate([dnangle,0,0])translate([-wcube,-lcube/2,-hcube/2])cube([wcube,lcube,hcube]);
            translate([-wcube-0.5,-lcube*1.5/2,lcube*sin(dnangle)/2-hcube*cos(dnangle)/2])cube([wcube+1,lcube*1.5,lcube*1.5]);
            translate([-wcube-0.5,-lcube*1.5/2,-(lcube*sin(dnangle)/2-hcube*cos(dnangle)/2+lcube*1.5)])cube([wcube+1,lcube*1.5,lcube*1.5]);

        }
    }

translate([dnarad,0,0])rotate([0,0,180])dnalink();
translate([-dnarad,0,0])dnalink();
}
dnacolor = ["yellow","red","blue","white","green","pink","brown","orange","black"];

rotateangle = 2*atan((lcube*sin(dnangle)/2-hcube*cos(dnangle)/2)/(tan(dnangle)*dnarad));

for (i = [1:linknum]) {
    color(dnacolor[(i%colornum)-1])rotate([0,0,-rotateangle*(i-1)])translate([0,0,i*2*(lcube*sin(dnangle)/2-hcube*cos(dnangle)/2)])dnadouble();
}