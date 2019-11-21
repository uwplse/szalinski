//  The Whirly with Spin Stick
//  based on:
//
// The Whirly One
//  by seedwire (see Below)
//
//  Adapted by cstelter to add spin stick system
//
//  Note, I have not tried printing the string thing nor the handle 
//  after my rework-- I was primarily trying to make the spin stick, but 
//  after I was reasonably successful with that, I tried to fix up the file
//  again so that it could still do what it was originally designed to do.
//
//  I changed quite a bit of the math for the blade pitch and offsets.  My
//  main concern is that the default value of 5mm for the 'handle'
//  when building the string spinner may not be the best value for use in the
//  string spinner.


// Original header from which this was adapted
// The Whirly One
//  by seedwire
//
//  A whirly copter-like thing inspired by the venerable wooden namesake.
//  N.B. requires good first and second layer bed adhesion.
//
//  Also doubles as a simple pin-wheel, or fan rotor...
//
//  Best sliced with 2 shells at 10% infill


//Options:

//Choose Configuration
select_configuration=0;//[0:Spin Stick,1:String Pull,2:Handle]

//If String Pull selected
print_handblock=1;

//If Spin Stick is selected
print_spinStick=1;

//If Spin Stick is selected
print_pusher=1;

//Optionally print the blade assembly
print_rotors=1;

//Optionally print an outer ring on the blade assembly.  Outer ring will print regardless of this setting if rounded edges are deselected.
print_outer_ring=1;

//Optionally round the blade ends.  Blades are 'blade_width' longer than blade radius if rounded ends are printed.
print_rounded_blade_ends=0;

//Length of blade from center to optional outer circle
blade_radius = 45;             //How large the outer circle for blades is

//Width of blade face measured along pitch
blade_width = 10;               //linear width of each blade

//Thickness of blade
blade_thickness = 0.9;         //How thick each blade is

//Angle of blade from horizontal (degrees)
blade_pitch = 30;              //How slanted from horizontal (degrees)

//Height of spiral section of spin stick (handle will be 1/5 of this)
spiral_height=125;             //How long the spin stick is (minus handle)

//Number of degrees the blades will rotate over 1 cm of travel along the stick
twistDegreesPerCentimeter=120; //How many degrees the spindle turns per cm

//long dimension of spiral post
slot_width=8;                  //The width of the spiral stem (long dim)

//short dimension of spiral post
slot_height=2;                 //the thickness of the spiral stem (short dim)

//wall thickness of the slider/pusher
slider_thickness=1;            //Thickness of all wall in the pusher/slider

//air gap between 2 moving parts
material_gap=0.6;              //air gap between any 2 plastic moving parts
                               //Note, this is on each side, so the hole in
                               //the copter is this distance times 2 larger
                               //than the dimensions of slot_width and slot_height
                               
//Number of roters                               
num_rotors=4;

//Length of handle in "Handle" configuration
handleLength=125;


//Select configuration.  Set to one of "Spin Stick", "String Pull", or "Handle".



spin_stick_config=1*(select_configuration==0 ? 1 : 0);
handle_config=1*(select_configuration==2 ? 1 : 0);;
string_pull_config=1*(select_configuration==1 ? 1 : 0);;

//  Set the value just before the semicolon at the end.  
//  Parts that aren't included in the config above will automatically be deslected



handblock = 1*(string_pull_config==0 ? 0 : print_handblock);     
outer_ring = print_rounded_blade_ends ? print_outer_ring : 1;
rotors = print_rotors;
spin_stick= 1*(spin_stick_config==0 ? 0 : print_spinStick);
pusher= 1*(spin_stick_config==0 ? 0 : print_pusher);
handle_length=1*(handle_config==0 ? 5 :handleLength); //How long the handle should be in handle_config mode.  
rounded_ends=print_rounded_blade_ends;

spin_handle_height=spiral_height/5;
slot_radius=sqrt(slot_width*slot_width+slot_height*slot_height)/2;
inner_ring_radius=slot_radius*1.5;
inner_ring=inner_ring_radius*2;
handle_base=slot_width*1.25;
copter_height=blade_width*sin(blade_pitch);
blade_blunt=(blade_thickness/sin(blade_pitch)-blade_thickness)/2;          //avoid sharp edge on blade by cutting flat this far from edge
$fn=100;


if(rotors == 1) {
    if(spin_stick_config==1) 
        difference(){ 
            union() {
   	            cylinder(r1=inner_ring_radius, 
                         r2=inner_ring_radius, 
                         h=copter_height);

	            // some rotors
	            build_rotors(blade_width,blade_thickness);
            }
            linear_extrude(height = spiral_height, 
                           center = false, 
                           convexity = 10, 
                           twist = twistDegreesPerCentimeter*spiral_height/10, 
                           slices = spiral_height*10)
                square([slot_width+2*material_gap,slot_height+2*material_gap],true);
        }
    else {
       union() { 
			//cylinder(r=2, h=handle_length-4.75/2.1);
			cylinder(r1=4.75*sqrt(2), r2=(blade_width*cos(blade_pitch)+blade_thickness*sin(blade_pitch))/2, h=copter_height);
			translate([-4.75/2.0,-4.75/2.0,0]) cube([4.75,4.75,handle_length+copter_height], center=false); // key to fit into string spinner thingy...
	
			//sphere(r=2); // alternate end-stop
			//cylinder(r=blade_width/2, h=0.6);
		}
		//translate([0,0,2]) cylinder(r=1, h=handle_length-1);

        // some rotors
        build_rotors(blade_width,blade_thickness);
 
    }       

    // optional outer ring
    if(outer_ring == 1) {
	    difference() {
		    cylinder(r=blade_radius, 
                     h=copter_height);
	     	translate([0,0,-copter_height]) cylinder(r=blade_radius-blade_thickness,
                     h=copter_height*3);
	    }
        
        intersection() {
            outer_radius=blade_radius + (rounded_ends ? blade_thickness : 0);
            build_rotors(outer_radius,blade_thickness*2);
            difference() {
		        cylinder(r=blade_radius+blade_thickness/2, 
                         h=copter_height);
  	            translate([0,0,-copter_height]) cylinder(r=blade_radius-3*blade_thickness/2, h=copter_height*3);
            }
               
        }
    }
}


// The string spinner thingy
if(handblock == 1) {
	translate([blade_radius + 30,-25,-0.3]) union() { 

	rotate([0,0,0]) spinner_thingy();

	// The hand block
	translate([0,35,14]) rotate([180,0,180]) difference() {
		minkowski() { minkowski() { minkowski() { 
			hull() { 
				cube([30,30,15], center=true);
				translate([0,20,0]) cube([15,30,15], center=true);
			}
			translate([0,0,0]) cylinder(r=3, h=1, center=true);
		}
			rotate([90,0,0]) cylinder(r=3, h=1, center=true);
		}
			rotate([0,90,0]) cylinder(r=3, h=1, center=true);
		}
		translate([0,0,-14.01]) scale([1.15,1.15,1.15]) spinner_thingy(0);
	 } 
	}

	translate([112.5,-20,0]) cube([10,80,0.6], center=true);
	translate([87,-20,0]) cube([10,80,0.6], center=true);
	translate([110,-35,0]) cube([80,10,0.6], center=true);
	translate([110,-17,0]) cube([80,5,0.6], center=true);
	translate([110,35,0]) cube([80,10,0.6], center=true);
}


if(spin_stick==1) {
    
    translate([-blade_radius-handle_base-5, 0, 0]){
        union () {
            //Spiral
            translate([0, 0, spin_handle_height])
            linear_extrude(height = spiral_height, 
                           center = false, convexity = 10, 
                           twist = twistDegreesPerCentimeter*spiral_height/10, 
                           slices = spiral_height*10)
                 square([slot_width,slot_height],true);

            //Handle For Spiral
            linear_extrude(height=spin_handle_height, 
                           center=false, convexity=10, 
                           twist=0,    
                           slices=500,scale=0.8)
                square([handle_base,handle_base],true);

            //Little more meat at the handle/spiral junction
            polyhedron(points=[[-slot_height/2,-slot_width/2,spin_handle_height],
                       [-slot_height/2,0,spin_handle_height*1.4],
                       [-slot_height/2,slot_width/2,spin_handle_height],
                       [+slot_height/2,-slot_width/2,spin_handle_height],
                       [+slot_height/2,0,spin_handle_height*1.4],
                       [+slot_height/2,slot_width/2,spin_handle_height]],
                       faces= [[0,1,2],[1,4,5,2],[2,5,3,0],[4,1,0,3],[4,3,5]]);
        }
    }
}

//pusher
if(pusher==1) {
    pusher_brim_radius=slot_radius + material_gap+slider_thickness
                     + spin_handle_height*0.1;
    translate([0,blade_radius + 2*pusher_brim_radius + 5,0])
    difference() {
        union() {
            //Tall part of pusher
            translate([0,0,slider_thickness]) 
                 cylinder(r=slot_radius+material_gap+slider_thickness,
                          h=spin_handle_height/2);
            //brim of pusher
            cylinder(r=pusher_brim_radius,
                     h=slider_thickness);
        }
        //remove space for spiral to fit
        translate([0,0,-spin_handle_height]) cylinder(r=slot_radius+material_gap,
                 h=spin_handle_height*3+slider_thickness);
    }
}

//bladeW and bladeT are for adding meat between outer ring and rotor only.  
//rotor() assumnes that blade_thickness and blade_width still control
//the centering of the blade on the device
module rotor(bladeW,bladeT)
{

    difference() {
        translate([-blade_radius/2,0,blade_width*sin(blade_pitch)/2]) rotate([blade_pitch,0,0]) 
        union () {
            bw=blade_width+blade_thickness/sin(blade_pitch);
            cube([blade_radius,bw,bladeT],true);
            if(rounded_ends) {
                translate([-blade_radius/2,0,0]) cylinder(r=bw/2,h=bladeT,center=true);
            }
        }
        union() {
            translate ([0,0,blade_width*sin(blade_pitch)]) 
                cylinder(r=blade_radius*2,h=blade_width*2);
            translate ([0,0,-blade_width*2]) 
                cylinder(r=blade_radius*2,h=blade_width*2);
              
                   translate ([-blade_radius/2,blade_width/2+(blade_width*cos(blade_pitch)+blade_thickness/sin(blade_pitch))/2-blade_blunt,copter_height/2])
                        cube([blade_radius*2,blade_width,copter_height],true);
        
                    translate ([-blade_radius/2,-blade_width/2-(blade_width*cos(blade_pitch)+blade_thickness/sin(blade_pitch))/2+blade_blunt,copter_height/2])
                        cube([blade_radius*2,blade_width,copter_height],true);  
        }
    }

}

module build_rotors_i(bladeW,bladeT)
{
   	// some rotors
	translate([0,0,0]) rotate([0,0,45]) union() {

	    for(i=[0:num_rotors-1]){
		    rotate([0,0,(360/num_rotors)*i]) rotor(bladeW,bladeT);
	    }
    } 
}
module build_rotors(bladeW,bladeT)
{
   	// some rotors
    if(rounded_ends) {
   	    build_rotors_i(bladeW,bladeT);
    } else {
        difference() {
            build_rotors_i(bladeW,bladeT);
            //if no rounded edges, we force an outer ring for safety and clean
            //up square ends here.
            difference() {
                translate([0,0,-copter_height]) cylinder(r=blade_radius*2,h=copter_height*3);
                translate([0,0,-copter_height]) cylinder(r=blade_radius,h=copter_height*3);
	        }
        }
    }
}

module spinner_thingy(final = 1)
{
 union() { 
	difference() {
		cylinder(r=7, h=15);
		if(final) union() {
			cube([6,6,6], center=true);	// slot for rotor
			translate([0,12,8]) rotate([90,0,0]) cylinder(r=2, h=25); // hole for string
		}
	}
	difference() { 
		translate([0,0,15]) sphere(r=7);
		if(final) translate([0,12,8]) rotate([90,0,0]) cylinder(r=2, h=25); // hole for string
	}
 }

 if(final == 0) {
	translate([0,0,4]) cylinder(r=14, h=11);
	translate([14-4,-12.5,9.5]) cube([8,25,11], center=true);
 }
}
