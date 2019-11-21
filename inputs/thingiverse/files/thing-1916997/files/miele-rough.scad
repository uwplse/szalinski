
$fn=50;

difference() {
kuehlschrankhalter() ;
    
    translate([44,-125,44+30])
    rotate([0,45,0])
    cube([150,250,100]);
    
}

module kuehlschrankhalter() {
    r1 = 20;
    r2 = 2;
    r3 = 50-20;
    d = 120-20;
    h = 44+30;   // 4.4cm hoch
ss = 204+1;    // 20.4 cm seite bis seite
    b = 3;
    
    // indent
    is = 20; ie = 31;//   2cm -- 3.1 cm indent
    id = 6; // 6mm tief
   ih = 34+30; // 3.4 cm hoch
    ir = 2; // radius
    
    // vorsprung 3.8cm 0.7cm
    vd = 39.5;
    vd2 = 7;
    w = 3;
    
        //form(ss,r1,d,vd,vd2,r2,r3); 
        
    difference() {
      union() { 
         // bottom
          union() {
         linear_extrude(b)
          polygon([[0,-w/2],[0,w/2],[d,w/2],[d,-w/2]]);
                   linear_extrude(b)
          polygon([[0,ss/4-w/2],[0,ss/4+w/2],[d,ss/4+w/2],[d,ss/4-w/2]]);
                             linear_extrude(b)
          polygon([[0,-ss/4-w/2],[0,-ss/4+w/2],[d,-ss/4+w/2],[d,-ss/4-w/2]]);
              #    linear_extrude(b)
          polygon([[vd,-ss/2],[vd,ss/2],[vd+w,ss/2],[vd+w,-ss/2]]);
                  linear_extrude(b)        union() {
        mirror([0,1,0]) 
            form(ss,r1,d,vd,vd2,r2,r3);
        form(ss,r1,d,vd,vd2,r2,r3);   
        } 
for(i = [0:15])  {
        linear_extrude(b)
          difference() {
              offset (r=-9*i)
        union() {
        mirror([0,1,0]) 
            form(ss,r1,d,vd,vd2,r2,r3);
        form(ss,r1,d,vd,vd2,r2,r3);   
        } 
        offset(r=-9*i-w)
               union() {
        mirror([0,1,0]) 
            form(ss,r1,d,vd,vd2,r2,r3);
        form(ss,r1,d,vd,vd2,r2,r3);   
        } 
    }
}
    }
    

        
        
          // frame
    difference() {
        // outer frame
        linear_extrude(h)
        union() {
        mirror([0,1,0]) 
            form(ss,r1,d,vd,vd2,r2,r3);
        form(ss,r1,d,vd,vd2,r2,r3);   
        }
        // removed center
        linear_extrude(h)
        offset(r=-w)
        union() {
        mirror([0,1,0]) 
            form(ss,r1,d,vd,vd2,r2,r3);
        form(ss,r1,d,vd,vd2,r2,r3);   
        }
    }
    // close slots
    intersection() {
      // outer frame
        linear_extrude(h)
        union() {
        mirror([0,1,0]) 
            form(ss,r1,d,vd,vd2,r2,r3);
        form(ss,r1,d,vd,vd2,r2,r3);   
        }
        minkowski() {
            union() {
                // cut slots
     slot(is,ir,ss,ie,id,ih);
        mirror([0,1,0])
        slot(is,ir,ss,ie,id,ih);
            }
            sphere(w);
        }
    }
    
    
}
    // cut slots
     slot(is,ir,ss,ie,id,ih);
        mirror([0,1,0])
        slot(is,ir,ss,ie,id,ih);
}
}
  // minkowski() {
    //scale([4.4-4,20.4-4,4.4-1]) cube(1);
//}

module slot(is,ir,ss,ie,id,ih) {
     translate([is+ir,-ss/2,-ir]) minkowski() {
cube([ie-is-2*ir,id,ih]);
rotate([90,0,0])
cylinder(r=ir,h=10);
}
}
module form(ss,r1,d,vd,vd2,r2,r3) {
    
       translate([r1,-ss/2+r1,0])
    circle(r=r1);
    
   scale([1,-1,1]) square([vd,ss/2-r1]);
    
    translate([r1,0,0])
    scale([1,-1,1]) square([vd-r1,ss/2]);
    
    polygon([[vd,0],[d-r3,0],[d-r3,-ss/2],[vd,-ss/2-vd2]]);
 //  translate([vd,-ss/2-vd2,0]) square([d-vd-r3,vd2]);
    translate([d-r3,-ss/2+r3,0])
    circle(r=r3);
    polygon([[d-r3,0],[d,0],[d,-ss/2+r3],[d-r3,-ss/2]]);
    

   translate([vd-r2,-ss/2-r2,0])
    difference() {
    square([r2,r2]);
    circle(r=r2);
    }  
    }