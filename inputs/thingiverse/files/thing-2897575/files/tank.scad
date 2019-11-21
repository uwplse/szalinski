

/*hull of vehicle*/
vehicle_breadth = 50;
vehicle_length = 100;
vehicle_height = 10;
wheel_radius = 10; 
bottom_wheel_offset_from_front = 20;
bottom_wheel_offset_from_back = 10;

/*pivot point between body/hull and turret*/ 
pivot_diameter = 30;
pivot_offset_from_vehicle_front = 60; //how far turret is from front
turret_hull_gap =5; //gap between turret and hull


/*gun*/
gun_length=40;
gun_diameter =10;
show_muzzle = 1;//[0:hide, 1:show]
muzzle_diameter=14;
muzzle_length=8;

/*turret*/
turret_length = 80;
turret_narrow_breadth = 40;
turret_wide_breadth = 50;
turret_height = 20;
turret_side_offset_from_front =30; 

turret_side_offset_from_side = turret_wide_breadth -turret_narrow_breadth; 
turret_center_front =  turret_narrow_breadth/2 ;
turret_center_side =  turret_length/2 ;

vehicle_body(); 
turret();
gun();

/*GUN RELATED*/
module gun(){
    
    rotate([ 0,90,0])
    translate([ -gun_diameter/2,turret_center_front,-gun_length]){
        cylinder(d=gun_diameter, h=gun_length);
        translate ([0,-gun_diameter/2,0])
        cube([gun_diameter/2, gun_diameter, gun_length]); 
    }  
     
    if(show_muzzle){ 
        muzzle();
    }
        

    module muzzle(){ 
            
        muzzle_bottom = muzzle_diameter-gun_diameter;
        
        rotate([ 0,90,0])
        translate([ 0,turret_center_front,-(gun_length+muzzle_length)])
        { 
            difference(){
                translate([-(muzzle_bottom),0,0]) 
                cylinder(d=muzzle_diameter, h=muzzle_length); 
                translate([0,-muzzle_diameter/2,0])
                cube ([muzzle_diameter, muzzle_diameter, muzzle_length]);
        } 
        translate([-muzzle_bottom,-muzzle_diameter/2,0])
        cube([muzzle_bottom, muzzle_diameter,muzzle_length]);
           
        }
        
    }
}

/*TURRET RELATED*/
module pivot_turret(){
    translate([turret_center_side, turret_center_front,-turret_hull_gap])
sphere(d=pivot_diameter);
}


module turret(){
    difference(){
        hull(){
        cube( [turret_length, turret_narrow_breadth, turret_height] );

        translate([turret_side_offset_from_front,-turret_side_offset_from_side,0])
        cylinder(d=10, h=turret_height);
            
        translate([turret_side_offset_from_front, turret_side_offset_from_side+ turret_narrow_breadth ,0])
        cylinder(d=10, h=turret_height);

        } 
        
        pivot_turret();
    }
}

/*HULL RELATED*/
module pivot_hull(){ 
translate([pivot_offset_from_vehicle_front, 
     wheel_radius,
     vehicle_breadth/2  ])
        sphere(d=pivot_diameter);
}

module vehicle_body(){ 
    
    module wheel() cylinder(r=wheel_radius, h=vehicle_breadth); 
    vehicle_bottom_front_xy = [ bottom_wheel_offset_from_front, -vehicle_height ]; 
    vehicle_bottom_back_xy = [ vehicle_length - bottom_wheel_offset_from_back, -vehicle_height];
         
    
    rotate([90,0,0])
    translate([-gun_length,vehicle_height+wheel_radius, turret_side_offset_from_side+15 ]){
        hull(){
        wheel();
        translate([vehicle_length,0 ]) wheel();
        translate(vehicle_bottom_front_xy)
        wheel();
        translate(vehicle_bottom_back_xy)
        wheel();
        } 
        
        pivot_hull();
    }
}



