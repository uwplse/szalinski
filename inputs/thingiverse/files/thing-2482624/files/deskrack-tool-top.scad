////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// this script generates the cutting sketch for you laser cutter or cnc to make a desk shelves ////
// These shelves have been made initialy to hold my solder iron lab power supply pliers etc... ///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// This script has been made by iX. ////////////////////////////////////////
//////// I've learnt openscad at Laboratoire Ouvert Grenoblois the Grenoble's hackerspace /////////
////////////////////////////// https://www.logre.eu/wiki/Accueil /////////////////////////////////////////
///////// can be found on thingiverse "maker desk shelves for laser cutter"  ////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////// For bug repport, suggestions, say thank you, send me money //////////////////////
/////////////////////////// you can reach me at xbranca@gmail.com ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////// This is a remix from Mr clifford "Parametric Desktop Filing Rack"  ///////////////////
//////////////////////// https://www.thingiverse.com/thing:3084 ////////////////////////////////////////
///////////////////////// Thank you very much to him :) ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////  This is licensed as " 2-Clause BSD License " .. deal with it ! ///////////////////////
///////////////////////// https://opensource.org/licenses/bsd-license.php ///////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

////////////////////////////////////////////////////////////////////////////////
//select the mode you want to render
// shapes --> 2D cutting view to export in dxf
// 3Dview --> rendering of the desk shelves once assembled
// test --> test mode in case you wanna display only one element to modify it
mode =
//	"shapes";
	"3dview";
//  "test";

////////////////////////////////////////////////////////////////////////////////
// Your shelves parameters

//number of shelves you want
num_shelves = 4;
//extra height on top of the upper shelf
extra_h = 100;
//Half diameter of the ronded angle of the upper self
round_r = 35;

//dimensions
shelf_width = 170;
shelf_depth = 210;
shelf_h = 100;

//depth of the tool older
top_tool_holder_depth = 60;

total_h = num_shelves*shelf_h + extra_h;
echo("total_h =",total_h);

//set the thickness of the material you wanna use
thickness = 3;

// number of locks in each direction
locks_h = 10;
locks_d = 5;
locks_w = 5;
nb_locks_top = 3;

//screw_drivers
nb_screw_drivers = 6;
diameter_screw_drivers = 6;
dist_screw_driver_to_edge = 12;

// amount of wood around pliers holders
margin_around_pliers = 5;

// number cases on the tool holder
nb_case = 6;

//size of window edges
//define the amout of wood let around the windows opened on side and back of the shelves
window_edges = 25;
//rounds around the shelves
window_round = 5;

//////////////////////////////////////////////////////////////////////////////////////
////////////////////// internal script computation ///////////////////////////////
// You shouldn't have to midify it unless you wanna hack this script //////
//////////////////////////////////////////////////////////////////////////////////////

//pliers_case_size = (top_tool_holder_depth - diameter_screw_drivers - 15 -10)/2 ;
pliers_case_size_x = (shelf_width - (nb_case+1)*margin_around_pliers)/nb_case ;
pliers_case_size_y = (top_tool_holder_depth - 2*dist_screw_driver_to_edge - diameter_screw_drivers/2 - 1*margin_around_pliers) /2 ;

//compute size of Z/h locks
//locks_h = nb_of_lock_z;
locks_width_h = (total_h - (2*thickness))/(2*locks_h);
// security to guarantee lock_width >= thickness
if(locks_width_h<thickness) {locks_width_h=thickness;}; 

//compute size of Y/W locks
//locks_w = nb_of_lock_y;
locks_width_w = (shelf_width - (2*thickness))/(2*locks_w);
// security to guarantee lock_width >= thickness
if(locks_width_w<thickness) {locks_width_w=thickness;}; 

//compute size of x/d locks
//locks_d = nb_of_lock_x;
locks_width_d = (shelf_depth - (2*thickness))/(2*locks_d);
// security to guarantee lock_width >= thickness
if(locks_width_d<thickness) {locks_width_d=thickness;}; 

locks_top_tool = (top_tool_holder_depth)/(2*nb_locks_top);
if(locks_top_tool<thickness) {locks_top_tool=thickness;}; 

explode = (sin($t*360 - 90)+1)*10;

function shelf_hpos(i) = thickness + i*shelf_h;

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// Modules //////////////////////////////////////////
// You shouldn't have to midify it unless you wanna hack this script //////
//////////////////////////////////////////////////////////////////////////////////////

module backside()
{
	difference() {
			union(){
				//initial square	
				square([ shelf_width, total_h ]);
				//side locks
				for (i = [0:(locks_h)-1]) {
					translate([ 0, (locks_width_h/2) + (locks_width_h)*(2*i) ]) {
							translate([ -thickness, 0 ]) square([ thickness*2, locks_width_h ]);
							translate([ shelf_width-thickness, 0 ]) square([ thickness*2, locks_width_h ]);
					}
				}
			}
			//remove locks for shelves and top tools
			for (i  = [0:num_shelves]) {
				for (j  = [0:locks_w-1]){
					//locks for shelves
					translate([ (thickness + locks_width_w/2) + (locks_width_w)*(2*j), shelf_hpos(i) ])
						square([ locks_width_w, thickness ]);
					//locks for top tools
					translate([ (thickness + locks_width_w/2) + (locks_width_w)*(2*j), total_h - thickness ])
						square([ locks_width_w, thickness ]);
				}
				//Opens windows into backside
				translate([ (1*thickness) + window_edges + window_round, (1*thickness) + window_edges + window_round + shelf_hpos(i) ])
				minkowski(){
				  	square([ shelf_width - (2*window_edges) - (2*thickness) - (2*window_round), shelf_h - (2*window_edges) - (2*thickness) - (2*window_round) ]);
					circle(r=window_round,h=thickness);
				}
			}
	}
}

module shelf()
{
	square([ shelf_width, shelf_depth]);
	for (i = [0:locks_d-1]) {
		translate([ 0, (locks_width_d/2) + (locks_width_d)*(2*i) ]) {
			translate([ -thickness, 0 ]) square([ thickness*2, locks_width_d ]);
			translate([ shelf_width-thickness, 0 ]) square([ thickness*2, locks_width_d ]);
		}
	}
	for (j  = [0:locks_w-1])
		translate([ thickness + (locks_width_w/2) + (locks_width_w)*(2*j), shelf_depth ])
			square([ locks_width_w, thickness ]);
}

module side()
{
	difference() {
		//initial square
		square([ total_h, shelf_depth+thickness*2 ]);
		
		//remove all locks for shelves qnd open windows
		for (i  = [0:num_shelves]) {
			//remove locks for shelves
			for (j  = [0:locks_d-1])
				translate([ shelf_hpos(i), (locks_width_d/2) + (locks_width_d)*(2*j) ])
				square([ thickness, locks_width_d ]);
			//Opens windows into side
				translate([ (1*thickness) + window_edges + window_round + shelf_hpos(i), (1*thickness) + window_edges + window_round, ])
				minkowski(){
				  	square([ shelf_h - (2*window_edges) - (2*thickness) - (2*window_round), shelf_depth - (2*window_edges) - (2*thickness) - (2*window_round) ]);
					circle(r=window_round,h=thickness);
			}
		}		
		
		//remove locks for backside
		for (i = [0:locks_h-1]) {
			translate([ (locks_width_h/2) + (locks_width_h)*(2*i), shelf_depth ]) 
				square([ locks_width_h, thickness ]);
		}

		//perform rounding on top front
		translate([ total_h-round_r, -round_r ])
		difference() {
			square(round_r*2);
			translate([ 0, round_r*2]) circle(round_r);
		}

		//open locks on top for tools
		translate([ total_h - thickness, shelf_depth +(0*thickness) + (locks_top_tool/2) - top_tool_holder_depth]) 
				for (i = [0:nb_locks_top-1]) {
					translate([0, 2*i*locks_top_tool ]) square([2*thickness, locks_top_tool]);
				}
	}
}

module top_tools_holder()
{
	difference(){
		union(){
			square([ shelf_width, top_tool_holder_depth]);
			//Side locks of top tool holder
			for (i = [0:nb_locks_top-1]) {
				translate([ 0, (locks_top_tool/2) + (locks_top_tool)*(2*i) ]) {
					translate([ -thickness, 0 ]) square([ thickness*2, locks_top_tool ]);
					translate([ shelf_width-thickness, 0 ]) square([ thickness*2, locks_top_tool ]);
				}
			}
			//backside locks
			for (j  = [0:locks_w-1])
				translate([ thickness + (locks_width_w/2) + (locks_width_w)*(2*j), top_tool_holder_depth ])
					square([ locks_width_w, thickness ]);
		}
		
		// holes for screw drivers 
		for(i=[1:nb_screw_drivers]) translate([ i*(shelf_width/(nb_screw_drivers+1)), top_tool_holder_depth - dist_screw_driver_to_edge]) circle(d=diameter_screw_drivers, center=true);
		
		//cases for pliers or whatever
		
		for(i=[0:nb_case-1]) translate([ margin_around_pliers + i*(pliers_case_size_x+margin_around_pliers), 2*margin_around_pliers + pliers_case_size_y]) square([pliers_case_size_x, pliers_case_size_y]);
		for(i=[0:nb_case-1]) translate([ margin_around_pliers + i*(pliers_case_size_x +margin_around_pliers), margin_around_pliers ]) square([pliers_case_size_x, pliers_case_size_y]);
	}
}
//top_tool_holder_depth - 2*dist_screw_driver_to_edge - diameter_screw_drivers/2 - 2*pliers_case_size_y - margin_around_pliers



//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Renderings ////////////////////////////////////////
// You shouldn't have to midify it unless you wanna hack this script //////
//////////////////////////////////////////////////////////////////////////////////////

if (mode == "shapes") {
	translate([ -shelf_width -3*thickness, shelf_depth+thickness*3 ]) backside();
	translate([ -shelf_width -3*thickness, 0 ]) shelf();
	side();
	translate([ total_h + 2*thickness, shelf_depth - top_tool_holder_depth ]) top_tools_holder();
}

if (mode == "3dview") {
	color([ 0.3, 0.7, 0.3 ]) for (i = [0:num_shelves])
		translate([ 0, 0, shelf_hpos(i) ]) linear_extrude(height = thickness) shelf();
	color([ 0.7, 0.3, 0.7 ]) for (i = [0:1])
		translate([ i*(shelf_width+thickness) - explode + i*2*explode, 0, 0 ]) rotate([ 0, -90, 0 ])
			linear_extrude(height = thickness) side();
	color([ 0.7, 0.3, 0.3 ]) translate([ 0, shelf_depth+thickness + explode, 0 ]) rotate([ 90, 0, 0 ])
			linear_extrude(height = thickness) backside();
	color([ 0.5, 0.5, 0.5 ]) 
		translate([ 0, shelf_depth - top_tool_holder_depth, total_h ]) rotate([ 0, 0, 0 ]) top_tools_holder();
}

if (mode == "test") {
	//backside();
	//shelf();
    //side();
	top_tools_holder();
}