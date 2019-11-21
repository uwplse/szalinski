// USER PARAMETERS ============================================

// What is measured thickness of your material?
material_thickness = 0.201;

// How many positively-offset slots? (More material) 
n_positive_tests = 3; // [0:20]

// How many negatively-offset slots? (Less material) 
n_negative_tests = 5; // [0:20]

// How much should the edges of each slot be offset?) 
delta = .003;

// Generate a 3D part or a 2D drawing?
output_type = "stl"; //[stl:3D Part, dxf:2D Drawing]

// =============================================================

// ATTENTION: Switch these lines if you're using locally instead of on Thingiverse!!!
// use <Write.scad> // works locally
use <write/Write.scad>	 // works on Thingiverse

// =============================================================

main();

//sign_spacing = sign_width * 1.80;
//base_depth = max(sign_spacing* max(n_positive_tests, n_negative_tests), material_thickness*2);

base_depth = material_thickness * 4.5;
slot_depth = material_thickness * 3;
comb_depth = slot_depth + base_depth;

sample_spacing = (material_thickness*2 + n_positive_tests*delta);
sample_width = sample_spacing + material_thickness;

module make_text(n) {

	// chained ternary operator to assign the text
	txt = (n == 0) ? str(material_thickness) : 
			 (n < 0) ? str(delta*n) : str("+", delta*n);

	// create the text as solid objects
	translate([0,0,-0.1]) //shift down in z
	rotate(90,[0,0,1])  // rotate around the z axis
	write(txt, t=material_thickness+.2, h=material_thickness*.8);
}

module make_sample(n) {
	slot_width = material_thickness - delta*n*2;
	translate([sample_spacing*n, 0, 0])
	difference(){
		translate([-sample_width/2, 0, 0])
		cube([sample_width, comb_depth, material_thickness]);
		union(){
			translate([-slot_width/2, -0.01, -0.1])
			cube([slot_width, slot_depth, material_thickness+0.2]);
			translate([material_thickness*0.4, slot_depth+material_thickness, 0])
			make_text(n);
		}
	}
}

module make_comb(){
    union(){
        for (i = [-n_negative_tests:n_positive_tests]){
            make_sample(i);
        }
    }
}

module main() {
	if (output_type == "stl") {
		make_comb();
	} else if(output_type == "dxf"){		
		projection(cut=true)
		translate([0,0,-material_thickness/2])
		make_comb();
	}
}
