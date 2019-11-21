// PRUSA iteration3
// RAMBo cover door
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
module body()
{
cube( [ 105.5+1.52 , 87.5+34.25 , 1 ] );  
cube( [ 105.5+1.52 , 2 , 20 ] );  
cube( [ 2 , 87.5+34.25 , 20 ] );  

// corner reinforcement
translate( [ 98+1.52 , 1 , 0 ] ) cube( [ 7.5 , 5 , 20 ] );   
translate( [ 0.5 , 0.5 , 0 ] ) cube( [ 5 , 6.5 , 20 ] );  
translate( [ 1 , 0 , 0 ] ) cube( [ 10 , 87.5+34.25 , 6 ] );  
translate( [ 99.5+1.52 , 0 , 0 ] ) cube( [ 6 , 87.5+34.25 , 7 ] );  
translate( [ 10 , 0 , 0 ] ) cube( [ 6 , 5 , 6 ] );  
    
// screw thread body
translate( [ 54+1.52 , 2 , 0 ] ) cube( [ 9.5 , 6 , 20 ] );  

// rounded side
translate( [ 0 , 87.5+34.25 , 4.5 ] ) rotate([0,90,0]) cylinder( h = 105.5, r = 4.5, $fn=30);  

// upper hinge reinforcement
translate( [ 0.5 , 69+34.25 , -9 ] ) rotate([20,0,0]) cube( [ 26 , 20 , 10 ] );  
    
// door closing
translate( [ 4 , 3.5 , 16.8 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.8, r2= 3.5, $fn=30);  
translate( [ 102+1.52 , 3.5 , 16.8 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.8, r2= 3.5, $fn=30); 

}

module ventilation_holes()
    {
     for ( i = [0 : 9] ){
      translate([46 + (i*5.5),10.5,-1]) cube([3,19,10]);
      translate([47.5 + (i*5.5),10.5,-1]) cylinder( h = 10, r = 1.5, $fn=30);;
      translate([47.5 + (i*5.5),29.5,-1]) cylinder( h = 10, r = 1.5, $fn=30);;
   //   translate([47.5 + (i*5.5),38.5,-1]) cylinder( h = 10, r = 1.5, $fn=30);;
    }
}

module cutouts()
{
// door closing screw
translate( [ 58.5+1.52 , 4 , 5 ] ) cylinder( h = 17, r = 1.5, $fn=30);  
translate( [ 58.5+1.52 , 4 , 18.5 ] ) cylinder( h = 2, r1 = 1.5, r2=1.9, $fn=30); 
translate( [ 25,108 ,0.4]) rotate([180,0,270]) linear_extrude(height = 2) text("PRUSA", 20);
translate( [ 40,108 ,0.4]) rotate([180,0,270]) linear_extrude(height = 2) text("RESEARCH", 12.5);


ventilation_holes();
translate([0,50,0]) ventilation_holes();
translate([0,25,0]) ventilation_holes();
translate([0,75,0]) ventilation_holes();
    

// rounded side cutoff    
translate( [ 26.5 , 87.5+34.25 , 4.5 ] ) rotate([0,90,0]) cylinder( h = 73, r = 3.5, $fn=30);   
translate([ 26.5 ,80+34.25 ,5]) cube([73,19,10]); 
translate([ 26.5 ,82.5+34.25 ,1]) cube([73,5,10]); 
    
translate( [ 0 , 60+34.25 , -10 ] ) cube( [ 30 , 30 , 10 ] );    
translate( [ -1 , 87.5+34.25 , 0 ] ) cube( [ 22.5 , 10 , 10 ] );   

// upper hinge 
translate( [2 , 80+34.25, 6] ) cube( [ 19.5, 10 , 10 ] );     
translate( [-2 , 89.7+34.25, 3] ) rotate([70,0,0]) cube( [ 19.5, 10 , 5 ] );   
translate( [ -5 , 87.5+34.25 , 4.5 ] ) rotate([0,90,0]) cylinder( h = 26.5, r = 2.5, $fn=30);  

// hinge hole
translate( [ -5 , 87.5+34.25 , 4.5 ] ) rotate([0,90,0]) cylinder( h = 120, r = 2.6, $fn=30); 
translate([105.5,87.5+30, 0]) cube (8,8,8);
// door closing 
translate( [ 4 , 3.5 , 16.9 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.2, r2= 2.8, $fn=30);  
translate( [ 102+1.52 , 3.5 , 16.9 ] ) rotate([0,0,0]) cylinder( h = 3.2, r1 = 1.2, r2= 2.8, $fn=30);  

// M3 NUT
translate( [55.65+1.52 , 0.5, 16] ) cube( [ 5.7, 10 , 2.2 ] );  


translate( [4 , 10, 4] ) cube( [ 4, 65+34.25 , 5 ] );  
translate( [101+1.52 , 10, 4] ) cube( [ 3, 70+34.25 , 5 ] );  

}



module RAMBo_cover_doors()
{
difference()
{
    body();
    cutouts();
    translate( [0 , -20, -3] ) rotate([0,45,45]) cube( [ 30+1.52, 30 , 20 ] );  
    }
}
 
RAMBo_cover_doors();
    
    
    
    
    
    
    
    
    
    