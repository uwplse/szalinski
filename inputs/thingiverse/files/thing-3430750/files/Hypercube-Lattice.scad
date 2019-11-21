a=0.6;//bar thickness
b=3;//ball radius
c=10;//cell length

for(i = [1 : 5]){
    for(j = [1 : 5]){
        for(k = [1 : 5]){
            translate(v=[10*i,0,0]){
                translate(v=[0,10*j,0]){
                    translate(v=[0,0,10*k]){
                    Unitcell(){}
                }
            }
        }
        }
    }
}
          
        
module Unitcell()
union(){
    

cylinder(h = c, r1 = a, r2 = a, center = true/false);
rotate(a = 90, v = [1, 0, 0]) { 
cylinder(h = c, r1 = a, r2 = a, center = true/false);}
rotate(a = 90, v = [0, 1, 0]) { 
cylinder(h = c, r1 = a, r2 = a, center = true/false);}
translate(v = [c,-c,0]) {
cylinder(h = c, r1 = a, r2 = a, center = true/false);
rotate(a = 90, v = [-1, 0, 0]) { 
cylinder(h = c, r1 = a, r2 = a, center = true/false);}
rotate(a = 90, v = [0, -1, 0]) { 
cylinder(h = c, r1 = a, r2 = a, center = true/false);}}


translate(v=[10,0,0]){
cylinder(h = c, r1 = a, r2 = a, center = true/false);
}

translate(v=[0,-c,0]){
cylinder(h = c, r1 = a, r2 = a, center = true/false);
}

rotate(a = 90, v = [1, 0, 0]) { 
    translate(v=[0,c,0]){
cylinder(h = c, r1 = a, r2 = a, center = true/false);}}

rotate(a = 90, v = [1, 0, 0]) { 
    translate(v=[c,c,0]){
cylinder(h = c, r1 = a, r2 = a, center = true/false);}}

rotate(a = 90, v = [0, 1, 0]) { 
    translate(v=[-10,0,0]){
cylinder(h = 10, r1 = a, r2 = a, center = true/false);}}

rotate(a = 90, v = [0, 1, 0]) { 
    translate(v=[-c,-c,0]){
cylinder(h = c, r1 = a, r2 = a, center = true/false);}}


sphere(r = 1);

translate(v=[c,0,0]){
sphere(r = 1);}

translate(v=[0,-c,0]){
    sphere(r = 1);}
    
translate(v=[0,0,c]){
     sphere(r = 1);}

translate(v=[c,0,c]){
sphere(r = 1);}

translate(v=[0,-c,c]){
    sphere(r = 1);}
    
translate(v=[c,-c,0]){
    sphere(r = 1);}
    
translate(v=[c,-c,c]){
     sphere(r = 1);}
    
translate(v=[0,-c,0]){
rotate(a = 45, v = [0,0, 1]){
    rotate(a = 55, v = [0,1, 0]){
cylinder(h = 18, r1 = a, r2 = a, center = true/false);
}
}
}

translate(v=[0,0,0]){
rotate(a = 45, v = [0,0, 1]){
    rotate(a = 55, v = [1,0, 0]){
cylinder(h = 1.8*c, r1 = a, r2 = a, center = true/false);
}
}
}

translate(v=[c,0,0]){
rotate(a = 45, v = [0,0, 1]){
    rotate(a = 55, v = [0,-1, 0]){
cylinder(h = 1.8*c, r1 = a, r2 = a, center = true/false);
}
}
}

translate(v=[c,-c,0]){
rotate(a = 45, v = [0,0, 1]){
    rotate(a = 55, v = [-1,0, 0]){
cylinder(h = 1.8*c, r1 = a, r2 = a, center = true/false);
  
translate(v=[0,0,c]){
sphere(r = b);
}
    }
}
}
}