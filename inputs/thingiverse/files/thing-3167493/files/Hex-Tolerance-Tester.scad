$fn=100+0;

//Thickness of the Plate (mm)
thick=2;        // Thickness

// Distance between Hexagons (mm)
distance_between=4;   

// Wrench Diameter (mm)
SW=7;


tolerance=0.1+0;

r_Hex=SW*(1/sqrt(3));

width=2*(r_Hex+distance_between);
length=6*(distance_between+SW)+distance_between;

difference()
{
difference()
{
  cube([length,width+4,thick]);
    
    for(i=[0:5])
        translate([distance_between+SW/2+i*(SW+distance_between),4+width/2,-1]) rotate(a=[0,0,90]) cylinder($fn = 6,h=thick+2,r=r_Hex+(tolerance*i)/2);   
}
    for(i=[0:5])

        translate([distance_between+SW/2+i*(SW+distance_between),3,thick-0.5])
        linear_extrude(height=2){
            text(str(SW+tolerance*i),size=3,halign="center");
        }
}