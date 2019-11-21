//piastra 1
translate(v=[0,0,0]){
    
    //fori asse 1
    difference(){
    cube(size=[105,6,20]);
    translate(v=[82,5,-5])
    cylinder(h=41,r=2.5,$fn=100);
    translate(v=[18,5,-5])
    cylinder(h=41,r=2.5,$fn=100);
    
    //fori per viti
    translate(v=[5,10,5])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[5,10,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    
    //svasature
    translate(v=[82,9,-5])
    cylinder(h=41,r=5,$fn=100);
    translate(v=[18,9,-5])
    cylinder(h=41,r=5,$fn=100);
    
    //fori per viti 
    translate(v=[100,10,5])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[100,10,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    
    //fori per sensore
    hull(){
    translate(v=[68.5,10,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[68.5,10,20])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    }
    hull(){
    translate(v=[50,10,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[50,10,20])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    }
    }
}

//piastra 2
translate(v=[0,50,0]){
    
    //fori asse 2
    difference(){
    cube(size=[105,12,20]);
    translate(v=[82,0,-5])
    cylinder(h=41,r=2,$fn=100);
    translate(v=[18,0,-5])
    cylinder(h=41,r=2,$fn=100);
        
    //fori per viti
    translate(v=[5,15,5])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[5,15,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    
    //svasatue
    translate(v=[82,-4,-5])
    cylinder(h=41,r=5.5,$fn=100);
    translate(v=[18,-4,-5])
    cylinder(h=41,r=5.5,$fn=100);
     
    //fori per viti 
    translate(v=[100,15,5])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[100,15,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    
    //fori per sensore
    hull(){
    translate(v=[68.5,15,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[68.5,15,20])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    }
    hull(){
    translate(v=[50,15,15])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    translate(v=[50,15,20])
    rotate([90,0,0])
    cylinder(h=40,r=2,$fn=100);
    }

    }
    

}
 