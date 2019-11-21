/*	[Not too Bohr-ing atoms]

    This is conceptually based on Thing 114247, but is all new code.
    This also prints assembled, without supports. Major improvements:
    
    * Corrects pre-discovery names of the four most recently discovered elements
    * Two-sided, appearing similar on front and back
    * Less chunky rings, making electrons more visible and faster to print
    * Various rotations applied to improve appearance and functionality
    * Lose, but locked, pivots with very low friction to spin when blown on
    * Optional mount included as either stand or hanger
      (note that text is flipped for stand version, always viewed from front)

	May 30, 2018 by H. Dietz, http://aggregate.org/hankd
    
    Versions:
    20160530    First fully working version (e.g., used to print P H Y Si Cs)
    20160531    Major clean-up of code
    20160601    More clean-up, addition of new elements and mounts, improved joint tolerancing
*/

// Element to make
element = "Si"; // ["H":Hydrogen H(1), "He":Helium He(2), "Li":Lithium Li(3), "Be":Beryllium Be(4), "B":Boron B(5), "C":Carbon C(6), "N":Nitrogen N(7), "O":Oxygen O(8), "F":Fluorine F(9), "Ne":Neon Ne(10), "Na":Sodium Na(11), "Mg":Magnesium Mg(12), "Al":Aluminium Al(13), "Si":Silicon Si(14), "P":Phosphorus P(15), "S":Sulfur S(16), "Cl":Chlorine Cl(17), "Ar":Argon Ar(18), "K":Potassium K(19), "Ca":Calcium Ca(20), "Sc":Scandium Sc(21), "Ti":Titanium Ti(22), "V":Vanadium V(23), "Cr":Chromium Cr(24), "Mn":Manganese Mn(25), "Fe":Iron Fe(26), "Co":Cobalt Co(27), "Ni":Nickel Ni(28), "Cu":Copper Cu(29), "Zn":Zinc Zn(30), "Ga":Gallium Ga(31), "Ge":Germanium Ge(32), "As":Arsenic As(33), "Se":Selenium Se(34), "Br":Bromine Br(35), "Kr":Krypton Kr(36), "Rb":Rubidium Rb(37), "Sr":Strontium Sr(38), "Y":Yttrium Y(39), "Zr":Zirconium Zr(40), "Nb":Niobium Nb(41), "Mo":Molybdenum Mo(42), "Tc":Technetium Tc(43), "Ru":Ruthenium Ru(44), "Rh":Rhodium Rh(45), "Pd":Palladium Pd(46), "Ag":Silver Ag(47), "Cd":Cadmium Cd(48), "In":Indium In(49), "Sn":Tin Sn(50), "Sb":Antimony Sb(51), "Te":Tellurium Te(52), "I":Iodine I(53), "Xe":Xenon Xe(54), "Cs":Caesium Cs(55), "Ba":Barium Ba(56), "La":Lanthanum La(57), "Ce":Cerium Ce(58), "Pr":Praseodymium Pr(59), "Nd":Neodymium Nd(60), "Pm":Promethium Pm(61), "Sm":Samarium Sm(62), "Eu":Europium Eu(63), "Gd":Gadolinium Gd(64), "Tb":Terbium Tb(65), "Dy":Dysprosium Dy(66), "Ho":Holmium Ho(67), "Er":Erbium Er(68), "Tm":Thulium Tm(69), "Yb":Ytterbium Yb(70), "Lu":Lutetium Lu(71), "Hf":Hafnium Hf(72), "Ta":Tantalum Ta(73), "W":Tungsten W(74), "Re":Rhenium Re(75), "Os":Osmium Os(76), "Ir":Iridium Ir(77), "Pt":Platinum Pt(78), "Au":Gold Au(79), "Hg":Mercury Hg(80), "Tl":Thallium Tl(81), "Pb":Lead Pb(82), "Bi":Bismuth Bi(83), "Po":Polonium Po(84), "At":Astatine At(85), "Rn":Radon Rn(86), "Fr":Francium Fr(87), "Ra":Radium Ra(88), "Ac":Actinium Ac(89), "Th":Thorium Th(90), "Pa":Protactinium Pa(91), "U":Uranium U(92), "Np":Neptunium Np(93), "Pu":Plutonium Pu(94), "Am":Americium Am(95), "Cm":Curium Cm(96), "Bk":Berkelium Bk(97), "Cf":Californium Cf(98), "Es":Einsteinium Es(99), "Fm":Fermium Fm(100), "Md":Mendelevium Md(101), "No":Nobelium No(102), "Lr":Lawrencium Lr(103), "Rf":Rutherfordium Rf(104), "Db":Dubnium Db(105), "Sg":Seaborgium Sg(106), "Bh":Bohrium Bh(107), "Hs":Hassium Hs(108), "Mt":Meitnerium Mt(109), "Ds":Darmstadtium Ds(110), "Rg":Roentgenium Rg(111), "Cn":Copernicium Cn(112), "Uut":Ununtrium Uut(113) is now Nihonium Nh(113),"Nh":Nihonium Nh(113), "Fl":Flerovium Fl(114), "Uup":Ununpentium Uup(115) is now Moscovium Mc(115), "Mc":Moscovium Mc(115), "Lv":Livermorium Lv(116), "Uus":Ununseptium Uus(117) is now Tennessine Ts(117), "Ts":Tennessine Ts(117),"Uuo":Ununoctium Uuo(118) is now Oganesson Og(118), "Og":Oganesson Og(118)]

// Type of mounting
mount = "Stand"; // ["None":None, "Stand":Stand, "Hanger":Hanger]

// How smooth should arcs be (coarser renders faster)
smooth = 180; // [90:Coarse, 180:Normal, 360:Fine]

// Printer tolerance for a gap in microns
tol = 750; // [500:1000]

/* [Hidden] */

rt = 3;			// ring thickness
rh = 6;			// ring height
rs = 16;		// ring size step
rm = 42;		// ring minimum
zero = 0.001;		// negligible value
gap = tol / 1000;	// gap between separate objects
$fn = smooth;		// arc rendering segments

// font is not specified to enhance portability
font = "avant garde:style=Bold";

elements = [		// table of element data
	["H",	"1",	[1,0,0,0,0,0,0]],
	["He",	"2",	[2,0,0,0,0,0,0]],
	["Li",	"3",	[2,1,0,0,0,0,0]],
	["Be",	"4",	[2,2,0,0,0,0,0]],
	["B",	"5",	[2,3,0,0,0,0,0]],
	["C",	"6",	[2,4,0,0,0,0,0]],
	["N",	"7",	[2,5,0,0,0,0,0]],
	["O",	"8",	[2,6,0,0,0,0,0]],
	["F",	"9",	[2,7,0,0,0,0,0]],
	["Ne",	"10",	[2,8,0,0,0,0,0]],
	["Na",	"11",	[2,8,1,0,0,0,0]],
	["Mg",	"12",	[2,8,2,0,0,0,0]],
	["Al",	"13",	[2,8,3,0,0,0,0]],
	["Si",	"14",	[2,8,4,0,0,0,0]],
	["P",	"15",	[2,8,5,0,0,0,0]],
	["S",	"16",	[2,8,6,0,0,0,0]],
	["Cl",	"17",	[2,8,7,0,0,0,0]],
	["Ar",	"18",	[2,8,8,0,0,0,0]],
	["K",	"19",	[2,8,8,1,0,0,0]],
	["Ca",	"20",	[2,8,8,2,0,0,0]],
	["Sc",	"21",	[2,8,9,2,0,0,0]],
	["Ti",	"22",	[2,8,10,2,0,0,0]],
	["V",	"23",	[2,8,11,2,0,0,0]],
	["Cr",	"24",	[2,8,13,1,0,0,0]],
	["Mn",	"25",	[2,8,13,2,0,0,0]],
	["Fe",	"26",	[2,8,14,2,0,0,0]],
	["Co",	"27",	[2,8,15,2,0,0,0]],
	["Ni",	"28",	[2,8,17,1,0,0,0]],
	["Cu",	"29",	[2,8,18,1,0,0,0]],
	["Zn",	"30",	[2,8,18,2,0,0,0]],
	["Ga",	"31",	[2,8,18,3,0,0,0]],
	["Ge",	"32",	[2,8,18,4,0,0,0]],
	["As",	"33",	[2,8,18,5,0,0,0]],
	["Se",	"34",	[2,8,18,6,0,0,0]],
	["Br",	"35",	[2,8,18,7,0,0,0]],
	["Kr",	"36",	[2,8,18,8,0,0,0]],
	["Rb",	"37",	[2,8,18,8,1,0,0]],
	["Sr",	"38",	[2,8,18,8,2,0,0]],
	["Y",	"39",	[2,8,18,9,2,0,0]],
	["Zr",	"40",	[2,8,18,10,2,0,0]],
	["Nb",	"41",	[2,8,18,12,1,0,0]],
	["Mo",	"42",	[2,8,18,13,1,0,0]],
	["Tc",	"43",	[2,8,18,13,2,0,0]],
	["Ru",	"44",	[2,8,18,15,1,0,0]],
	["Rh",	"45",	[2,8,18,16,1,0,0]],
	["Pd",	"46",	[2,8,18,18,0,0,0]],
	["Ag",	"47",	[2,8,18,18,1,0,0]],
	["Cd",	"48",	[2,8,18,18,2,0,0]],
	["In",	"49",	[2,8,18,18,3,0,0]],
	["Sn",	"50",	[2,8,18,18,4,0,0]],
	["Sb",	"51",	[2,8,18,18,5,0,0]],
	["Te",	"52",	[2,8,18,18,6,0,0]],
	["I",	"53",	[2,8,18,18,7,0,0]],
	["Xe",	"54",	[2,8,18,18,8,0,0]],
	["Cs",	"55",	[2,8,18,18,8,1,0]],
	["Ba",	"56",	[2,8,18,18,8,2,0]],
	["La",	"57",	[2,8,18,18,9,2,0]],
	["Ce",	"58",	[2,8,18,19,9,2,0]],
	["Pr",	"59",	[2,8,18,21,8,2,0]],
	["Nd",	"60",	[2,8,18,22,8,2,0]],
	["Pm",	"61",	[2,8,18,23,8,2,0]],
	["Sm",	"62",	[2,8,18,24,8,2,0]],
	["Eu",	"63",	[2,8,18,25,8,2,0]],
	["Gd",	"64",	[2,8,18,25,9,2,0]],
	["Tb",	"65",	[2,8,18,27,8,2,0]],
	["Dy",	"66",	[2,8,18,28,8,2,0]],
	["Ho",	"67",	[2,8,18,29,8,2,0]],
	["Er",	"68",	[2,8,18,30,8,2,0]],
	["Tm",	"69",	[2,8,18,31,8,2,0]],
	["Yb",	"70",	[2,8,18,32,8,2,0]],
	["Lu",	"71",	[2,8,18,32,9,2,0]],
	["Hf",	"72",	[2,8,18,32,10,2,0]],
	["Ta",	"73",	[2,8,18,32,11,2,0]],
	["W",	"74",	[2,8,18,32,12,2,0]],
	["Re",	"75",	[2,8,18,32,13,2,0]],
	["Os",	"76",	[2,8,18,32,14,2,0]],
	["Ir",	"77",	[2,8,18,32,15,2,0]],
	["Pt",	"78",	[2,8,18,32,17,1,0]],
	["Au",	"79",	[2,8,18,32,18,1,0]],
	["Hg",	"80",	[2,8,18,32,18,2,0]],
	["Tl",	"81",	[2,8,18,32,18,3,0]],
	["Pb",	"82",	[2,8,18,32,18,4,0]],
	["Bi",	"83",	[2,8,18,32,18,5,0]],
	["Po",	"84",	[2,8,18,32,18,6,0]],
	["At",	"85",	[2,8,18,32,18,7,0]],
	["Rn",	"86",	[2,8,18,32,18,8,0]],
	["Fr",	"87",	[2,8,18,32,18,8,1]],
	["Ra",	"88",	[2,8,18,32,18,8,2]],
	["Ac",	"89",	[2,8,18,32,18,9,2]],
	["Th",	"90",	[2,8,18,32,18,10,2]],
	["Pa",	"91",	[2,8,18,32,20,9,2]],
	["U",	"92",	[2,8,18,32,21,9,2]],
	["Np",	"93",	[2,8,18,32,22,9,2]],
	["Pu",	"94",	[2,8,18,32,24,8,2]],
	["Am",	"95",	[2,8,18,32,25,8,2]],
	["Cm",	"96",	[2,8,18,32,25,9,2]],
	["Bk",	"97",	[2,8,18,32,27,8,2]],
	["Cf",	"98",	[2,8,18,32,28,8,2]],
	["Es",	"99",	[2,8,18,32,29,8,2]],
	["Fm",	"100",	[2,8,18,32,30,8,2]],
	["Md",	"101",	[2,8,18,32,31,8,2]],
	["No",	"102",	[2,8,18,32,32,8,2]],
	["Lr",	"103",	[2,8,18,32,32,8,3]],
	["Rf",	"104",	[2,8,18,32,32,10,2]],
	["Db",	"105",	[2,8,18,32,32,11,2]],
	["Sg",	"106",	[2,8,18,32,32,12,2]],
	["Bh",	"107",	[2,8,18,32,32,13,2]],
	["Hs",	"108",	[2,8,18,32,32,14,2]],
	["Mt",	"109",	[2,8,18,32,32,15,2]],
	["Ds",	"110",	[2,8,18,32,32,16,2]],
	["Rg",	"111",	[2,8,18,32,32,17,2]],
	["Cn",	"112",	[2,8,18,32,32,18,2]],
	["Nh",	"113",	[2,8,18,32,32,18,3]],
	["Fl",	"114",	[2,8,18,32,32,18,4]],
	["Mc",	"115",	[2,8,18,32,32,18,5]],
	["Lv",	"116",	[2,8,18,32,32,18,6]],
	["Ts",	"117",	[2,8,18,32,32,18,7]],
	["Og",	"118",	[2,8,18,32,32,18,8]]];

 
// Translate old names
function ename(el) = ((el == "Uut") ? "Nh" :
                      (el == "Uup") ? "Mc" :
                      (el == "Uus") ? "Ts" :
                      (el == "Uuo") ? "Og" : el);

// Get all data about element [el]
function edata(el) = elements[search(el, elements)[0]];

module joint()
{
    // Create simple pivot joint structure
    over=rt/6;
    v=rt/2-gap/2;
    ct=rt+2*over+zero;
    scale([1, 2, 2])
    rotate([0, 90, 0])
    cylinder(d2=v, d1=v, h=ct*2, center=true, $fn=32);
}

module gapjoint()
{
    // Make joint scaled-up for tolerancing
    s=(rt+4*gap)/rt;
    scale([s, s, s])
    joint();
}

module ring(er=0, dia=rm, thick=rt, tall=rh)
{
    // Create a ring
    difference() {
        cylinder(d=dia+thick/2, h=tall);
        cylinder(d=dia-thick/2, h=3*tall, center=true);
        if (er > 0) {
            for (a=[1,-1])
            translate([a*dia/2, 0, rh/2])
            gapjoint();
        }
    }
}

module bar(xdim, ydim=rh)
{
    intersection() {
        cube([xdim, ydim, ydim], center=true);
        rotate([45, 0, 0])
        cube([xdim, ydim*1.2, ydim*1.2], center=true);
    }
}

module ties(joiner=1, dia1=rm, dia2=rm+rs, tall=rh)
{
    // Create ties between rings
    tied=2.5*rt+dia2-dia1;
    for (a=[0:joiner])
    mirror([a, 0, 0])
    translate([(dia1+dia2)/4, 0, tall/2])
    difference() {
        translate([(1.5*rt)/2, 0, 0])
        bar(tied/2);
        if (joiner > 0)
        translate([(dia2-dia1)/4, 0, 0])
        difference() {
            translate([-dia2/2, 0, 0])
            difference() {
                sphere(d=dia2+rt/2+2*gap);
                sphere(d=dia2-rt/2-2*gap);
            }
            
            joint();
        }
    }
}

module gapties(dia1=rm, dia2=rm+rs, tall=rh)
{
    // Create gap ties between rings
    translate([0, 0, tall/2])
    rotate([0, 90, 0])
    cylinder(d=tall+3*gap, h=3*dia2, center=true, $fn=32);
}

module stand(dia)
{
    long = (dia-rh)/2;
    tilt = 45/2;
    
    difference() {
        rotate([0, 0, -90])
        ties(0, dia-rs, dia+rs);
        translate([0, -dia/2, rh/2])
        rotate([90-tilt, 0, 0])
        translate([0, 0, rh/2])
        cylinder(d=dia, h=dia, $fn=4);
    }
    
    translate([0, -dia/2, rh/2])
    rotate([-tilt, 0, 0])
    for (a=[1,-1])
    rotate([0, a*60, 0])
    translate([-a*long/2, 0, 0])
    bar(long);
}

module hanger(dia)
{
    long = (dia-rh)/2;
    
    rotate([0, 0, -90])
    difference() {
        ties(0, dia-rs, dia);
        hull()
        for (a=[0,-rt])
        translate([dia/2+a, 0, 0])
        cylinder(d=rt, h=3*rh, $fn=32);
    }
}

module electrons(num=2, dia=rm, thick=rt, tall=rh)
{
    // Populate ring with electrons
    for (a=[1:1:num])
    rotate([0, 0, a*(360/num)])
    translate([dia/2, 0, 0])
    cylinder(d=rs/3, h=tall, $fn=30);
}

module nucleus(rot, up, down)
{
    // Create nucleus
    union() {
        // Ring around text
        ring(0, rm-rs);

        // Raised text on top
        translate([0, 0, rh/2])
        scale([0.75, 0.75, rh/2])
        union() {
            translate([0, rs/2.5, 0])
            linear_extrude(height=1, convexity=10, $fn=60)
            text(text=up, halign="center", valign="center");
            translate([0, -rs/2.5, 0])
            linear_extrude(height=1, convexity=10, $fn=60)
            text(text=down, halign="center", valign="center");
        }

        // Embossed text on bottom    
        difference() {
            cylinder(d=rm-rs, h=rh/2);
            scale([-0.75, 0.75, rh/4])
            rotate([0, 0, rot])
            union() {
                translate([0, rs/2.5, 0])
                linear_extrude(height=1, convexity=10, $fn=60)
                text(text=up, halign="center", valign="center");
                translate([0, -rs/2.5, 0])
                linear_extrude(height=1, convexity=10, $fn=60)
                text(text=down, halign="center", valign="center");
            }
        }
    }
}
    


module print_part()
{
    e = edata([ename(element)]);
    ering = e[2];

    // How many occupied rings?
    c = (ering[6] > 0) ? 7 :
        (ering[5] > 0) ? 6 :
        (ering[4] > 0) ? 5 :
        (ering[3] > 0) ? 4 :
        (ering[2] > 0) ? 3 :
        (ering[1] > 0) ? 2 : 1;

    echo(e[0], " has ", c, " occupied rings");
    
    // Rotations need for mount?
    nrot = ((mount != "None") && ((c % 2) == 0)) ? 90 : 180;
    mrot = ((mount != "None") && ((c % 2) == 0)) ? 90 : 0;

    rotate([0, 0, mrot])
    union() {
        // Make nucleus
        rotate([0, 0, nrot])
        nucleus(((mount == "Stand") ? 180 : 0), e[0], e[1]);

        // For each active ring
        for (er=[0:1:c-1]) {
            // Make the ring
            rotate([0, 0, 90*(er%2)])
            ring(1, rm+rs*er);
    
            // Place the electrons
            // with fancy logic to avoid hitting ties...
            difference() {
                rotate([0, 0, 90*((er+1)%2) +
                       (((ering[er] % 4) == 0) ? 180/ering[er] :
                        (ering[er] == 2) ? 45 :
                        (ering[er] == 1) ? (((er == 0) && (er == c-1)) ? 0 : 45) :
                        0)])
                electrons(ering[er], rm+rs*er);
        
                // Diff-out space for the ties between rings
                rotate([0, 0, 90*(er%2)])
                gapties(rm+rs*(er-1), rm+rs*er);
            }
    
            // Place the actual ties between rings
            rotate([0, 0, 90*(er%2)])
            ties(1, rm+rs*(er-1), rm+rs*er);
        }
    }

    // Make optional mount
    if (mount == "Stand") {
        stand(rm+rs*c);
    } else if (mount == "Hanger") {
        hanger(rm+rs*c);
    }
}

print_part();


