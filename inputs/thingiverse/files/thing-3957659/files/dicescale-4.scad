l=140;
w=140;
h=140;
scale([.25,.25,.25])
difference()
{
   translate([0,0,h/2])
    cube([l,w,h], center=true);
            
translate ([0,0,h])
//1 Side
cylinder (h=30, r1=15, r2=15, center = true);
 
//6 side   
translate ([-l/4,0,0])
cylinder (h=30, r1=15, r2=15, center = true);
    
translate ([-l/4,w/4,0])
cylinder (h=30, r1=15, r2=15, center = true);

translate ([-l/4,-w/4,0])
cylinder (h=30, r1=15, r2=15, center = true);
    
translate ([l/4,0,0])
cylinder (h=30, r1=15, r2=15, center = true);
    
translate ([l/4,w/4,0])
cylinder (h=30, r1=15, r2=15, center = true);

translate ([l/4,-w/4,0])
cylinder (h=30, r1=15, r2=15, center = true);

//2 Side
rotate([0,90,0])
translate ([-l/4,-w/4,h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([0,90,0])
translate ([-l/1.333,w/4,h/2])
cylinder (h=30, r1=15, r2=15, center = true);

//5 Side
rotate([0,90,0])
translate ([-l/1.333,w/4,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([0,90,0])
translate ([-l/1.333,-w/4,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([0,90,0])
translate ([-l/4,-w/4,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([0,90,0])
translate ([-l/4,w/4,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([0,90,0])
translate ([-l/2,0,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);
//4 side
rotate([90,0,0])
translate ([-l/4,w/4,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([90,0,0])
translate ([-l/4,w/1.333,-h/2])
cylinder (h=20, r1=15, r2=15, center = true);

rotate([90,0,0])
translate ([l/4,w/1.333,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([90,0,0])
translate ([l/4,w/4,-h/2])
cylinder (h=30, r1=15, r2=15, center = true);
//3 Side
rotate([90,0,0])
translate ([-l/4,w/4,h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([90,0,0])
translate ([l/4,w/1.333,h/2])
cylinder (h=30, r1=15, r2=15, center = true);

rotate([90,0,0])
translate ([0,w/2,h/2])
cylinder (h=30, r1=15, r2=15, center = true);
            
} 
    
