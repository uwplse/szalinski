//cilindro iniziale 
difference() {
    cylinder(h=38,r=14,center=true,$fn=50);
    
    cylinder(h=41,r=11,center=true,$fn=50);
   
    translate(v=[0,15,0]) 
    
    cube(size=[50,20,50],center=true); 
    ; 
    }
 
    


//piastra 1 attaccata al cilndro
 translate(v=[11.5,22.5,0]){
    
    union(){
    difference(){
    cube(size=[3,35,38],center=true);
    
    translate(v=[0,12,10])
    rotate([0,90,0]) cylinder(h=5,r=2,center=true,$fn=50);
        
   translate(v=[0,12,-10])
    rotate([0,90,0]) cylinder(h=5,r=2,center=true,$fn=50);
  
    
        }
        
    }
  
}

//piastra 2 attaccata al cilndro    
translate(v=[-11.5,22.5,0]){
    
    union(){
    difference(){
    cube(size=[3,35,38],center=true);
    
    translate(v=[0,12,10])
    rotate([0,90,0]) cylinder(h=5,r=2,center=true,$fn=50);
        
    translate(v=[0,12,-10])
    rotate([0,90,0]) cylinder(h=5,r=2,center=true,$fn=50);
  
    
        }
        
    }
}
// supporto primo finecorsa verticale   
translate(v=[29,20,0]){
    
    union(){
    difference(){
    cube(size=[38,3,38],center=true);
    
    hull() {   
    translate(v=[20,0,-13])
    rotate([90,0,0]) cylinder(h=5,r=2,center=true,$fn=50);
    translate(v=[10,0,-13])
    rotate([90,0,0]) cylinder(h=5,r=2,center=true,$fn=50); 
        }
        
    hull() {   
    translate(v=[20,0,5.5])
    rotate([90,0,0]) cylinder(h=5,r=2,center=true,$fn=50);
    translate(v=[10,0,5.5])
    rotate([90,0,0]) cylinder(h=5,r=2,center=true,$fn=50); 
        }
    }
    }  
}
// piastra inclinata
translate(v=[13,-5,-19]){
    
    rotate([0,0,62])
    cube(size=[27,3,38]);
    
}
// supporto secondo finecorsa orizzontale
translate(v=[0,-11,5]){

    union(){
    difference(){  
    rotate([90,0,0]) 
    cube(size=[40,3,23]);
    
    hull() {
    translate(v=[29,-25,-5])
    cylinder(h=10,r=2,,$fn=50);
    translate(v=[29,-13.5,-5])
    cylinder(h=10,r=2,,$fn=50);
    }
    
    hull() {
    translate(v=[10.5,-25,-5])
    cylinder(h=10,r=2,,$fn=50);
    translate(v=[10.5,-13.5,-5])
    cylinder(h=10,r=2,,$fn=50);
    }
   }
  }

}
//pezzo in più
translate(v=[0,0,5]){
    
    difference() {
    rotate([90,0,0])
    cube(size=[40,3,15]);
    cylinder(h=41,r=14,center=true,$fn=50);
    }
}

