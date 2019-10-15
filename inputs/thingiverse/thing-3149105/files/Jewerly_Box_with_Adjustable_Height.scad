//adjustable height of the box (box should be taller than 30 mm)
h=80;


union (){
translate([65,7.5,h/2]) cube(size = [100,15,h], center = true);
translate([65,95,5]) cube(size = [100,160,10], center = true);
translate([65,182.5,h/2-5]) cube(size = [100,15,h-10], center = true);
translate([7.5,95,h/2]) cube(size = [15,190,h], center=true);
translate([122.5,95,h/2]) cube(size = [15,190,h], center=true);
translate([113.5,95,h-10.5]) cube(size = [3,160,1], center=true);
translate([16.5,95,h-10.5]) cube(size = [3,160,1], center=true);
}
