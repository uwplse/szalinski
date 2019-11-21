Height=15;
Armlength=5;

translate([40,-0.25,-32])difference(){
translate([-50,27,12.5])cube([10,20,35]);
translate([-50,41,10])cube([10,8,35]);
translate([-50,25.5,10])cube([10,8,35]);
translate([-50,35.5,25])cube([10,3.5,35]);
translate([-50,41.3,25])cube([5,3.5,20]);
translate([-50,45,30])cube([15,3.5,20]);
translate([-50,26,30])cube([15,3.5,20]);
translate([-54.3,28,10])cube([5,20,53]);
rotate([0,20,90])translate([20,35.5,58])cube([20,20,20]);
rotate([0,70,90])translate([-52.5,35.5,35])cube([20,20,20]);
translate([-55,11,30])cube([20,20,20]);
translate([-55,43.5,30])cube([20,20,20]);
translate([-50,27,2])cube([20,20,20]);
}


translate([-9.3,40,-.7])cube([9.2,5,5.5]);
translate([-9.3,29,-.7])cube([9.2,5,5.5]);
translate([-9.3,32.6,4])cube([9.2,.7,10]);
translate([-9.3,40.6,4])cube([9.2,.7,10]);

translate([-9.3,40,Height*-1+10])cube([Armlength+10,5,3]);
translate([-9.3,29,Height*-1+10])cube([Armlength+10,5,3]);
