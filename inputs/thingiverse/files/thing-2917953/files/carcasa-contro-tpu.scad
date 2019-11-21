largo = 50;
ancho = 37;
alto = 10;
difference(){
    
    $fn=50;
minkowski()
{
   // translate([0,0,10]) 
cube([largo+2,ancho+2,alto+1],center=false);
cylinder(r=0.6,h=0.1);
}

  // translate([1,1,1]) 

      
minkowski()
{translate([1,1,1])
cube([largo,ancho,alto],center=false);
cylinder(r=0.6,h=1);
}
// translate([1,0.5,1]) 
///cube([largo,ancho,alto],center=false);


 translate([10,ancho/2,alto/2+1])
 rotate([0,90,0])
cylinder(r=3,h=largo);
//rotate([0,90,0])
// translate([50,12.5,alto/2])
//cube([5,12,2],center=false);


}


