// 2018/05/06 v1.0 Laurie Gellatly 
// 2018/06/09 v1.1 Only draw the closest 'bars'bolt_hole_diameter
// 2018/06/10 v1.2 Add stand_offs and recess nuts
// Customiseable mount plate
// 

// (3.4 for M3 bolts) slightly larger than bolt diameter?
bolt_hole_diameter  = 3.4; // [1.1:0.1:5]
// for chosen bolt (use 6.2 for M3)?
hex_nut_hole_diameter   = 6.2; // [3:0.1:10]
// above plate?
stand_off = 2;       // [0:0.1:10]
stand_off_diameter = 10;         // [5:0.1:12]
// by bars?
nearest_holes_connected = 1;           // [1:5]
// of all the holes (',' between and no spaces)?
x_values="0,0,95,0,6.3,81.3,82.5";
// of all the holes (in the same order as X)?
y_values="0,95,0,48.4,0,0,48.4";
// is 0 for underneath, 1 for on top, 2 for none (in same order as X) ?
nut_side="1,1,1,0,0,0,0";

/* [Hidden] */
nut_thickness = 2.4;
hole_depth = 1 + nut_thickness; // The extra 1 makes the nut recessed
plate_thickness = hole_depth + 1.8;
abit=0.01;

function substr(s, st, en, p="") =
    (st >= en || st >= len(s)) ? p : substr(s, st+1, en, str(p, s[st]));

// Thanks to Jesse for atof and atoi
// Jesse Campbell
// www.jbcse.com
// OpenSCAD ascii string to number conversion function atof
// scientific notation support added by Alexander Pruss (thingiverse user arpruss)
// atoi are from http://www.thingiverse.com/roipoussiere

function atoi(str, base=10, i=0, nb=0) =
	i == len(str) ? (str[0] == "-" ? -nb : nb) :
	i == 0 && str[0] == "-" ? atoi(str, base, 1) :
	atoi(str, base, i + 1,
		nb + search(str[i], "0123456789ABCDEF")[0] * pow(base, len(str) - i - 1));
    
function atof(str) = len(str) == 0 ? 0 : let( expon1 = search("e", str), expon = len(expon1) ? expon1 : search("E", str)) len(expon) ? atof(substr(str,pos=0,len=expon[0])) * pow(10, atoi(substr(str,pos=expon[0]+1))) : let( multiplyBy = (str[0] == "-") ? -1 : 1, str = (str[0] == "-" || str[0] == "+") ? substr(str, 1, len(str)-1) : str, decimal = search(".", str), beforeDecimal = decimal == [] ? str : substr(str, 0, decimal[0]), afterDecimal = decimal == [] ? "0" : substr(str, decimal[0]+1) ) (multiplyBy * (atoi(beforeDecimal) + atoi(afterDecimal)/pow(10,len(afterDecimal)))); 
// End Jesse Campbell

function split(h, s, p=[]) =
    let(x = search(h, s)) 
    x == []
        ? concat(p, s)
        : let(i=x[0], l=substr(s, 0, i), r=substr(s, i+1, len(s)))
                split(h, r, concat(p, l));

// input : list of pairs of numbers
// output : sorted list (by second number) of paired number 
function quicksort(arr) = !(len(arr)>0) ? [] : let(
    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (y[1]  < pivot[1]) y ],
    equal   = [ for (y = arr) if (y[1] == pivot[1]) y ],
    greater = [ for (y = arr) if (y[1]  > pivot[1]) y ]
) concat(
    quicksort(lesser), equal, quicksort(greater)
);

function distarray(p, holes) = [for (c=[p+1:1:len(holes)-1]) [c,distance(holes[p],holes[c])]];
    
function distance(pos1,pos2)= // Find the distance between pos1 and pos2
    pow(pow(pos1[0] - pos2[0], 2) + pow(pos1[1] - pos2[1], 2), 0.5); // ((x1-x2)^2 + (y1-y2)^2)^.5)


function angle(pos1,pos2) = // Find the angle from pos1 to pos2
    atan((pos2[1] - pos1[1]) / (pos2[0] - pos1[0])) + ((pos2[0] < pos1[0]) ? 180 : 0); // atan((y2-y1)/ (x2-x1))
//    atan((pos2[1] - pos1[1]) / pow(pos2[0] - pos1[0])); // atan((y2-y1)/ (x2-x1))

module pad(pos){    // draw a pad at pos
    translate([pos[0],pos[1],0]) cylinder(d=stand_off_diameter, h=stand_off+plate_thickness);
}

module bar(pos1,pos2){  // Draw a bar between pos1 and pos2
    translate([pos1[0],pos1[1],0])rotate([0,0,angle(pos1,pos2)]) translate([0,-stand_off_diameter*0.5,0]) cube([distance(pos1,pos2), stand_off_diameter, plate_thickness]);
}
xv=split(",",x_values);
yv=split(",",y_values);
nv=split(",",nut_side);
if((len(xv) == len(yv)) && (len(xv) == len(nv))){
holes=[for (ind=[0:len(xv)-1]) [atof(xv[ind]),atof(yv[ind]),atoi(nv[ind])]];
   echo(holes);
difference(){
    union(){
        for(p=[0:1:len(holes)-1])
            pad(holes[p]);      // Draw a pad around each hole
        for(p=[0:1:len(holes)-1]){ // From a hole to every remaining hole
            dist = distarray(p,holes);   // Fnd the distances to them
            //echo(dist);
            mindist = quicksort(dist); // sort them by distance
            //echo(mindist);
            for(b=[0:1:nearest_holes_connected])   // Draw bars to the closest 'holes'
                bar(holes[p],holes[mindist[b][0]]);
        }
    }    
    for(p=[0:1:len(holes)-1]){
        translate([holes[p][0],holes[p][1],-abit]) cylinder(d=bolt_hole_diameter,h=stand_off+plate_thickness+2*abit);    // Bolt hole
        if(holes[p][2] != 2) translate([holes[p][0],holes[p][1],(holes[p][2] == 1)? stand_off+plate_thickness - hole_depth: -abit]) cylinder(d=hex_nut_hole_diameter,h=hole_depth+abit,$fn=6);    // Nut hole
    }
}
}else echo("Error:Input X, Y and nut_side values are not the same length!");