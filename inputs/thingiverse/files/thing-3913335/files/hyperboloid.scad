// **************************************************
// pencil holder
// set up to work on thingiverse customizer
// so some parameters are made calculations to prevent them showing
// e.g. y making them '2*1'
// **************************************************

// curve values
// set finer than default, calculated so customizer doesn't show them
$fa=6*1;
$fs=2*1;

// **************************************************
// general print / printer parameters
// **************************************************

// Show with pencils in place?
fitout=0; // [0:no pencils - printable,1:pencils in place - dont print]

// slice at limits and display only between limits
// to use this functionality uncomment here and 
// at teh intersection command near top of main assembly
//min_x=-200;
//max_x=200;
//min_y=-200;
//max_y=200;
//min_z=0;
//max_z=300;

// **************************************************
// component and element dimensional parameters
// **************************************************

// pencil length (waist will be at half this length)
pl=175;

// pencil hole clearance diameter
pd=8;

// pencil point length (set about half true value, set to 0 to get flat-ended socket)
ppl=8;

// number of pencils in outer ring
np=16;

// inclination of an outer pencil from vertical (degrees)
aa=30;

// number of pencils in inner ring (set to 0 to suppress inner ring)
irnp=8;

// inclination of an inner pencil from vertical (degrees)
iraa=-15;

// additional vertical offset of inner ring
irah=0;

// depth of prismatic part of socket cups
sd=25;

// wall thickness of  cups
wt=1.3;

// height (above bottom of cup) of peripheral linking wall
pwh=23;

// number of segments in peripheral wall (make a multiple of np)
pwn=np*5;

// define if bottom is open
obp=0;  // [0:closed,1:open]

// **************************************************
// no more configuration parameters after this point
// **************************************************

// **************************************************
// pre-process values from specified parameters
// **************************************************

// radius of pencil
pr=pd/2;
echo(pr=pr);

// width of inclined pencil
piw = pd/cos(aa);
echo(piw=piw);

irpiw = pd/cos(iraa);
echo(irpiw=irpiw);

// one pencil subtends 360/np degrees
// half a pencil subtends 180/np degrees hence radius at waist
// note this is not precise, because it assumes that distance
// from centre of ellipse (ie horizontal slice thropugh pencil)
// to tangent point is equal to major radius
// this creates slight additional clearance at waist
wrad = 0.5*piw/sin(180/np);
echo(wrad=wrad);

irwrad=0.5*irpiw/sin(180/irnp);
echo(irwrad=irwrad);

// distance from waist to pencil end (ignoring pencil thickness)
whgt=0.5*pl*cos(aa);
echo(whgt=whgt);

irwhgt=0.5*pl*cos(iraa);
echo(irwhgt=irwhgt);

// level of socket end hemisphere centre
// this is when vertical, so same for all rings
ssphc=-pl/2+min(pr,ppl);
echo(ssphc=ssphc);

// at base, centreline of pencil is offset from radial line
// by ssphc*sin(aa)
// so base radius (to cl pencil)
brad=sqrt(wrad*wrad+ssphc*ssphc*sin(aa)*sin(aa));
echo(brad=brad);

irbrad=sqrt(irwrad*irwrad+ssphc*ssphc*sin(iraa)*sin(iraa));
echo(irbrad=irbrad);

// distance from waist to outer face of cap tip
w2cap=ssphc*cos(aa)-pr-wt;
echo(w2cap=w2cap);

irw2cap=ssphc*cos(iraa)-pr-wt;
echo(irw2cap=irw2cap);

// offset to bring bottom of pencils into line
irh=w2cap-irw2cap+irah;
echo(irh=irh);


// **************************************************
// functions and modules for components / elements
// **************************************************

// radius at given height (measured vertically) from waist
// of hyperboloid with waist radius w
function hyprad(h,waist=wrad) = 
	sqrt(waist*waist+h*h*tan(aa)*tan(aa));
	
module pencil(){
	hull(){
		translate([0,0,ppl/2]) cylinder(pl-ppl,pr,pr,center=true);
		translate([0,0,-pl/2]) cylinder(ppl,0,pr);	
	}
}
	
// **************************************************
// main assembly
// **************************************************


//	intersection() {
//		// this is envelope of part we want to diplay
//		translate([min_x,min_y,min_z]) cube([max_x-min_x,max_y-min_y,max_z-min_z]);
		// this is what we are actually creating
		translate([0,0,-w2cap]) union(){

			difference(){
			
				union(){
					// pencil cups
					for(n=[1:np]){
						// cylindrical section
						rotate([0,0,n/np*360]) translate([wrad,0,0]) rotate([aa,0,0]) 
							translate([0,0,ssphc]) cylinder(sd,pr+wt,pr+wt);
						// spherical end
						rotate([0,0,n/np*360]) translate([wrad,0,0]) rotate([aa,0,0]) 
							translate([0,0,ssphc]) sphere(pr+wt);
					}
				
					if (irnp) {
						for(n=[1:irnp]){
							// cylindrical section
							rotate([0,0,n/irnp*360]) translate([irwrad,0,irh]) rotate([iraa,0,0]) 
								translate([0,0,ssphc]) cylinder(sd,pr+wt,pr+wt);
							// spherical end
							rotate([0,0,n/irnp*360]) translate([irwrad,0,irh]) rotate([iraa,0,0]) 
								translate([0,0,ssphc]) sphere(pr+wt);
						}
					}


					// upper section of outer ring peripheral wall
					intersection(){
						// mask for periperal wall
						union(){
							for(n=[1:np]){
								// mask, top of which aligned with cup top surface
								rotate([0,0,n/np*360]) translate([wrad,0,0]) rotate([aa,0,0]) 
									translate([0,-2*pd,ssphc]) cube([3*pd,4*pd,pwh]);
							}
						}

						// peripheral wall
						union(){
							for(aaa=[0:360/pwn:360]){
								hull(){	
									rotate([0,0,aaa]) translate([wrad,0,0]) rotate([aa,0,0]) 
										translate([0,0,ssphc]) cylinder(sd,wt/2,wt/2,$fn=4);
									rotate([0,0,aaa+360/pwn]) translate([wrad,0,0]) rotate([aa,0,0]) 
										translate([0,0,ssphc]) cylinder(sd,wt/2,wt/2,$fn=4);

								}
							}
						}
					}
					
					// upper section of inner ring peripheral wall
					if (irnp) {
						translate([0,0,irh]) intersection(){
							// mask for periperal wall
							union(){
								for(n=[1:irnp]){
									// mask, top of which aligned with cup top surface
									rotate([0,0,n/irnp*360]) translate([irwrad,0,0]) rotate([iraa,0,0]) 
										translate([0,-2*pd,ssphc]) cube([3*pd,4*pd,pwh]);
								}
							}

							// peripheral wall
							union(){
								for(aaa=[0:360/pwn:360]){
									hull(){	
										rotate([0,0,aaa]) translate([irwrad,0,0]) rotate([iraa,0,0]) 
											translate([0,0,ssphc]) cylinder(sd,wt/2,wt/2,$fn=4);
										rotate([0,0,aaa+360/pwn]) translate([irwrad,0,0]) rotate([iraa,0,0]) 
											translate([0,0,ssphc]) cylinder(sd,wt/2,wt/2,$fn=4);

									}
								}
							}
						}
					}
					
					// bottom section of outer peripheral wall
					difference(){
						translate([0,0,w2cap]) cylinder(pr+wt,brad+wt/2,brad+wt/2);
						translate([0,0,w2cap-1]) cylinder(pr+wt+2,brad-wt/2,brad-wt/2);
					}
					translate([0,0,w2cap+pr+wt])
						rotate_extrude(){
							translate([brad,0,0]) circle(wt/2,$fn=8);
						}
					
					// bottom section of inner peripheral wall
					if (irnp) {
						difference(){
							translate([0,0,irw2cap+irh]) cylinder(pr+wt,irbrad+wt/2,irbrad+wt/2);
							translate([0,0,irw2cap+irh-1]) cylinder(pr+wt+2,irbrad-wt/2,irbrad-wt/2);
						}
						translate([0,0,irw2cap+pr+wt+irh]) 
							rotate_extrude(){
								translate([irbrad,0,0]) circle(wt/2,$fn=8);
							}
					}
					
					// bottom plate
					translate([0,0,w2cap]) difference(){
						cylinder(wt,brad+wt/2,brad+wt/2);
						if (obp) {
							if (irnp) {
								translate([0,0,-1]) cylinder(wt+2,irbrad-wt/2,irbrad-wt/2);
							} else {
								// if open but no inner ring, use a nominal ring equal to a pencil width
								translate([0,0,-1]) cylinder(wt+2,brad-pd,brad-pd);
							}
						}
						
					}
					
					
					// add pencils if fitout is defined
					if (fitout) {
						for(n=[1:np]){
							rotate([0,0,n/np*360]) translate([wrad,0,0]) rotate([aa,0,0]) 
								pencil();
						}

						if (irnp){
							for(n=[1:irnp]){
								rotate([0,0,n/irnp*360]) translate([irwrad,0,irh]) rotate([iraa,0,0]) 
									pencil();
							}
						}					
					}
					

				}
				
				if (! fitout) {
					// pencils
					for(n=[1:np]){
						rotate([0,0,n/np*360]) translate([wrad,0,0]) rotate([aa,0,0]) 
							pencil();
					}

					if (irnp){
						for(n=[1:irnp]){
							rotate([0,0,n/irnp*360]) translate([irwrad,0,irh]) rotate([iraa,0,0]) 
								pencil();
						}
					}
				}

			}



		}
//	}

// **************************************************
// utility modules / functions
// **************************************************

// mirror all children, keeping source and mirrored
module mirrorplus(m=[1,0,0]){
	children();
	mirror(m) children();
}

// concatenate up to nine lists into one
function cat(L1,L2=[],L3=[],L4=[],L5=[],L6=[],L7=[],L8=[],L9=[]) = 
	[for(L=[L1, L2, L3, L4, L5, L6, L7, L8, L9], a=L) a];
