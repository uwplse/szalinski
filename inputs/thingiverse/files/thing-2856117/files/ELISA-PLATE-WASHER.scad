difference()
{
union()
    {
translate([0,0,-4])//change -18 to -10 to put fluidics in middle
cube([110,40,10], center=T); 
rotate([270,0,0])translate([4.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([13.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([22.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([31.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([40.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([49.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([58.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([67.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([76.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([85.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([94.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([270,0,0])translate([103.75,-1,45]) cylinder(h = 20, r1 = 5, r2 = 2, center = true);
rotate([0,00,90])translate([25,-104,20]) cylinder(h = 40, r1 = 6, r2 = 4, center = true);

translate([110,0,0])cube([0,40,6], center=T);  

        }
//add fluidics longwise
//trans [x,y,x]
translate([4,32,0]) cube([100,1.5,1.5], center=T); 
translate([13,30.5,0]) cube([100,3,1.5], center=T); 
translate([22,29,0]) cube([100,4.5,1.5], center=T); 
translate([31,27.5,0]) cube([100,6,1.5], center=T); 
translate([40,26,0]) cube([100,7.5,1.5], center=T); 
translate([49,24.5,0]) cube([100,6,1.5], center=T); 
translate([58,23,0]) cube([100,6,1.5], center=T); 
translate([67,21.5,0]) cube([100,6,1.5], center=T); 
translate([76,20,0]) cube([100,6,1.5], center=T); 
translate([85,18.5,0]) cube([100,6,1.5], center=T); 
translate([94,17,0]) cube([100,6,1.5], center=T); 
translate([103,15.5,0]) cube([100,6,1.5], center=T); 



//add fluidics shortwise
//trans [x,y,x]
translate([103,32,0]) cube([1.5,50,1.5], center=T); 
translate([94,32,0]) cube([1.5,50,1.5], center=T); 
translate([85,32,0]) cube([1.5,50,1.5], center=T); 
translate([76,32,0]) cube([1.5,50,1.5], center=T); 
translate([67,32,0]) cube([1.5,50,1.5], center=T); 
translate([58,32,0]) cube([1.5,50,1.5], center=T); 
translate([49,32,0]) cube([1.5,50,1.5], center=T); 
translate([40,32,0]) cube([1.5,50,1.5], center=T); 
translate([31,32,0]) cube([1.5,50,1.5], center=T); 
translate([22,32,0]) cube([1.5,50,1.5], center=T); 
translate([13,32,0]) cube([1.5,50,1.5], center=T); 
translate([4,32,0]) cube([1.5,50,1.5], center=T); 

//put a hole in nozzle
rotate([0,00,90])translate([25,-104,20]) cylinder(h = 40, r1 = 4, r2 = 2, center = true);

}
translate([109,0,-4])cube([1,40,8], center=T);  
