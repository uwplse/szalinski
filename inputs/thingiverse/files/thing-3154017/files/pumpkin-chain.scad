numbers = 3;

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 90.
// Parameters: 
//     radius - the arc radius 
//     angle - the arc angle 
//     width - the arc width 
module a_quarter_arc(radius, angle, width = 1) {
    outer = radius + width;
    intersection() {
        difference() {
            offset(r = width) circle(radius, $fn=48); 
            circle(radius, $fn=48);
        }
        polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
    }
}

// Given a `radius` and `angles`, draw an arc from `angles[0]` degree to `angles[1]` degree. 
// Parameters: 
//     radius - the arc radius 
//     angles - the arc angles 
//     width - the arc width
module arc(radius, angles, width = 1) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;
    outer = radius + width;
    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_arc(radius, angle_difference, width);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            arc(radius, [0, 90], width);
            rotate(90) a_quarter_arc(radius, angle_difference - 90, width);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            arc(radius, [0, 180], width);
            rotate(180) a_quarter_arc(radius, angle_difference - 180, width);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            arc(radius, [0, 270], width);
            rotate(270) a_quarter_arc(radius, angle_difference - 270, width);
       }
}

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

function __is_vector(value) = !(value >= "") && len(value) != undef;
      
function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

function __shape_pie(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        leng = radius * cos(a_step / 2),
        angles = __is_vector(angle) ? angle : [0:angle],
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        edge_r_begin = leng / cos((m - 0.5) * a_step - angles[0]),
        edge_r_end = leng / cos((n + 0.5) * a_step - angles[1]),
        shape_pts = concat(
            [[0, 0], __ra_to_xy(edge_r_begin, angles[0])],
            m > n ? [] : [
                for(i = [m:n]) 
                    let(a = a_step * i) 
                    __ra_to_xy(radius, a)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(edge_r_end, angles[1])]
        )
    ) shape_pts;
    
/**
* pie.scad
*
* Creates a pie (circular sector). You can pass a 2 element vector to define the central angle. Its $fa, $fs and $fn parameters are consistent with the circle module.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-pie.html
*
**/   
module pie(radius, angle) {
    polygon(__shape_pie(radius, angle));
}


// a ring for connecting pumpkins.
// Parameters:
//     radius - the ring radius
//     thickness - the ring thickness
//     spacing - the spacing while two rings are connecting together
module a_ring_between_pumpkins(radius, thickness, spacing) {
	union() {
		linear_extrude(thickness) 
			arc(radius, [0, 240], radius / 1.5);
			
		translate([0, 0, thickness + spacing]) linear_extrude(thickness) 	
			arc(radius, [240, 360], radius / 1.5);
			
		linear_extrude(thickness * 2 + spacing) arc(radius, [0, 20], radius / 1.5);
		
		linear_extrude(thickness * 2 + spacing) arc(radius, [220, 240], radius / 1.5);	
	}
}

module pumpkin(h_radius, thickness) {
    module eye() {
        translate([-h_radius / 2.25, h_radius / 1.75, 0])  rotate(-25) scale([1.25, 0.8, 1]) circle(h_radius / 4, $fn = 3);
    }
         
   module mouth() {
       difference() {
            translate([0, -h_radius / 12, 0]) scale([1.75, 1, 1]) pie(radius = h_radius / 5 * 2, angle = [160, 380]);  
       
           union() {     
               translate([0, -h_radius/ 7, 0]) rotate(5) square(h_radius / 5, center = true);
               
               translate([h_radius/ 3, -h_radius / 2.5, 0]) rotate(-7) square(h_radius / 4.5, center = true);

               translate([-h_radius/ 3, -h_radius / 2.5, 0]) rotate() square(h_radius / 4.8, center = true);   
           }    
       }       
   }         
   
   
   color("orange") difference() {
       linear_extrude(thickness) translate([0, h_radius / 4, 0]) 
             scale([1, 0.9, 1]) circle(h_radius);
             
       linear_extrude(thickness * 2) union() {   
           eye();
           mirror([1, 0, 0]) eye();   
           
           translate([0, h_radius / 5, 0]) rotate(90) circle(h_radius / 7, $fn = 3);
       
           mouth();
       }
   }
   
   color("black") linear_extrude(thickness / 2) translate([0, h_radius / 4, 0]) 
             scale([1, 0.9, 1]) circle(h_radius);
}

// a pumpkin with two rings
//     Parameters:
//         pumpkin_width - the width of the pumpkin
//         pumpkin_thickness - the thickness of the pumpkin
//         spacing - the spacing between rings
module pumpkins_with_rings(pumpkin_width, pumpkin_thickness, spacing) {
	radius_for_pumpkin = 0.5 * pumpkin_width / (1 + cos(45));
	ring_radius = radius_for_pumpkin / 3;
	ring_x = pumpkin_width / 2 + spacing;
	ring_thickness = 0.5 * (pumpkin_thickness - spacing);
	
	
    pumpkin(pumpkin_width / 2, pumpkin_thickness);

    color("black") union() {
        translate([ring_x * 1.075, radius_for_pumpkin * sin(60), 0]) 
            rotate(-40) 
                a_ring_between_pumpkins(ring_radius, ring_thickness, spacing); 

        translate([-ring_x * 1.075, radius_for_pumpkin * sin(60), 0]) 
            rotate(125) 
                a_ring_between_pumpkins(ring_radius, ring_thickness, spacing);
    }
}

// create a pumpkin chain
//     Parameters:
//         ch - the character
module pumpkin_chain(n) {
	pumpkin_thickness = 2.5;
	pumpkin_width = 18;
	spacing = 0.5;
	init_angle = 720;
	ray_length = 20;
	steps = n;
	step_distance = 23.8;
	children_per_step = 1;

	function PI() = 3.14159;
	 
	function find_angles(angles, ray_length, step_distance, n, i = 1) =
		i == n ? angles :
			find_angles(concat(angles, [angles[i - 1] + step_distance * 64800 / (PI() * angles[i - 1] * ray_length)]), ray_length, step_distance, n, i + 1);

	module archimedean_spiral(init_angle, ray_length, step_distance, steps, children_per_step) {
		a = ray_length / 360;
		angles = find_angles([init_angle], ray_length, step_distance, steps);
		
		for(i = [1:steps]) {
			angle = angles[i - 1];
			r = a * angle;
			rotate(angle) 
				translate([r, 0, 0]) 
					rotate(90) 
                        pumpkins_with_rings(pumpkin_width, pumpkin_thickness, spacing);
			
		}
	}

	archimedean_spiral(init_angle, ray_length, step_distance, steps, children_per_step);
}

pumpkin_chain(numbers);

