base_lenght=33.4;
base_width=12;
base_height=4;

holder_base_height=1.6;
holder_lenght=12;
holder_width=12;
holder_height=5;

hole_margin=4.5;
space_between_holes=24;
hole_diameter=3.7;
bolt_head_diameter=7;
bolt_head_hole_depth=2;

chain_diameter=3.8;
chain_ball_space=1.2;

wire_diameter=1.5;
spacing=0.1;

$fn=100;

Assembly();

module Assembly(){
    difference (){
        union(){
            cube([base_lenght,base_width,base_height],center=true);
            translate([0,0,base_height]){
                difference(){
                    cube([holder_lenght,holder_width,holder_height],center=true);
//wire_ball_hole                    
                    translate([-holder_lenght-chain_ball_space/2,chain_diameter/2+spacing*5,holder_base_height]) rotate([0,90,0]) cylinder(d=chain_diameter, h=holder_lenght, center=false);
                    translate([-holder_lenght-chain_ball_space/2,-chain_diameter/2-spacing*5,holder_base_height]) rotate([0,90,0]) cylinder(d=chain_diameter, h=holder_lenght, center=false);
                    
                    
                    translate([chain_ball_space/2,chain_diameter/2+spacing*5,holder_base_height]) rotate([0,90,0]) cylinder(d=chain_diameter, h=holder_lenght, center=false);
                    translate([chain_ball_space/2,-chain_diameter/2-spacing*5,holder_base_height]) rotate([0,90,0]) cylinder(d=chain_diameter, h=holder_lenght, center=false);
//wire_hole_small                    
                    translate([-holder_lenght/2,-chain_diameter/2-spacing*5,holder_base_height]) rotate([0,90,0]) cylinder(d=wire_diameter, h=holder_lenght, center=false);
                    translate([-holder_lenght/2,chain_diameter/2+spacing*5,holder_base_height]) rotate([0,90,0]) cylinder(d=wire_diameter, h=holder_lenght, center=false);
                    
                    translate([-holder_lenght/2,-chain_diameter/2-spacing*5,holder_base_height+wire_diameter/2]) rotate([0,90,0]) cylinder(d=wire_diameter, h=holder_lenght, center=false);
                    translate([-holder_lenght/2,chain_diameter/2+spacing*5,holder_base_height+wire_diameter/2]) rotate([0,90,0]) cylinder(d=wire_diameter, h=holder_lenght, center=false);
                };
                
            };
        };
//bolt hole
        translate([base_lenght/2-hole_margin,0,0])cylinder(d=hole_diameter,h=base_height*2, center=true);
        translate([-(base_lenght/2-hole_margin),0,0])cylinder(d=hole_diameter,h=base_height*2, center=true);  
//bolt head hole
        translate([base_lenght/2-hole_margin,0,base_height/2-bolt_head_hole_depth/2])cylinder(d=bolt_head_diameter,h=bolt_head_hole_depth, center=true);
        translate([-(base_lenght/2-hole_margin),0,base_height/2-bolt_head_hole_depth/2])cylinder(d=bolt_head_diameter,h=bolt_head_hole_depth, center=true);        
      
        
    };
    
    };