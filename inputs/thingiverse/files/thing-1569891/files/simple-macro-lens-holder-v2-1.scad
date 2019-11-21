// Customizable Simple Macro Lens Holder 
//
// Default parameters are for the lens:
//      Size: 7 x 3.3 mm
//      BFL : 6.47 mm
//      ELF : 8.0 mm
//
//  2016.05.18 by gsyan
//
//  update : 2016.05.22
//

//preview[view:south west, tilt:top diagonal];

/* [Parameters] */

//Default parameters are for the lens : Size: 7 x 3.3 mm , BFL : 6.47 mm , ELF : 8.0 mm
lens_diameter = 7.04;

lens_height = 3.3;

//Increase this value you can plug more than 1 lens
lens_total = 1;

//Lens distance adapt for lens_total > 1
lens_distance = 0;

lens_holder_wall_thickness = 1.6;

//
keychain_ring = "true"; //[true:enabled,false:disabled]


rubber_band_holder_shape = "prism"; //[cylinder:cylinder, prism:prism]
rubber_band_holder_height = 2;
rubber_band_holder_width = 8;


keychain_ring_outer_diameter = 4.6;
keychain_ring_inner_diameter = 3.2;
keychain_ring_height = 2;

/* [Hidden] */
fn = 36;
base_rounded_radius = 0; //0.8;
keychain_offset = 0.5;
lens_holder_support_size = 2.4;

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module lens_holder_support() {
    resize([lens_holder_support_size+lens_diameter+lens_holder_wall_thickness/2,lens_diameter+lens_holder_wall_thickness,lens_height/2])   
        cylinder(h=lens_height/2,d1=lens_holder_support_size+lens_diameter+lens_holder_wall_thickness/2,d2=lens_diameter+lens_holder_wall_thickness/2,$fn=8);
}

module ring_support() {
    difference() {
        translate([keychain_ring_outer_diameter/2-1-keychain_offset,keychain_ring_outer_diameter/2,0]) 
            rotate([0,0, -90]) 
                prism(keychain_ring_outer_diameter,1,lens_height-keychain_ring_height);
        
        difference() {
            translate([keychain_ring_outer_diameter/-2,keychain_ring_outer_diameter/-2-0.1,-0.1]) 
                cube([ keychain_ring_outer_diameter-keychain_offset+0.01,keychain_ring_outer_diameter+0.2, lens_height-keychain_ring_height+0.2]);
            translate([0,0, -0.1])            cylinder(h=keychain_ring_height+0.2, r=keychain_ring_outer_diameter/2, $fn=36);
        }
        
    }
}

module rubber_band_holder_cylinder() {
    union() {
        rotate(a=[90,0,0]) 
            cylinder(h=rubber_band_holder_width+1, d=rubber_band_holder_height, $fn=36);

        translate([0,(rubber_band_holder_width+1)*-1, rubber_band_holder_height/2-0.1]) 
            cube([0.1, rubber_band_holder_width+1,1]);
    }
}

module rubber_band_holder_prism() {
    resize([rubber_band_holder_height, rubber_band_holder_width+0.2, rubber_band_holder_height+0.1]) rotate([135,0,90]) prism(10, 10, 10);
}
module ring() {
    difference() {
        union() {
            cylinder(h=keychain_ring_height, r=keychain_ring_outer_diameter/2, $fn=36);
            translate([0,0,keychain_ring_height]) ring_support();
        }
        translate([0,0,-10]) cylinder(h=keychain_ring_height+20, r=keychain_ring_inner_diameter/2, $fn=36);
    }
}

module rounded(size, r) {
    //2 cube + 4 cylinder
    fn = 18;
    union() {
        translate([r, 0, 0]) cube([size[0]-2*r, size[1], size[2]]);
        translate([0, r, 0]) cube([size[0], size[1]-2*r, size[2]]);
        
        translate([r, r, 0]) cylinder(h=size[2], r=r, $fn=fn);
        translate([size[0]-r, r, 0]) cylinder(h=size[2], r=r, $fn=fn);
        translate([r, size[1]-r, 0]) cylinder(h=size[2], r=r, $fn=fn);
        translate([size[0]-r, size[1]-r, 0]) cylinder(h=size[2], r=r, $fn=fn);
    }
}

module base() {        
    union() {
        //base : cube
        translate([0, rubber_band_holder_width/-2, 0]) 
        rounded([lens_diameter+lens_holder_wall_thickness+rubber_band_holder_height*4,rubber_band_holder_width, lens_height],base_rounded_radius);
    
        //base : cylinder    
        translate([(lens_diameter+lens_holder_wall_thickness+rubber_band_holder_height*4)/2, 0, 0])
        cylinder(h=lens_height*lens_total+lens_distance*(lens_total-1), r=(lens_diameter+lens_holder_wall_thickness)/2, $fn=fn);
        
        //lens holder support
        if(lens_total > 1) translate([(lens_diameter+lens_holder_wall_thickness+rubber_band_holder_height*4)/2, 0, lens_height])
        lens_holder_support();
        
        //keychain ring
        if(keychain_ring == "true") translate([keychain_offset-keychain_ring_outer_diameter/2,0])       ring();
    }
}
module holder() {
    difference() {
        base();
        
        //lens hole
        translate([(lens_diameter+lens_holder_wall_thickness+rubber_band_holder_height*4)/2, 0, -0.1])
        cylinder(h=lens_height*lens_total+lens_distance*(lens_total-1)+1, r=(lens_diameter+0.2)/2, $fn=fn);
        
        //Ruber Band Holder hole
        
        if( rubber_band_holder_shape == "cylinder") {

        
        //left rubber band hole
        translate([rubber_band_holder_height+0.4, (rubber_band_holder_width+1)/2,lens_height-rubber_band_holder_height/2])
            rubber_band_holder_cylinder();
            
        //right rubber band hole
        translate([lens_diameter+lens_holder_wall_thickness+rubber_band_holder_height*3-0.4, (rubber_band_holder_width+1)/2,lens_height-rubber_band_holder_height/2])
            rubber_band_holder_cylinder();     
        } 
        else {
            
        //left rubber band hole
        translate([rubber_band_holder_width/8+0.4,rubber_band_holder_width/-2-0.1,lens_height+0.1-rubber_band_holder_height])         
        rubber_band_holder_prism();

        //right rubber band hole
        translate([lens_diameter+lens_holder_wall_thickness+rubber_band_holder_height*2.5-0.4,rubber_band_holder_width/-2-0.1,lens_height+0.1-
        rubber_band_holder_height]) rubber_band_holder_prism();
        }

    }
}

holder();

