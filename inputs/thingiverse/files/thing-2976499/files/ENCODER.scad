d1=6;
d2=d1+20;

difference(){
    union(){
        cylinder(d=d2,h=3,$fn=30,center=true);  
       
        cylinder(d=d1+5,h=5,$fn=30,center=false);  
    }
    cylinder(d=d1,h=10,$fn=30,center=true);  
     for(i=[0:360/20:360]){
            rotate([0,0,i])translate([((d1+5)/2)+(((d2-(d1+5))/2)/2),0,0])cube([(d2-(d1+5))/3,2,6],center=true);
    }
}

    