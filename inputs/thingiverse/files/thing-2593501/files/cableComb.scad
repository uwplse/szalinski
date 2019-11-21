    /*customizeable cable comb*/
        /*by Marchogwyn*/
        
//Variables

//Diameter of the hole for the cable you want to hold. Add tolerancing if you want the clip to be snug or loose.
wire_size=3.5;

//Number of wires to hold.
wires=10;

//Single or double row of holes?
rows=1;//[1:single,0:double]

//tightness of the opening in the form of wire size - gap. Set to lower values to make the cables easier to get in and out of the clip
gap=1;

//spacing between the holes. Also the thickness of the spine of the clip
spacing=1;

//z-height of the clip
height=4;

/* [hidden] */
//resolution
$fs=0.5;

//Modules
module comb(slots=10){
    difference(){ 
        hull()
            for(i=[0:1])
                translate([i*(slots-1)*(wire_size+spacing),0,0])
                    circle(d=(wire_size+spacing*2));
        for(i=[0:slots-1]){
            translate([i*(wire_size+spacing),0,0]){
                circle(d=wire_size);
            
                translate([0,(wire_size/2+spacing)/2,0])
                    square([wire_size-gap,wire_size/2+spacing],center=true);
            
                translate([0,(wire_size+spacing*2)/2,0])
                rotate([0,0,45])
                    square(1.4142*(wire_size+spacing)/2,center=true);
            }
        }
    }
}

//Render

//single line of holes
if(rows){
    linear_extrude(height=height)comb(wires);
}

//double line of holes
else if((!rows)&&(wires%2==0)){//if there are an even number of holes
    linear_extrude(height=height){
        comb(wires/2);
        translate([0,-(wire_size+spacing),0])mirror([0,1,0])comb(wires/2);
    }
}
else{//if there are an odd number of holes
    linear_extrude(height=height){
        comb(ceil(wires/2));
        translate([(wire_size+spacing)/2,-(wire_size+spacing),0])
            mirror([0,1,0])comb(floor(wires/2));
    }
}