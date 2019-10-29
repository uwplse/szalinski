x_cube=140;
y_cube=45;


raggiodado=7.9; //radius M8nut inside the structure
altezzadado=7.1; //M8nut height
raggio_cuscinetto=7.85; //radius for LM8UU
rasse8mm=4.4; //radius for M8 leadscrew
thickness=20;
cut=thickness+20;
r_sirin=9;
rett_sirin=10.8;

//vite centrata
dist_asta=45;
dist_siringa=-56;
dist_Ysiringa=5;

//seager
dist_seager=14;
z_cusc=thickness+1+14*2;  //il +1 per un piccolo problema di tagli



difference()
{    
    union(){
cube([x_cube,y_cube,thickness],center=true);    
        
        // strutture per cuscinetti
        
        
        translate([dist_asta-17.5,0,0])
        union(){
        cube([y_cube-10,y_cube,z_cusc],center=true);
            
       translate([17.5,0,0])
      cylinder(h=z_cusc,r=y_cube/2,$fn=50,center=true);
        }
    }
    
    //foro per dado nella vite
    
cylinder(h=40,r=rasse8mm, center=true, $fn=50);
rotate([0,0,30]) cylinder(h=altezzadado,r=raggiodado, center=true, $fn=6);
translate([0,20,0]) cube([raggiodado*2-1.5,40,altezzadado],center=true);
  
  //fori per asta e siringa
    
translate([dist_asta,0,0])cylinder(h=z_cusc+10,r=raggio_cuscinetto, center=true, $fn=50);
translate([dist_siringa,dist_Ysiringa,5])cylinder(h=2.22,r=rett_sirin,$fn=50,center=true);
translate([dist_siringa,dist_Ysiringa,-15])cylinder(h=20,r=r_sirin-1,$fn=50);
translate([-66,dist_Ysiringa,5])
    cube([20,2*rett_sirin,2.2],center=true);
translate([-71,dist_Ysiringa,-3])
    cube([30,(r_sirin-1)*2,15],center=true);

    
    //sopra da rifare per bene!!!!!!!!!
    
    //taglio tra i 2 cuscinetti
    
    translate([dist_asta+10,0,0])
    cube([y_cube,y_cube+5,thickness+1],center=true);

//rifinitura contorni

translate([dist_siringa,dist_Ysiringa,0])cylinder(h=50,r=1,$fn=50,center=true);
    

    
    rotate([90,0,0])
    translate([10,15+10,0])
    cylinder(h=50,r=15,center=true,$fn=50);
    
    rotate([90,0,0])
    translate([10,-15-10,0])
    cylinder(h=50,r=15,center=true,$fn=50);

 //taglio materiale in eccesso
    rotate([90,0,0])
    translate([32.5,0,0])
    scale([1,1.5,1])
    cylinder(h=50,r=7,center=true,$fn=50);
    
    
    translate([-90,0,0])
    cube([50,50,50],center=true);
    

    
         

}




