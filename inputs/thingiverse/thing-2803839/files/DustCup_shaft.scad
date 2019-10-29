//diameter (shaft) [0.1mm]  0 - no hole inside -> use for cap
inner = 55; //[0:60]
    
//diameter (hole in motor body) [0.1mm] 
hole = 92; //[40:150]  
    
//ring [mm]   
outer = 20; //[10:40]   

//ring [0.1mm]
heigh_outer = 15; //[10:40]     

// [0.1mm]
heigh_hole = 25; //[10:40]    

translate([100,100,0])
difference() {
    union(){
        //base ring
        cylinder(heigh_outer/10, d=outer, $fn=50);
        //hole
        cylinder((heigh_outer + heigh_hole)/10, d=hole/10, $fn=50);
    }
    //shaft
    cylinder((heigh_outer + heigh_hole)/10, d=inner/10, $fn=50);
}
