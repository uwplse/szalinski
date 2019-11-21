// Hairband
// Version 1.0
// Luigi Cisana, 12 Jun, 2013

// preview[view:south, tilt:top diagonal]

inner_diameter=140; // [100:180]

inner_height=145;  // [80:180]

// [unit = 1/10 mm]
width=40;  // [30:200]

// [unit = 1/10 mm]
thickness=30; // [25:50]

// [unit = 1/10 mm]
curvature_radius=25; // [20:400]

// Number of facets, set a low value for a draft version
fn = 120; // [30:200]

// Add Partial Brim (20 x 20 mm)?
partial_brim = "yes"; // [yes,no]

/* [Hidden] */

/****** Init *********/
ir = inner_diameter/2;
ih = inner_height;
wi = width/10;
cr = curvature_radius/10;
tn = thickness/10;

angle = 12;
layer = 0.25;

r1 = ir;
r2 = 2*ir;
s1 = r1+wi;
s2 = r2+wi;

a1 = ir * sin(angle);
a2 = ih-ir-a1;
alpha = atan(a2 / (2*ir));

echo("a1= ", a1, "a2 =", a2, "alpha= ", alpha);


/****** Main *********/
semi_band();
translate ([-0.1,0,0]) mirror ([1,0,0]) semi_band();


/****** Modules ******/
module semi_band() {
	rotate(a=[0,0,angle]) {
		intersection() {
			shap_ring(r1);

			linear_extrude(height = 2*wi, center = true, convexity = 10, twist = 0)
				polygon( points=[[0,0],[-s1,0],[-s1,s1],[s1*tan(angle),s1],[0,0]] );
		}

		translate([ir,0.1,0]) {

			difference() {
				intersection() {
					shap_ring(r2);

					linear_extrude(height = 2*wi, center = true, convexity = 10, twist = 0)
						polygon( points=[[0,0],[-s2,0],[-s2,-s2*tan(alpha)],[0,0]] );
				}

				rotate(a=[0,0,alpha]) translate([-r2,0,0])
				difference() {
					cube(size=[2*tn,2*tn,2*wi],center=true);
					translate([-tn,tn,0]) cylinder(h=2*wi,r=tn,center=true,$fn=50);
				}
			}

			if (partial_brim == "yes") {
		 		rotate(a=[0,0,180+alpha-12]) translate([r2-10,0,-wi/2]) cube(size=[20,20,layer],center=false);
			}
		}
	} // rotate
} // semi_band


module shap_ring(radius) {
	rotate_extrude(convexity = 10,$fn=fn) translate([radius+tn-cr, 0, 0]) {
		intersection() {
			circle(r = cr,$fn=fn);
			translate ([-tn+cr,-wi/2,0]) square ([tn,wi], center=false);
		}
	}
} 










