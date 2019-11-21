//WARNING : enter parameters in MILLIMETER!!!

//spool width (40mm minimum, over 55mm the spool holder is split in 3parts)
sw=70; 

//spool diameter
sd=200; 

//bearing width
bw=7; 

//bearing diameter
bd=22; 

//hole diameter for screws
bh=5; 

//choose what you want to export
export=1;//[1:both parts,2:bearing holder only,3:jigsaw part only]

//once you are happy with your settings, render it (press F6), then export STL file (file/export/STL)

//do not change underneath values

bs=sd*sin(20);  //bearings spacing
x=bs+bd+4;
y=bw+2+2*4;
z=4+2+bd/2;
pw=sw-40; //jigsaw part width

module holder() {
union() { //bearings holder
    difference() {
        union() {
            cube([x,4,z]);
            translate([bd/2+2,0,4+2+bd/2]) scale([1,1,1.2]) rotate([-90,0,0]) cylinder(d=bd+4, h=4, $fn=50);
            translate([x-(bd/2+2),0,4+2+bd/2]) scale([1,1,1.2]) rotate([-90,0,0]) cylinder(d=bd+4, h=4, $fn=50);
        }
        translate([bd/2+2,-1,4+2+bd/2]) rotate([-90,0,0]) cylinder(d=bh, h=6, $fn=25);
        translate([x-(bd/2+2),-1,4+2+bd/2]) rotate([-90,0,0]) cylinder(d=bh, h=6, $fn=25);
        translate([x/2,-1,z]) scale([(x-2*(bd+4))/(bd-4),1,1]) rotate([-90,0,0]) cylinder(d=bd-4, h=6, $fn=50);
        translate([0,0,-25]) cube([3*sd,4*bw,50],center=true);
        }

    translate([0,y-4,0]) difference() {
        union() {
            cube([x,4,z]);
            translate([bd/2+2,0,4+2+bd/2]) scale([1,1,1.2]) rotate([-90,0,0]) cylinder(d=bd+4, h=4, $fn=50);
            translate([x-(bd/2+2),0,4+2+bd/2]) scale([1,1,1.2]) rotate([-90,0,0]) cylinder(d=bd+4, h=4, $fn=50);
        }
        translate([bd/2+2,-1,4+2+bd/2]) rotate([-90,0,0]) cylinder(d=bh, h=6, $fn=25);
        translate([x-(bd/2+2),-1,4+2+bd/2]) rotate([-90,0,0]) cylinder(d=bh, h=6, $fn=25);
        translate([x/2,-1,z]) scale([(x-2*(bd+4))/(bd-4),1,1]) rotate([-90,0,0]) cylinder(d=bd-4, h=6, $fn=50);
        translate([0,0,-25]) cube([3*sd,4*bw,50],center=true);
        }
    
    translate([1.5,(y+4)/2,5]) difference() {
        cube([3,y+4,5.5],center=true);
        translate([0,(y+4)/2,3]) rotate([0,90,0]) cylinder(r=4,h=6,$fn=60, center=true);
        translate([0,y/2-(y+4)/2,3]) scale([1,(y-8)/8,1]) rotate([0,90,0]) cylinder(r=4,h=6,$fn=60, center=true);
    }
    
    translate([x-1.5,(y+4)/2,5]) difference() {
        cube([3,y+4,5.5],center=true);
        translate([0,(y+4)/2,3]) rotate([0,90,0]) cylinder(r=4,h=6,$fn=60, center=true);
        translate([0,y/2-(y+4)/2,3]) scale([1,(y-8)/8,1]) rotate([0,90,0]) cylinder(r=4,h=6,$fn=60, center=true);
    }


if (sw>=55 || sw<40) {
    union() {   //base
        difference() {
            minkowski() {
                {difference() {
                    translate([2.5,-2.5,0]) cube([x-5,y+10-0.3,3]);
                    translate([21.5,y+2.5,-0.5]) cube([x-(2*2*9.5+10-5),13,5]);}
                                }    
                 cylinder(d=5,h=1,$fn=20);
                 }
            minkowski() {
                    {translate([26.5,y+2.5,-0.5]) cube([x-(2*2*9.5+10)-5,13,5]);}
                    cylinder(d=5,h=1,$fn=20);
                 }
                 
            minkowski() {
                {translate([5+2.5,5+2.5,-0.5]) cube([x-15,bw-5,4]);}
                cylinder(d=5,h=1,$fn=20);
                }
                
            minkowski() {
                {translate([3+2,y+3+1.5,-0.5]) cube([14,0.5,4]);}
                cylinder(d=4,h=1,$fn=20);
                }
                 
            translate([-1,-15,-1]) cube([x+2,15,6]);
                 
            minkowski() {
                {translate([x-12,y+10.75,-0.5]) scale([1,1,2]) rotate([0,0,180]) union(){
                    translate([-3.5,4,0]) cube([7,5,4]);
                    translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-2.5,0,0]) cube([5,5,4]);
                }}
                cylinder(d=0.5,h=1,$fn=20);
            }
        }
        translate([12,y+10-1,0]) union(){
            translate([-3.5,4,0]) cube([7,5,4]);
            translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
            translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
            translate([-2.5,0,0]) cube([5,5,4]);
        }
    }
}
else {
    union() {   //base
        difference() {
            minkowski() {
                {difference() {
                    translate([2.5,-2.5,0]) cube([x-5,y+(sw-18-2.5)/2,3]);
                    translate([21.5,y+2.5,-0.5]) cube([x-(2*2*9.5+10-5),23,5]);}
                                }    
                 cylinder(d=5,h=1,$fn=20);
                 }
            minkowski() {
                    {translate([26.5,y+2.5,-0.5]) cube([x-(2*2*9.5+10)-5,23,5]);}
                    cylinder(d=5,h=1,$fn=20);
                 }
                 
            minkowski() {
                {translate([5+2.5,5+2.5,-0.5]) cube([x-15,bw-5,4]);}
                cylinder(d=5,h=1,$fn=20);
                }
                
            minkowski() {
                {translate([3+2,y+3+1.5,-0.5]) cube([14,(sw-39.5)/2,4]);}
                cylinder(d=4,h=1,$fn=20);
                }
                 
            translate([-1,-15,-1]) cube([x+2,15,6]);
                 
            minkowski() {
                {translate([x-12,y+(sw-18-2.5)/2+1.5,-0.5]) scale([1,1,2]) rotate([0,0,180]) union(){
                    translate([-3.5,4,0]) cube([7,5,4]);
                    translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-2.5,0,0]) cube([5,5,4]);
                }}
                cylinder(d=0.5,h=1,$fn=20);
            }
        }
        translate([12,y+(sw-18-2.5)/2-1,0]) union(){
            translate([-3.5,4,0]) cube([7,5,4]);
            translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
            translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
            translate([-2.5,0,0]) cube([5,5,4]);
        }
    }
}
}
}

*translate([x,2*y+20+pw,0]) rotate([0,0,180]) holder();
*translate([x/2,(2*y+20+pw)/2,30]) difference() {
    cube([30,sw,30], center=true);
    translate([0,0,-25]) cube([32,sw-10,30], center=true);
}


module jigsaw() {
    if(sw>=55) { //jigsaw part
    translate([0,y+10,0]) difference() {
    union() {
        minkowski() {
            {translate([2.5,2.5,0]) cube([x-5,pw-5,3]);}
            cylinder(d=5,h=1,$fn=20);
        }
        translate([12,pw-0.75,0]) union(){
                    translate([-3.5,4,0]) cube([7,5,4]);
                    translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-2.5,0,0]) cube([5,5,4]);
                }
        translate([x-12,0.75,0]) rotate([0,0,180]) union(){
                    translate([-3.5,4,0]) cube([7,5,4]);
                    translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                    translate([-2.5,0,0]) cube([5,5,4]);
            }
        }
        
        
    minkowski() {
                    {translate([x-12,pw+1,-0.5]) scale([1,1,2]) rotate([0,0,180]) union(){
                        translate([-3.5,4,0]) cube([7,5,4]);
                        translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                        translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                        translate([-2.5,0,0]) cube([5,5,4]);
                    }}
                    cylinder(d=0.5,h=1,$fn=20);
                }
                
                
    minkowski() {
                    {translate([12,-1,-0.5]) scale([1,1,2]) union(){
                        translate([-3.5,4,0]) cube([7,5,4]);
                        translate([3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                        translate([-3.5,6.5,0]) cylinder(d=5,h=4,$fn=40);
                        translate([-2.5,0,0]) cube([5,5,4]);
                    }}
                    cylinder(d=0.5,h=1,$fn=20);
                }
                
translate([5,14,-1]) cube([x-28,pw-19,6]);
        
                
translate([23,5,-1]) cube([x-28,pw-19,6]);
                
translate([x/2,pw/2,2]) cube([x-46,pw-10,6], center=true);
}
}
}

if (export==1) {
    holder(); 
    jigsaw();
}

else if (export==2) {
    holder();
}

else {
    jigsaw();
}
