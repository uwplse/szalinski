
$fn = 100; 
abstandzwischen=40;//Abstand zwischen Platte und Ring




$fn=60;


difference()  {
     translate([0,0,0]) cube([170,2,24]);
    translate([8.5-0.3,10,7.5]) rotate([90,0,0]) cylinder(d=4,h=20);//Bohrung 
    translate([8.5+153+0.3,10,7.5]) rotate([90,0,0]) cylinder(d=4,h=20);//Bohrung    
}



    translate([0,0,22]) cube([170,15,2]);//Träger oben



    //translate([-34.8,0,0])cylinder(d=1.75,h=50);



//Ring  ###############
translate([170/2,-abstandzwischen,19])
scale([4,0.7,5]){ 
        rotate_extrude(convexity = 10){ 
                translate([10, 0, 0]){circle(r = 1);    
                        } 
         } 
 } 


// Halter nach vorn
 translate([170/2-15,0,21])
 rotate([90,0,0])
 minkowski(){
cube([30,2,abstandzwischen-8.2]);
cylinder(d=2,h=2);//(5, $fn=100) ;
}
