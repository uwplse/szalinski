/*

   Folded dipole antenna

   -------------------     -
  /                   \    | (height)
  \       Gap         /    |
   -------X /----------    -
          |||
          ||| (B)
          |V
      (A) |
	  |
	  |

 Shields of Cable and Balun are soldered together.
 
 */

/* If len set to -1, compute itself the cable lenght. Frequency in MHz */
frequency = 2430;

/* To compute (A) length */
cable_velocity = 0.70;
exposed_velocity = 0.95;

/* height */
height = 15;

/* Gap - keep it small */
gap = 1;

/* Wire diameter */
wire_diameter = 0.8;

/* support height */
support_thickness = 5;
support_beam = 2;

/* openscad cylinder facets */
fn = 100;

/* Final wire with spacer */
wire = wire_diameter + 0.2;

/* Lambda */
lambda = (299792458 / (frequency*1000));

lambda_exposed = lambda * exposed_velocity;

/* (A) Cable length (with all sma connectors) (for information) */
cable_len = (lambda * cable_velocity) / 2;

/* (B) Balun - length of the shielded part - half lambda also */
balun_len = cable_len;

/* Circumference (both sides) */
circ = PI * height;

/* Total length of the exposed wire */
len = lambda_exposed + circ - gap;

/* Segments length */
top_len = ((lambda_exposed/2) - height);
bottom_len = top_len - gap;

echo( "Folded dipole antenna parameters" );
echo( "- Frequency: ", frequency );
echo( "- Lambda: ", lambda );
echo( "- Exposed cable length: ", len );
echo( "- Antenna width: ", lambda_exposed/2 );
echo( "- Top section: ", top_len );
echo( "- Balun cable length (shield): ", balun_len );
echo( "" );
echo( "The whole cable length from the board to the folded antenna should be a multiple of 1/2 wavelength (lambda) with cable velocity, like the balun: ", cable_len );

module wire_circle()
{
	difference() {
		rotate_extrude(convexity = 10, $fn = fn)
			translate([height/2, 0, 0])
			circle(d = wire, $fn = fn);
		translate([-len/2,0,0])
			cube([len,len,len],center=true);
	}
}

module wire_masq()
{
	union() {
		difference() {
			union() {
				translate([top_len/2,0,0,])
					wire_circle();
				translate([-top_len/2,0,0,])
					rotate([0,180,0])
					wire_circle();
				translate([0, height/2,0])
					rotate([0,90,0])
					cylinder(d = wire, h=top_len+0.001, $fn=fn, center=true);
				translate([0, -height/2,0])
					rotate([0,90,0])
					cylinder(d = wire, h=top_len+0.001, $fn=fn, center=true);
			}
			translate([-gap/2,-height/2,0])
				cube([gap,height,height],center=true);
		}
		/* Soldering space */
		translate([-gap/2 - wire,-height/2,0])
			cube([wire*2,wire,wire*2],center=true);
		translate([wire,-height/2,0])
			cube([wire*2,wire,wire*2],center=true);
	}
}

module support()
{
	cube([top_len,height,support_thickness],center=true);
	translate([top_len/2,0,0])
		cylinder(d = height, h = support_thickness, center=true, fn=$fn);
	translate([-top_len/2,0,0])
		cylinder(d = height, h = support_thickness, center=true, fn=$fn);
}

module support_strength()
{
	cube([ support_beam, height - wire*2, support_thickness ], center=true);
	translate([ -top_len*0.45, 0, 0 ])
		cube([ support_beam, height - wire*2, support_thickness ], center=true);
	translate([ top_len*0.45, 0, 0 ])
		cube([ support_beam, height - wire*2, support_thickness ], center=true);
}

module composite()
{
	difference() {
		union() {
			difference() {
				support();
				scale([(top_len-wire*4)/top_len,(height-wire*4)/height,1.1])
					support();
			}
			support_strength();
		}
		wire_masq();
	}
}

composite();

