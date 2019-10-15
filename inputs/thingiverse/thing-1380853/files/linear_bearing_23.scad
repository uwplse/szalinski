
/*
    Openscad rotational bearing based Linear Bearing .
    
    Copyright (C) 2017. Fernando Jiménez Díaz-Universidad Santo Tomas TUNJA
    
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

shaft_radius = 4;
outer_bearing_radius = 11;
inner_bearing_radius = 4;
bearing_thick = 7;
washer_thick = 1;
thickness=5;
//nut1_diameter=12;



hole_distance=40;
hole_diameter=5;
nut2_diameter=8;

number_of_stacks=1;


module bearing(){
    $fn=50;
    difference(){
        cylinder(r=outer_bearing_radius,h=bearing_thick,center=true);
        cylinder(r=inner_bearing_radius,h=bearing_thick*1.5,center=true);
    }
    
}
module washer(){
    $fn=50;
    //cylinder(r=outer_bearing_radius,h=bearing_thick+2*washer_thick,center=true);
    hull(){
        translate([0,0,-washer_thick/2])cylinder(r=inner_bearing_radius+1,h=washer_thick,center=false);
        translate([0,0,-washer_thick/2])cylinder(r=inner_bearing_radius+2,h=washer_thick/2,center=false);      
        
    }
    
}

module shaft(){
    $fn=50;
    cylinder(r=shaft_radius,h=2*outer_bearing_radius, center=false);
}



module wall(){
    
    $fn=50;
    translate([-thickness/2,,0])difference(){
        union(){
            cube([thickness,shaft_radius+(outer_bearing_radius*2)+thickness+1,(1+outer_bearing_radius)*2],center=false);
            
            translate([-((washer_thick)/2),shaft_radius+outer_bearing_radius,(1+outer_bearing_radius)])rotate([0,-90,0])washer();
            
            
            
        }
        //translate([3*thickness/4,shaft_radius+outer_bearing_radius,(1+outer_bearing_radius)])rotate([0,90,0])nut(nut1_diameter);
        
        
        
        
        translate([thickness/2,shaft_radius+outer_bearing_radius,(1+outer_bearing_radius)])rotate([0,90,0])cylinder(r=inner_bearing_radius,h=4*thickness, center=true);
        }
     
    

}



module piece(show_bearing=false){
   $fn=50;
    
   difference(){
       for(i=[0,120,240]){
       
       rotate([0,0,i])union(){
           translate([((thickness+2*washer_thick+bearing_thick)/2),0,0])wall();
           mirror()translate([((thickness+2*washer_thick+bearing_thick)/2),0,0])wall();
           
           translate([0,2*outer_bearing_radius+shaft_radius+thickness/2+1,(1+outer_bearing_radius)])cube([2*(thickness+washer_thick)+bearing_thick,thickness,(1+outer_bearing_radius)*2],center=true);
           
           
           
           }
           
       } 
       cylinder(r=shaft_radius+2,h=5*(1+outer_bearing_radius), center=true);
   }
   
   translate([0,2*outer_bearing_radius+shaft_radius+thickness/2+1,(1+outer_bearing_radius)])top();
   
   if(show_bearing==true){
       for(i=[0,120,240]){
            rotate([0,0,i])translate([0,outer_bearing_radius+shaft_radius,(1+outer_bearing_radius)])rotate([0,90,0])bearing();
       }
   }
    
}

module  top(){
    $fn=20;
    difference(){
        cube([hole_distance+2*nut2_diameter+4,thickness,(1+outer_bearing_radius)*2],center=true);
        
        translate([hole_distance/2,-thickness/4,0])rotate([90,0,0])nut(nut2_diameter);
        translate([-hole_distance/2,-thickness/4,0])rotate([90,0,0])nut(nut2_diameter);
        
        translate([hole_distance/2,-thickness/4,0])rotate([90,0,0])cylinder(d=hole_diameter,h=2*thickness,center=true);
        
        translate([-hole_distance/2,-thickness/4,0])rotate([90,0,0])cylinder(d=hole_diameter,h=2*thickness,center=true);
    }
        
}

module nut(d){
    $fn=6;
    rotate([0,0,90])cylinder(d=d/cos(30),h=1+thickness/2,center=true);
}



module linear_bearing(){
    
    for(i=[0:number_of_stacks-1]){
        translate([0,0,i*(1+outer_bearing_radius)*2])piece();
    }
    
}

module pin(){
    $fn=50;
    x=sqrt(2*(pow(inner_bearing_radius,2)));
    intersection(){
        difference(){
            union(){
                cylinder(r=inner_bearing_radius,h=(bearing_thick+(washer_thick*2)+(thickness*2))/2,center=false);
                translate([0,0,(inner_bearing_radius)+((bearing_thick+(washer_thick*2)+(thickness*2))/2)])sphere(r=x, center=true);
            }
            translate([0,0,(x-inner_bearing_radius)+1*(bearing_thick+(washer_thick*2)+(thickness*2))/4])union(){
    translate([0,0,(bearing_thick+(washer_thick*2)+(thickness*2))/2])cube([2*(x-inner_bearing_radius),2*x,(bearing_thick+(washer_thick*2)+(thickness*2))/1],center=true);

    rotate([90,0,0])cylinder(d=2*(x-inner_bearing_radius),h=2*x,center=true);
            }
        }
        translate([0,0,0])cube([3*(inner_bearing_radius),2.5*sqrt((pow(inner_bearing_radius,2))/2),2*(bearing_thick+(washer_thick*2)+(thickness*2))],center=true);
        
        scale([1.5*(inner_bearing_radius),2*sqrt((pow(inner_bearing_radius,2))/2),1*(bearing_thick+(washer_thick*2)+(thickness*2))])sphere(r=1);
    }
}


for(i=[0,1,2]){
    translate([-20+i*20,5*outer_bearing_radius,(2.5*sqrt((pow(inner_bearing_radius,2))/2))/2])union(){
        rotate([90,0,0])pin();
        rotate([-90,0,0])pin();
    }
}
linear_bearing();

/*
union(){
    rotate([90,0,0])pin();
    rotate([-90,0,0])pin();
}*/
//translate([0,outer_bearing_radius+shaft_radius,(1+outer_bearing_radius)])rotate([0,90,0])bearing();



//shaft();

//wall();

//top();

//case();


