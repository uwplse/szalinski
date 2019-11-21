xsize=9;

ysize=24;

wall=4;

hexhead=6.4;


heigh=10;

module hexheadpin(){
    $fn=6;
    cylinder(r=hexhead/(2*cos(30)),h=2*heigh);
    
    
}




module box(){
    $fn=15;
    
    union(){
    difference(){

        hull(){
            translate([0,(ysize-xsize)/2,0])cylinder(r=(wall+xsize)/2,h=heigh+wall);
            translate([0,-(ysize-xsize)/2,0])cylinder(r=(wall+xsize)/2,h=heigh+wall);    
        }
        hull(){
            translate([0,(ysize-xsize)/2,0])cylinder(r=xsize/2,h=heigh);
            translate([0,-(ysize-xsize)/2,0])cylinder(r=xsize/2,h=heigh);    
        }
    }
    
    difference(){
        translate([0,0,heigh+wall])cylinder(r=(wall+xsize)/2,h=2*heigh-(heigh+wall));
        hexheadpin();
    }
}
        
}   
    
    
box();


