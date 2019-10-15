/* [Atom - with text in the center] */

element = "Au"; //["H":Hydrogen H(1), "He":Helium He(2), "Li":Lithium Li(3), "Be":Beryllium Be(4), "B":Boron B(5), "C":Carbon C(6), "N":Nitrogen N(7), "O":Oxygen O(8), "F":Fluorine F(9), "Ne":Neon Ne(10), "Na":Sodium Na(11), "Mg":Magnesium Mg(12), "Al":Aluminium Al(13), "Si":Silicon Si(14), "P":Phosphorus P(15), "S":Sulfur S(16), "Cl":Chlorine Cl(17), "Ar":Argon Ar(18), "K":Potassium K(19), "Ca":Calcium Ca(20), "Sc":Scandium Sc(21), "Ti":Titanium Ti(22), "V":Vanadium V(23), "Cr":Chromium Cr(24), "Mn":Manganese Mn(25), "Fe":Iron Fe(26), "Co":Cobalt Co(27), "Ni":Nickel Ni(28), "Cu":Copper Cu(29), "Zn":Zinc Zn(30), "Ga":Gallium Ga(31), "Ge":Germanium Ge(32), "As":Arsenic As(33), "Se":Selenium Se(34), "Br":Bromine Br(35), "Kr":Krypton Kr(36), "Rb":Rubidium Rb(37), "Sr":Strontium Sr(38), "Y":Yttrium Y(39), "Zr":Zirconium Zr(40), "Nb":Niobium Nb(41), "Mo":Molybdenum Mo(42), "Tc":Technetium Tc(43), "Ru":Ruthenium Ru(44), "Rh":Rhodium Rh(45), "Pd":Palladium Pd(46), "Ag":Silver Ag(47), "Cd":Cadmium Cd(48), "In":Indium In(49), "Sn":Tin Sn(50), "Sb":Antimony Sb(51), "Te":Tellurium Te(52), "I":Iodine I(53), "Xe":Xenon Xe(54), "Cs":Caesium Cs(55), "Ba":Barium Ba(56), "La":Lanthanum La(57), "Ce":Cerium Ce(58), "Pr":Praseodymium Pr(59), "Nd":Neodymium Nd(60), "Pm":Promethium Pm(61), "Sm":Samarium Sm(62), "Eu":Europium Eu(63), "Gd":Gadolinium Gd(64), "Tb":Terbium Tb(65), "Dy":Dysprosium Dy(66), "Ho":Holmium Ho(67), "Er":Erbium Er(68), "Tm":Thulium Tm(69), "Yb":Ytterbium Yb(70), "Lu":Lutetium Lu(71), "Hf":Hafnium Hf(72), "Ta":Tantalum Ta(73), "W":Tungsten W(74), "Re":Rhenium Re(75), "Os":Osmium Os(76), "Ir":Iridium Ir(77), "Pt":Platinum Pt(78), "Au":Gold Au(79), "Hg":Mercury Hg(80), "Tl":Thallium Tl(81), "Pb":Lead Pb(82), "Bi":Bismuth Bi(83), "Po":Polonium Po(84), "At":Astatine At(85), "Rn":Radon Rn(86), "Fr":Francium Fr(87), "Ra":Radium Ra(88), "Ac":Actinium Ac(89), "Th":Thorium Th(90), "Pa":Protactinium Pa(91), "U":Uranium U(92), "Np":Neptunium Np(93), "Pu":Plutonium Pu(94), "Am":Americium Am(95), "Cm":Curium Cm(96), "Bk":Berkelium Bk(97), "Cf":Californium Cf(98), "Es":Einsteinium Es(99), "Fm":Fermium Fm(100), "Md":Mendelevium Md(101), "No":Nobelium No(102), "Lr":Lawrencium Lr(103), "Rf":Rutherfordium Rf(104), "Db":Dubnium Db(105), "Sg":Seaborgium Sg(106), "Bh":Bohrium Bh(107), "Hs":Hassium Hs(108), "Mt":Meitnerium Mt(109), "Ds":Darmstadtium Ds(110), "Rg":Roentgenium Rg(111), "Cn":Copernicium Cn(112), "Uut":Ununtrium Uut(113), "Fl":Flerovium Fl(114), "Uup":Ununpentium Uup(115), "Lv":Livermorium Lv(116), "Uus":Ununseptium Uus(117), "Uuo":Ununoctium Uuo(118)]

// The width of each ring
ring_width=5; // [3:20]

// The space between each ring
ring_spacing=2; // [.5:8]

// The Height of the center ring
ring_height=6; // [6:15]

// The radius of the upper Base
center_radius=12; // [1:50]

// Clearance in mm
clearance=.1;

Build_Plate_Type = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
Build_Plate_Manual_Width = 100; //[100:400]
Build_Plate_Manual_Length = 100; //[100:400]

/* [Advanced] */

// The mesh resolution
mesh_resolution=70; // [20:120]

// The ring to ring height increase
ring_height_step=.5;

// The radius of a pin
pin_radius=0;

// The width of material covering the pin hole
pin_cap_width=0;

// The pin end to hole wall width
pin_cap_gap=0;

// radius of the pin holes
pin_hole_radius=0;

use <utils/build_plate.scad>


/* [Hidden] */
// preview[view:south, tilt:top diagonal]

$fn=mesh_resolution; // mesh resolution

build_plate(Build_Plate_Type,Build_Plate_Manual_Width,Build_Plate_Manual_Length);

/* [Main] */

/* 
Atomic electron configuration table
http://en.wikipedia.org/wiki/Atomic_electron_configuration_table

if (element=="Au")
	draw_gimbal("Au", "79", [2,8,18,32,18,1,0]);
*/


if (element=="H") draw_gimbal("H", "1", [1,0,0,0,0,0,0]);
if (element=="He") draw_gimbal("He", "2", [2,0,0,0,0,0,0]);
if (element=="Li") draw_gimbal("Li", "3", [2,1,0,0,0,0,0]);
if (element=="Be") draw_gimbal("Be", "4", [2,2,0,0,0,0,0]);
if (element=="B") draw_gimbal("B", "5", [2,3,0,0,0,0,0]);
if (element=="C") draw_gimbal("C", "6", [2,4,0,0,0,0,0]);
if (element=="N") draw_gimbal("N", "7", [2,5,0,0,0,0,0]);
if (element=="O") draw_gimbal("O", "8", [2,6,0,0,0,0,0]);
if (element=="F") draw_gimbal("F", "9", [2,7,0,0,0,0,0]);
if (element=="Ne") draw_gimbal("Ne", "10", [2,8,0,0,0,0,0]);
if (element=="Na") draw_gimbal("Na", "11", [2,8,1,0,0,0,0]);
if (element=="Mg") draw_gimbal("Mg", "12", [2,8,2,0,0,0,0]);
if (element=="Al") draw_gimbal("Al", "13", [2,8,3,0,0,0,0]);
if (element=="Si") draw_gimbal("Si", "14", [2,8,4,0,0,0,0]);
if (element=="P") draw_gimbal("P", "15", [2,8,5,0,0,0,0]);
if (element=="S") draw_gimbal("S", "16", [2,8,6,0,0,0,0]);
if (element=="Cl") draw_gimbal("Cl", "17", [2,8,7,0,0,0,0]);
if (element=="Ar") draw_gimbal("Ar", "18", [2,8,8,0,0,0,0]);
if (element=="K") draw_gimbal("K", "19", [2,8,8,1,0,0,0]);
if (element=="Ca") draw_gimbal("Ca", "20", [2,8,8,2,0,0,0]);
if (element=="Sc") draw_gimbal("Sc", "21", [2,8,9,2,0,0,0]);
if (element=="Ti") draw_gimbal("Ti", "22", [2,8,10,2,0,0,0]);
if (element=="V") draw_gimbal("V", "23", [2,8,11,2,0,0,0]);
if (element=="Cr") draw_gimbal("Cr", "24", [2,8,13,1,0,0,0]);
if (element=="Mn") draw_gimbal("Mn", "25", [2,8,13,2,0,0,0]);
if (element=="Fe") draw_gimbal("Fe", "26", [2,8,14,2,0,0,0]);
if (element=="Co") draw_gimbal("Co", "27", [2,8,15,2,0,0,0]);
if (element=="Ni") draw_gimbal("Ni", "28", [2,8,17,1,0,0,0]);
if (element=="Cu") draw_gimbal("Cu", "29", [2,8,18,1,0,0,0]);
if (element=="Zn") draw_gimbal("Zn", "30", [2,8,18,2,0,0,0]);
if (element=="Ga") draw_gimbal("Ga", "31", [2,8,18,3,0,0,0]);
if (element=="Ge") draw_gimbal("Ge", "32", [2,8,18,4,0,0,0]);
if (element=="As") draw_gimbal("As", "33", [2,8,18,5,0,0,0]);
if (element=="Se") draw_gimbal("Se", "34", [2,8,18,6,0,0,0]);
if (element=="Br") draw_gimbal("Br", "35", [2,8,18,7,0,0,0]);
if (element=="Kr") draw_gimbal("Kr", "36", [2,8,18,8,0,0,0]);
if (element=="Rb") draw_gimbal("Rb", "37", [2,8,18,8,1,0,0]);
if (element=="Sr") draw_gimbal("Sr", "38", [2,8,18,8,2,0,0]);
if (element=="Y") draw_gimbal("Y", "39", [2,8,18,9,2,0,0]);
if (element=="Zr") draw_gimbal("Zr", "40", [2,8,18,10,2,0,0]);
if (element=="Nb") draw_gimbal("Nb", "41", [2,8,18,12,1,0,0]);
if (element=="Mo") draw_gimbal("Mo", "42", [2,8,18,13,1,0,0]);
if (element=="Tc") draw_gimbal("Tc", "43", [2,8,18,13,2,0,0]);
if (element=="Ru") draw_gimbal("Ru", "44", [2,8,18,15,1,0,0]);
if (element=="Rh") draw_gimbal("Rh", "45", [2,8,18,16,1,0,0]);
if (element=="Pd") draw_gimbal("Pd", "46", [2,8,18,18,0,0,0]);
if (element=="Ag") draw_gimbal("Ag", "47", [2,8,18,18,1,0,0]);
if (element=="Cd") draw_gimbal("Cd", "48", [2,8,18,18,2,0,0]);
if (element=="In") draw_gimbal("In", "49", [2,8,18,18,3,0,0]);
if (element=="Sn") draw_gimbal("Sn", "50", [2,8,18,18,4,0,0]);
if (element=="Sb") draw_gimbal("Sb", "51", [2,8,18,18,5,0,0]);
if (element=="Te") draw_gimbal("Te", "52", [2,8,18,18,6,0,0]);
if (element=="I") draw_gimbal("I", "53", [2,8,18,18,7,0,0]);
if (element=="Xe") draw_gimbal("Xe", "54", [2,8,18,18,8,0,0]);
if (element=="Cs") draw_gimbal("Cs", "55", [2,8,18,18,8,1,0]);
if (element=="Ba") draw_gimbal("Ba", "56", [2,8,18,18,8,2,0]);
if (element=="La") draw_gimbal("La", "57", [2,8,18,18,9,2,0]);
if (element=="Ce") draw_gimbal("Ce", "58", [2,8,18,19,9,2,0]);
if (element=="Pr") draw_gimbal("Pr", "59", [2,8,18,21,8,2,0]);
if (element=="Nd") draw_gimbal("Nd", "60", [2,8,18,22,8,2,0]);
if (element=="Pm") draw_gimbal("Pm", "61", [2,8,18,23,8,2,0]);
if (element=="Sm") draw_gimbal("Sm", "62", [2,8,18,24,8,2,0]);
if (element=="Eu") draw_gimbal("Eu", "63", [2,8,18,25,8,2,0]);
if (element=="Gd") draw_gimbal("Gd", "64", [2,8,18,25,9,2,0]);
if (element=="Tb") draw_gimbal("Tb", "65", [2,8,18,27,8,2,0]);
if (element=="Dy") draw_gimbal("Dy", "66", [2,8,18,28,8,2,0]);
if (element=="Ho") draw_gimbal("Ho", "67", [2,8,18,29,8,2,0]);
if (element=="Er") draw_gimbal("Er", "68", [2,8,18,30,8,2,0]);
if (element=="Tm") draw_gimbal("Tm", "69", [2,8,18,31,8,2,0]);
if (element=="Yb") draw_gimbal("Yb", "70", [2,8,18,32,8,2,0]);
if (element=="Lu") draw_gimbal("Lu", "71", [2,8,18,32,9,2,0]);
if (element=="Hf") draw_gimbal("Hf", "72", [2,8,18,32,10,2,0]);
if (element=="Ta") draw_gimbal("Ta", "73", [2,8,18,32,11,2,0]);
if (element=="W") draw_gimbal("W", "74", [2,8,18,32,12,2,0]);
if (element=="Re") draw_gimbal("Re", "75", [2,8,18,32,13,2,0]);
if (element=="Os") draw_gimbal("Os", "76", [2,8,18,32,14,2,0]);
if (element=="Ir") draw_gimbal("Ir", "77", [2,8,18,32,15,2,0]);
if (element=="Pt") draw_gimbal("Pt", "78", [2,8,18,32,17,1,0]);
if (element=="Au") draw_gimbal("Au", "79", [2,8,18,32,18,1,0]);
if (element=="Hg") draw_gimbal("Hg", "80", [2,8,18,32,18,2,0]);
if (element=="Tl") draw_gimbal("Tl", "81", [2,8,18,32,18,3,0]);
if (element=="Pb") draw_gimbal("Pb", "82", [2,8,18,32,18,4,0]);
if (element=="Bi") draw_gimbal("Bi", "83", [2,8,18,32,18,5,0]);
if (element=="Po") draw_gimbal("Po", "84", [2,8,18,32,18,6,0]);
if (element=="At") draw_gimbal("At", "85", [2,8,18,32,18,7,0]);
if (element=="Rn") draw_gimbal("Rn", "86", [2,8,18,32,18,8,0]);
if (element=="Fr") draw_gimbal("Fr", "87", [2,8,18,32,18,8,1]);
if (element=="Ra") draw_gimbal("Ra", "88", [2,8,18,32,18,8,2]);
if (element=="Ac") draw_gimbal("Ac", "89", [2,8,18,32,18,9,2]);
if (element=="Th") draw_gimbal("Th", "90", [2,8,18,32,18,10,2]);
if (element=="Pa") draw_gimbal("Pa", "91", [2,8,18,32,20,9,2]);
if (element=="U") draw_gimbal("U", "92", [2,8,18,32,21,9,2]);
if (element=="Np") draw_gimbal("Np", "93", [2,8,18,32,22,9,2]);
if (element=="Pu") draw_gimbal("Pu", "94", [2,8,18,32,24,8,2]);
if (element=="Am") draw_gimbal("Am", "95", [2,8,18,32,25,8,2]);
if (element=="Cm") draw_gimbal("Cm", "96", [2,8,18,32,25,9,2]);
if (element=="Bk") draw_gimbal("Bk", "97", [2,8,18,32,27,8,2]);
if (element=="Cf") draw_gimbal("Cf", "98", [2,8,18,32,28,8,2]);
if (element=="Es") draw_gimbal("Es", "99", [2,8,18,32,29,8,2]);
if (element=="Fm") draw_gimbal("Fm", "100", [2,8,18,32,30,8,2]);
if (element=="Md") draw_gimbal("Md", "101", [2,8,18,32,31,8,2]);
if (element=="No") draw_gimbal("No", "102", [2,8,18,32,32,8,2]);
if (element=="Lr") draw_gimbal("Lr", "103", [2,8,18,32,32,8,3]);
if (element=="Rf") draw_gimbal("Rf", "104", [2,8,18,32,32,10,2]);
if (element=="Db") draw_gimbal("Db", "105", [2,8,18,32,32,11,2]);
if (element=="Sg") draw_gimbal("Sg", "106", [2,8,18,32,32,12,2]);
if (element=="Bh") draw_gimbal("Bh", "107", [2,8,18,32,32,13,2]);
if (element=="Hs") draw_gimbal("Hs", "108", [2,8,18,32,32,14,2]);
if (element=="Mt") draw_gimbal("Mt", "109", [2,8,18,32,32,15,2]);
if (element=="Ds") draw_gimbal("Ds", "110", [2,8,18,32,32,16,2]);
if (element=="Rg") draw_gimbal("Rg", "111", [2,8,18,32,32,17,2]);
if (element=="Cn") draw_gimbal("Cn", "112", [2,8,18,32,32,18,2]);
if (element=="Uut") draw_gimbal("Uut", "113", [2,8,18,32,32,18,3]);
if (element=="Fl") draw_gimbal("Fl", "114", [2,8,18,32,32,18,4]);
if (element=="Uup") draw_gimbal("Uup", "115", [2,8,18,32,32,18,5]);
if (element=="Lv") draw_gimbal("Lv", "116", [2,8,18,32,32,18,6]);
if (element=="Uus") draw_gimbal("Uus", "117", [2,8,18,32,32,18,7]);
if (element=="Uuo") draw_gimbal("Uuo", "118", [2,8,18,32,32,18,8]);


module draw_gimbal(element, atomic_number, electrons_on_each_ring)
{

number_of_electrons_on_ring1=electrons_on_each_ring[0];
number_of_electrons_on_ring2=electrons_on_each_ring[1];
number_of_electrons_on_ring3=electrons_on_each_ring[2];
number_of_electrons_on_ring4=electrons_on_each_ring[3];
number_of_electrons_on_ring5=electrons_on_each_ring[4];
number_of_electrons_on_ring6=electrons_on_each_ring[5];
number_of_electrons_on_ring7=electrons_on_each_ring[6];

number_of_rings=1+sign(number_of_electrons_on_ring1)+sign(number_of_electrons_on_ring2)+sign(number_of_electrons_on_ring3)+sign(number_of_electrons_on_ring4)+sign(number_of_electrons_on_ring5)+sign(number_of_electrons_on_ring6)+sign(number_of_electrons_on_ring7);
cylinder(h = 2, r1 = center_radius*8/5, r2 = center_radius*8/5, center = false);

difference(){
	difference(){
		cylinder(h = (ring_width+ring_spacing)*1.8, r1 = center_radius, r2 = center_radius, center = false);
		translate(v = [0, 20, center_radius+(ring_width+ring_spacing)*(number_of_rings+1)-ring_spacing])
		rotate(a=[90,0,0])
		cylinder(h = 40, r = 0.5*((center_radius+(ring_width+ring_spacing)*number_of_rings-1)+(center_radius+(ring_width+ring_spacing)*(number_of_rings-1)-ring_spacing)), center = false);
	}

//(center_radius+(ring_width+ring_spacing)*number_of_rings)+(center_radius+(ring_width+ring_spacing)*(number_of_rings)-ring_spacing)

// translate everything so that it rests on z=0
// and loop over all rings
translate(v = [0, ring_height_step*number_of_rings/2, center_radius+(ring_width+ring_spacing)*(number_of_rings+1)-ring_spacing])
rotate(a=[90,0,0])
translate(v=[0, 0, 0]) union()
for (ring = [0 : number_of_rings-1]) assign(
	ir=center_radius+(ring_width+ring_spacing)*ring,
	or=center_radius+(ring_width+ring_spacing)*(ring+1)-ring_spacing,
	odd=(ring%2), even=((ring+1)%2)) {
	if (ring+1==number_of_rings){
	draw_electrons(or, ir, ring_height, ring_height_step, ring, ring_width, element, atomic_number, electrons_on_each_ring, number_of_rings);

	// translate each new ring so that the pins get printed
	// resting on the next ring's hole wall
	translate(v=[0, 0, ring*ring_height_step*.5]) intersection() {
		difference() {
			difference() {
				union() {
					sphere(r=or+0.1, center=true);
					// the last ring does not have protruding pins
					if (ring != number_of_rings-1) rotate(v=[even, odd, 0], a=90)
						cylinder(r=pin_radius, 
					   	h=(or*2-ir+ring_spacing)*2-(pin_cap_width+pin_cap_gap),
							center=true);

				}
				// the inner-most ring does not have pin holes
				if (ring==0) translate(v=[0, 0, ring_height/3]) cylinder(r=center_radius+ring_width*0.5, h=10, center=false);
				else union() {
					sphere(r=ir, center=true);
					rotate(v=[odd, even, 0], a=90)
						cylinder(r=pin_hole_radius, h=or*2-pin_cap_width, center=true);
				}
			}
			if (ring != number_of_rings-1)
				rotate(v=[even, odd, 0], a=90)
					rotate(v=[0,0,1], a=45)
						cube(size=[pin_radius, pin_radius,
                       (or+ring_width+ring_spacing)*2],
                       center=true);
		}

		// make each ring thicker than the last so that the
        // pin is still centered even though it is printed
		// resting on the next ring's hole wall
		cube(size=[(or+ring_width+ring_spacing)*2,
                 (or+ring_width+ring_spacing)*2,
           ring_height+(ring_height_step*ring)+clearance],
           center=true);
	}
}
}
}
}

module draw_electrons(or, ir, ring_height, ring_height_step, ring, ring_width, element, atomic_number, electrons_on_each_ring, number_of_rings)
{
number_of_electrons_on_ring1=electrons_on_each_ring[0];
number_of_electrons_on_ring2=electrons_on_each_ring[1];
number_of_electrons_on_ring3=electrons_on_each_ring[2];
number_of_electrons_on_ring4=electrons_on_each_ring[3];
number_of_electrons_on_ring5=electrons_on_each_ring[4];
number_of_electrons_on_ring6=electrons_on_each_ring[5];
number_of_electrons_on_ring7=electrons_on_each_ring[6];


if (ring==0 && ( number_of_electrons_on_ring1>0)) {
	// write on a cube
	/*translate([0,0,0])
	//Write the element ,fist check if there is an descender (gjpqy)
	if (element[1]=="g" || element[1]=="j" || element[1]=="p" || element[1]=="q" || element[1]=="y")
	writecube(element,[0,0,0.5*(ring_height+(2*ring_height_step*ring))],[0,0,0],face="top", t=font_depth, h=center_radius, up=center_radius/2,font=font); 
	else
	writecube(element,[0,0,0.5*(ring_height+(2*ring_height_step*ring))],[0,0,0],face="top", t=font_depth, h=center_radius, up=center_radius/3,font=font); 

	//Write the atomic number
	writecube(atomic_number,[0,0,0.5*(ring_height+(2*ring_height_step*ring))],[0,0,0],face="top", t=font_depth, h=center_radius/2, down=center_radius/1.5,font=font); */
}

if (ring==1 && ( number_of_electrons_on_ring1>0))
for (electron = [1 : number_of_electrons_on_ring1])
	rotate(a=360/number_of_electrons_on_ring1*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2), center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([0,0,0]);
				}

if (ring==2 && (number_of_electrons_on_ring2>0))
for (electron = [1 : number_of_electrons_on_ring2])
	rotate(a=360/number_of_electrons_on_ring2*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2), center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([0,0,0]);
				}

if (ring==3 && (number_of_electrons_on_ring3>0))
for (electron = [1 : number_of_electrons_on_ring3])
	rotate(a=360/number_of_electrons_on_ring3*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2), center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([0,0,0]);
				}

if (ring==4 && (number_of_electrons_on_ring4>0))
for (electron = [1 : number_of_electrons_on_ring4])
	rotate(a=360/number_of_electrons_on_ring4*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2), center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([0,0,0]);
				}

if (ring==5 && (number_of_electrons_on_ring5>0))
for (electron = [1 : number_of_electrons_on_ring5])
	rotate(a=360/number_of_electrons_on_ring5*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2), center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([0,0,0]);
				}

if (ring==6 && (number_of_electrons_on_ring6>0))
for (electron = [1 : number_of_electrons_on_ring6])
	rotate(a=360/number_of_electrons_on_ring6*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2), center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([0,0,0]);
				}

if (ring==7 && (number_of_electrons_on_ring7>0))
	for (electron = [1 : number_of_electrons_on_ring7])
	rotate(a=360/number_of_electrons_on_ring7*electron, v=[0,0,1])
		translate(v=[0.5*(or+ir), 0, 0.5*(ring_height+(2*ring_height_step*ring))])
			difference() {
				sphere(r=(ring_width/2), center=true);
				translate(v=[-0.5*ring_width, -0.5*ring_width, -ring_width])cube([0,0,0]);
				}

}

