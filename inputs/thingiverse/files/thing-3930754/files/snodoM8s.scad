M=8; // diametro nominale del bullone
        //nominal bold diameter
Dado=13; //misura della chiave questo è disegnato per bulloni da M8

R=M/2+0.5;
base=M*3+1;
racc=base/5;
sede=base-racc;
$fn=50;
module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
   
/*difference(){
    minkowski(){
        cube(base,true);
        sphere(racc);
    }
    translate([0,0,-base])cylinder(base*2,R,R);
    translate([-M,0,0])cube ([sede,Dado+0.2,Dado+0.2],true);
    rotate([90,0,0]){
        translate([0,0,-base/2])cylinder_outer(base,Dado/2+0.1,6);
        translate([0,0,-base])cylinder(base*2,R,R);
    }
}*/

translate([-base/2,0,0]){
    difference(){
        minkowski(){
            union(){
                cube([base,base+racc*2,Dado+2],true);
                translate([base/2,(base+racc*2)/2,0])rotate([90,0,0])cylinder(d=Dado+2, h=base+racc*2);
            }
            sphere(racc);
            
        }
        
        translate([base/1.5,0,0])cube([base*2,base+0.5+racc*2,base*2],true);
       rotate([90,0,0]) translate([base/2,0,-base]){cylinder(base*2,R,R);
    //translate([0,0,-base/2-2])cylinder_outer(sede,Dado/2+0.1,6);  
       }  
        rotate([0,90,0]){
        translate([0,0,-base/2])cylinder_outer(sede,Dado/2+0.1,6);
        translate([0,0,-base])cylinder(base*2,R,R);    
        }
    }
}
            