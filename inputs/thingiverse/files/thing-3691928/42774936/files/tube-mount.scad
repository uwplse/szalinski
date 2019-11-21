tube_dia=80; //диаметр трубки
st_h=8;//высота отверстия под стяжку
st_w=3;// ширина отверстия под стяжку
// nut m4
//nut_h=3.1;
//nut_d=7.9;
//nut_dia=4.2;

// nut m5
//#translate([0,49,0])cylinder(h=50,d=0.2,$fn=100);
nut_h=4.1;
nut_d=9.1;
nut_dia=5.2;

tube_holder();
tube_base();

module tube_base(){
difference(){     
union(){
translate([0,0,26+3+0.2]){
translate([-tube_dia/2-18+6,15,-3-4])rotate([0,0,0])cylinder(h=4,d=24,$fn=100);       
translate([tube_dia/2+18-6,15,-3-4])rotate([0,0,0])cylinder(h=4,d=24,$fn=100); 
translate([-tube_dia/2-30+6,15,-3-4])cube([6,tube_dia/2-10,4]);    
translate([tube_dia/2+30-6-6,15,-3-4])cube([6,tube_dia/2-10,4]); 
translate([-tube_dia/2-30+6,tube_dia/2,-3-4])cube([tube_dia+60-12,7,4]);        
translate([-tube_dia/2-30+6+10,3,-3-4])cube([12,7,4]);            
    translate([tube_dia/2+1,3,-3-4])cube([12,7,4]);

     
difference(){    
translate([0,0,-3-4])cylinder(h=4,d=tube_dia+14,$fn=100);   
    translate([-tube_dia/2-30,-tube_dia+3,-15.001])cube([tube_dia+20+40,tube_dia,20.1]);        
    };

    };
    

translate([-tube_dia/2-18+6,15,-3-4])rotate([0,0,0])cylinder(h=4,d=24,$fn=100);       
translate([tube_dia/2+18-6,15,-3-4])rotate([0,0,0])cylinder(h=4,d=24,$fn=100); 
translate([-tube_dia/2-30+6,14,-3-4])cube([6,tube_dia/2-10,4]);    
translate([tube_dia/2+30-6-6,14,-3-4])cube([6,tube_dia/2-10,4]); 
translate([-tube_dia/2-30+6,tube_dia/2,-3-4])cube([tube_dia+60-12,7,4]);        
translate([-tube_dia/2-30+6+10,3,-3-4])cube([12,7,4]);            
    translate([tube_dia/2+1,3,-3-4])cube([12,7,4]);    
difference(){    
translate([0,0,-3-4])cylinder(h=4,d=tube_dia+14,$fn=100);   
    translate([-tube_dia/2-30,-tube_dia+3,-15.001])cube([tube_dia+20+40,tube_dia,20.1]);        
    };
    
translate([0,0,26])hull(){    
translate([-tube_dia/2-18+6,15,-6+0.2])rotate([0,0,0])cylinder(h=3,d=24,$fn=100);    
translate([tube_dia/2+18-6,15,-6+0.2])rotate([0,0,0])cylinder(h=3,d=24,$fn=100);        
translate([-tube_dia/2-30+6,tube_dia/2,-6+0.2])cube([tube_dia+60-12,7,3]);    
};
hull(){    
translate([-tube_dia/2-18+6,15,-3])rotate([0,0,0])cylinder(h=3,d=24,$fn=100);    
translate([tube_dia/2+18-6,15,-3])rotate([0,0,0])cylinder(h=3,d=24,$fn=100);        
translate([-tube_dia/2-30+6,tube_dia/2,-3])cube([tube_dia+60-12,7,3]);    
};
//для гаек усиление

translate([tube_dia/2+19,tube_dia/2+7,40+10-6])rotate([90,0,0])difference(){
    cylinder(h=11,d=10,$fn=100);
      translate([-5.5,-5.5,0])cylinder(h=12,d=10,$fn=100);
};
translate([-tube_dia/2-19,tube_dia/2+7,40+10-6])rotate([90,0,0])difference(){
    cylinder(h=11,d=10,$fn=100);
      translate([5.5,-5.5,0])cylinder(h=12,d=10,$fn=100);
};
translate([tube_dia/2+18,tube_dia/2-4,40-10-6])cube([6,4,20]);
translate([-tube_dia/2-18-6,tube_dia/2-4,40-10-6])cube([6,4,20]);

translate([-tube_dia/2-18-1,tube_dia/2-4,43])cube([tube_dia-6,4,6]);    
translate([0,tube_dia/2-4,43])cube([tube_dia/2+19,4,6]);    

translate([-tube_dia/2-30+6,tube_dia/2,-6])hull(){
    
    translate([0,0,0])cube([tube_dia+60-12,7,40]);
    
    
    translate([5,7,40+10])rotate([90,0,0])cylinder(h=7,d=10,$fn=100);
    
    translate([tube_dia+60-5-12,7,40+10])rotate([90,0,0])cylinder(h=7,d=10,$fn=100);
    echo(tube_dia+40+60-5);
    };
};


translate([-tube_dia/2-18+6,15,-16.01])rotate([0,0,0])cylinder(h=85,d=nut_dia,$fn=100);


translate([tube_dia/2+18-6,15,-16.01])rotate([0,0,0])cylinder(h=85,d=nut_dia,$fn=100);
//гайки
translate([-tube_dia/2-18+6,15,-3.01-nut_h])rotate([0,0,0])cylinder(h=nut_h,d=nut_d,$fn=6);
translate([tube_dia/2+18-6,15,-3.01-nut_h])rotate([0,0,0])cylinder(h=nut_h,d=nut_d,$fn=6);

translate([-tube_dia/2-18+6,15,27.3-nut_h])rotate([0,0,0])cylinder(h=nut_h,d=nut_d,$fn=100);
translate([tube_dia/2+18-6,15,27.3-nut_h])rotate([0,0,0])cylinder(h=nut_h,d=nut_d,$fn=100);
    
translate([0,0,-15])cylinder(h=80,d=tube_dia+1,$fn=100);
translate([0,0,0])cylinder(h=20.2,d=tube_dia+25,$fn=100);

hull(){
translate([tube_dia/2+18-6,50,37])rotate([90,0,0])cylinder(h=35,d=nut_dia,$fn=100);
translate([tube_dia/2+18-20-6,50,37])rotate([90,0,0])cylinder(h=35,d=nut_dia,$fn=100);
};
hull(){
translate([-tube_dia/2-18+6,50,37])rotate([90,0,0])cylinder(h=35,d=nut_dia,$fn=100);
translate([-tube_dia/2-18+20+6,50,37])rotate([90,0,0])cylinder(h=35,d=nut_dia,$fn=100);
};
};
    
};


module tube_holder(){
difference (){
union(){
difference(){    
cylinder(h=20,d=tube_dia+14,$fn=100);
translate([-tube_dia/2-30,-tube_dia+3,-0.001])cube([tube_dia+20+40,tube_dia,20.1]);        
};

translate([-tube_dia/2-30+6,3,0])cube([tube_dia+20+40-12,tube_dia/2-3,20]);    
hull(){
translate([-tube_dia/2-30+3+6,3,0])cylinder(h=20,d=6,$fn=100);    
translate([-tube_dia/2-3,3,0])cylinder(h=20,d=6,$fn=100);
};    
    hull(){
translate([tube_dia/2+30-3-6,3,0])cylinder(h=20,d=6,$fn=100);        

translate([tube_dia/2+3,3,0])cylinder(h=20,d=6,$fn=100); 
};    
};
translate([0,0,-0.001])cylinder(h=20.1,d=tube_dia,$fn=100);
translate([0,0,20/2-st_h/2])rotate_extrude(convexity = 10,$fn=100)
translate([tube_dia/2+3, 0, 0])
square([st_w,st_h]);
hull(){
translate([-tube_dia/2-18+6,10,20]){rotate([90,90,0])cylinder(h=nut_h,d=nut_d,$fn=6);
translate([0,0,-20])rotate([90,90,0])cylinder(h=nut_h,d=nut_d,$fn=6);
};
};

hull(){
translate([tube_dia/2+18-6,10,20]){rotate([90,90,0])cylinder(h=nut_h,d=nut_d,$fn=6);
translate([0,0,-20])rotate([90,90,0])cylinder(h=nut_h,d=nut_d,$fn=6);
};
};
hull(){
translate([-tube_dia/2-18+6,15,-0.01])rotate([0,0,0])cylinder(h=25,d=nut_dia,$fn=100);
translate([-tube_dia/2-18+6,30,-0.01])rotate([0,0,0])cylinder(h=25,d=nut_dia,$fn=100);
    
};
hull(){
translate([tube_dia/2+18-6,15,-0.01])rotate([0,0,0])cylinder(h=25,d=nut_dia,$fn=100);
translate([tube_dia/2+18-6,30,-0.01])rotate([0,0,0])cylinder(h=25,d=nut_dia,$fn=100);
    
};
translate([-tube_dia/2-18+6,45,10])rotate([90,0,0])cylinder(h=50,d=nut_dia,$fn=100);
translate([tube_dia/2+18-6,45,10])rotate([90,0,0])cylinder(h=50,d=nut_dia,$fn=100);
};
};
