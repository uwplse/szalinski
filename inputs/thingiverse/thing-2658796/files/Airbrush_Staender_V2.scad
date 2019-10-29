
//
$fn=50;
// 
translate([0,20,105]) rotate([-40,0,0]) kopf();
//fuss();
//vierkant();
//fuss_light();


module kopf(){

;difference(){
    group(){
   // cube([18,40,25],center=true);
        hull(){
            translate([0,20,1])rotate([90,0,0])cylinder(d=18.5,h=35);//
            translate([0,20,8])rotate([90,0,0])cylinder(d=18.5,h=40);//
        }
         
        hull(){
            translate([0,10.75,-40])rotate([0,0,0])cylinder(d=18.5,h=40);//Ständer
            translate([0,3,-40])rotate([30,0,0])cylinder(d=18.5,h=30);//Ständer
        }
        
        
   // #translate([0,17.5,10])  cube([18,5,25],center=true);
        hull(){
        translate([0,20,13])rotate([90,0,0])cylinder(d=18.5,h=5);
        translate([0,20,5])rotate([90,0,0])cylinder(d=18.5,h=5);
    }
}

  // #translate([0,10.8,-50])rotate([30,0,0])cylinder(d=12,h=40);//Bohrung im Ständer
   translate([0,12.8,-50])rotate([30,0,0])cube([12.5,12,70],center=true);//Aufnahme für Ständer

    
    hull(){
        translate([0,15,10])rotate([90,0,0])cylinder(d=12.9,h=50);
        translate([0,15,20])rotate([90,0,0])cylinder(d=12.8,h=50);
    }
   
    hull(){
        translate([0,25,0])rotate([90,0,0])cylinder(d=8,h=50);
        translate([0,25,10])rotate([90,0,0])cylinder(d=12.5,h=50);
    }
    
    
    
    
 //translate([-20,14,-7])rotate([90,0,90])cylinder(d=4.5,h=50);//Bohrung
    //translate([-20,-14,-7])rotate([90,0,90])cylinder(d=4.5,h=50);//Bohrung
     
   //# translate([0,-5.8,-33])rotate([90,0,0])cylinder(d=4.5,h=40);//Bohrung im Ständer für Befestigung
    
    //translate([0,-10,-53])cube([7.5,3.8,50],center=true);//Auschnitt Für Mutter
    
    
    rotate([90,0,90]) translate([0,15,-10])cylinder(d=30,h=100);//Diff für rechten Anschluß
}
 


}


module fuss(){



     difference(){
    cube([100,100,2],center=true);
    
    for (i = [90:90:360]){
      rotate([0,0,i])    translate([40,0,-5]) cylinder(d=4,h=10);//Bohrloescher
    }
     }
    difference(){
        cylinder(d=20,h=20);
        translate([0,0,20])  cube([12,12,40],center=true);
    }
    
    
    
   hull(){///Fuss 1
    translate([49,49,0]) sphere(d=2);
   translate([7,7,0]) cylinder(d=2,h=20);
   }
   
   rotate([0,0,90]){
     hull(){///Fuss 2
    translate([49,49,0]) sphere(d=2);
   translate([7,7,0]) cylinder(d=2,h=20);
   }
   }
   
  rotate([0,0,-90]){
     hull(){///Fuss 3
    translate([49,49,0]) sphere(d=2);
   translate([7,7,0]) cylinder(d=2,h=20);
   }
   }
   
   rotate([0,0,180]){
     hull(){///Fuss 4
    translate([49,49,0]) sphere(d=2);
   translate([7,7,0]) cylinder(d=2,h=20);
   }
   }
}


module fuss_light(){
 difference(){
    //cube([100,100,2],center=true);
    
    for (i = [90:90:360]){
     // #rotate([0,0,i])    translate([40,0,-5]) cylinder(d=4,h=10);//Bohrloescher
     rotate([0,0,i+45])    translate([72,0,-1.5]) cylinder(d=10,h=2);//Befestigung  
    }
     }
    difference(){
        cylinder(d=20,h=20);
        translate([0,0,20])  cube([12,12,40],center=true);
    }
    
    
    
   hull(){///Fuss 1
    translate([49,49,0]) sphere(d=3);
   translate([7,7,0]) cylinder(d=3,h=20);
   }
   
   rotate([0,0,90]){
     hull(){///Fuss 2
    translate([49,49,0]) sphere(d=3);
   translate([7,7,0]) cylinder(d=3,h=20);
   }
   }
   
  rotate([0,0,-90]){
     hull(){///Fuss 3
    translate([49,49,0]) sphere(d=3);
   translate([7,7,0]) cylinder(d=3,h=20);
   }
   }
   
   rotate([0,0,180]){
     hull(){///Fuss 4
    translate([49,49,0]) sphere(d=3);
   translate([7,7,0]) cylinder(d=3,h=20);
   }
   }
}
module vierkant(){
   
 difference(){
   // translate([0,0,50]) cube([11.8,11.8,60],center=true); 
     hull(){
     translate([0,0,80]) cube([11.7,11.8,1],center=true); 
    translate([0,0,0]) cube([11.8,11.8,1],center=true); 
    }
 translate([0,0,-10]) cylinder(d=8,h=100); 
 }
    
}