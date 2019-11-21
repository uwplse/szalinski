/*
GROWING SHELF CUSTOMIZER

Adapted for Thingiverese customizer

Fernando Jerez 2016

*/

// preview[view:south, tilt:top]



/* [Generated pieces] */
size = 2; // [1:1x grid size, 2:2x grid size, 3:3x grid size, 4:4x grid size]
height = 1; // [1:1x grid size, 2:2x grid size, 3:3x grid size, 4:4x grid size]

// Which one would you like to see?
part = "all"; // [all:all pieces, corner:Corner, one:end tile, two: straight tile, three:T-tile, four: Cross tile, angle: 90 deg angle]

/* [Grid config] */
grid_size = 40;
wall_thickness = 10;

/* [Hidden] */
grid = grid_size*size;

altura = grid_size;
levels = height;
grosor = wall_thickness;

pinradius = 2.5;
pinheight =10;
$fn=60;



// Show parts
union(){
    for(i=[0:levels-1]){
        translate([0,0,altura*i]){
            if(part=="all"){
                complete_set();
            }else if(part=="corner"){
                tileCorner();
            }else if(part=="one"){
                tile1();
            }else if(part=="two"){
                tile2();
            }else if(part=="three"){
                tile3();
            }else if(part=="four"){
                tile4();
            }
        }
    }
    if(part=="angle"){
        angle(90);
    }
    if(part=="all"){
        t = grid*1.5;
        translate([-t*1.25,0,-altura/2]) angle(90);
        translate([-t,-t,0]) 
        linear_extrude(height=1)
        text(text=str("All parts:",grid,"mm x ",(altura*levels),"mm"),size=14);
    }

}


//angle(90);
module angle(ang){
    union(){
    for(i=[0:levels-1]){
        difference(){
            rotate([90,0,0]) arc([altura*(i),altura*(i+1),grosor],0,ang);
            
            rotate([0,90-ang,0]) translate([0,-grosor*0.5,altura*(i)+altura*0.5]){
                translate([0, 0,-altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                translate([0, 0,altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
            }
            rotate([0,90,0]) translate([0,-grosor*0.5,altura*(i)+altura*0.5]){
                translate([0, 0,-altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                translate([0, 0,altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
            }
        }
    }
}
}

 



module complete_set(){
    t = grid*1.5;
    tile4();
    translate([t,0,0]) tile3();
    translate([0,t,0]) tileCorner();
    translate([t,t,0]) tile2();
    translate([-t,t,0]) tile1();
}

module tile1(){
    union(){
        difference(){
            translate([-grid*0.25,0,0]) cube([grid*0.5,grosor,altura],center = true);
                rotate([0,0,180]){
                    translate([grid*0.5,0,-altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                    translate([grid*0.5,0,altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                }
        }
        cylinder(r=grosor/2,h=altura,center = true);
    }
}

module tile2(){
    difference(){
        cube([grid,grosor,altura],center = true);
        for(i=[0:180:180]){
            rotate([0,0,i]){
                translate([grid*0.5,0,-altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                translate([grid*0.5,0,altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
            }
        }
    }
}

module tileCorner(){
    intersection(){
        cube([grid,grid,altura],center = true);
        difference(){
            translate([-grid/2,-grid/2,0]) cylinder(r=grid/2+grosor/2,h=altura,center = true);
            translate([-grid/2,-grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
            for(i=[180:90:270]){
                rotate([0,0,i]){
                    translate([grid*0.5,0,-altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                    translate([grid*0.5,0,altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                }
            }
        }
    }
}


module tile3(){
    difference(){
        translate([0,(-grid+grosor)*0.25,0])
        cube([grid,grid/2+grosor/2,altura],center = true);
        translate([grid/2,grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        translate([grid/2,-grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        translate([-grid/2,grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        translate([-grid/2,-grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        
        //cylinder(r=grid/5,h=altura+0.01,center = true);

        for(i=[180:90:360]){
            rotate([0,0,i]){
                translate([grid*0.5,0,-altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                translate([grid*0.5,0,altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
            }
        }
        
    }
            //cube([grid-pinheight,grosor,altura],center = true);

}
module tile4(){
    
    difference(){
        cube([grid,grid,altura],center = true);
        translate([grid/2,grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        translate([grid/2,-grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        translate([-grid/2,grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        translate([-grid/2,-grid/2,0]) cylinder(r=grid/2-grosor/2,h=altura+0.01,center = true);
        
        cylinder(r=grid/6,h=altura+0.01,center = true);

        for(i=[0:90:270]){
            rotate([0,0,i]){
                translate([grid*0.5,0,-altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
                translate([grid*0.5,0,altura*0.25]) rotate([0,90,0]) cylinder(r=pinradius,h=pinheight,center = true,$fn=20);
            }
        }
        
    }
}


module arc(size, a1,a2){
    rout = max(size[0],size[1]);
    rin = min(size[0],size[1]);
    altura = size[2];
    ang1 = min(a1,a2);
    ang2 = max(a1,a2);

    if(ang2-ang1>=360){
        difference(){
            cylinder(r=rout,h=altura);
            translate([0,0,-0.05]) cylinder(r=rin,h=altura+0.1);
        }
    }else{
        ang = (ang2-ang1) / $fn;

        pout = [ for (i = [ 0 : $fn ]) let (x1 = rout*cos(ang1+i*ang),y1 = rout*sin(ang1+i*ang)) [ x1,y1 ] ];
        pin = [ for (i = [ 0 : $fn ]) let (x1 = rin*cos(ang1+i*ang),y1 = rin*sin(ang1+i*ang)) [ x1,y1 ] ];
    
        puntos = [for (i = [ 0 : $fn*2+1 ]) (i<=$fn) ? pout[i] : pin[$fn+1-( (i-$fn) )] ];
    
    
        linear_extrude(height=altura) polygon(points=puntos);
    }

    
}