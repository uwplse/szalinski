
$fn=180;


// #### the bigger side of the adapter ####

// the 50mm pond hose from Praxis
// connect the hose to the inside
BiggerSideInnerDiameter=46;
BiggerSideOuterDiameter=BiggerSideInnerDiameter+2;


// #### the smaller side of the adapter ####

// the cyclone inlet (both)
// insert this adapter in to the cyclone
//SmallerSideOuterDiameter=40.1;
//SmallerSideInnerDiameter=SmallerSideOuterDiameter-2;

// the metabo tablesaw
// connect the tablesaw to the inside of this adapter
//SmallerSideInnerDiameter=43;
//SmallerSideOuterDiameter=SmallerSideInnerDiameter+2;

// the matabo Radial arm saw
// connect the Radial arm saw to the inside of this adapter
SmallerSideInnerDiameter=41;
SmallerSideOuterDiameter=SmallerSideInnerDiameter+2;


// #### You should not have to edit below this point ####

// 45 deg is the max overhang we can print
// the part that connects the bigger to the smaller must be atleast 
// as al long as it is wide (that makes at least 45 deg )
TaperHeight=(BiggerSideInnerDiameter-SmallerSideOuterDiameter);

// the first (larger) cylinder
difference ()
{
    cylinder(h = 30, d=BiggerSideOuterDiameter, center = false);
    cylinder(h = 30, d=BiggerSideInnerDiameter, center = false);
}

// the tapered cylinder
// on the outside the taper ends 1mm heigher
// on the inside the taper starts 1mm lower
// this is for added strength on the stress-points
translate (v = [0, 0, 30])
{
    difference ()
    {
        // create a taper with a ring at the underside
        union ()
        {
            //the taper
            cylinder(h = TaperHeight+1, d1=BiggerSideOuterDiameter, d2=SmallerSideOuterDiameter, center = false);
            //the ring unde the taper
            translate (v = [0, 0, -1]) cylinder(h = 1, d=BiggerSideInnerDiameter, center = false);
        }
        // remove the inside taper
        translate (v = [0, 0, -1]) cylinder(h = TaperHeight, d1=BiggerSideInnerDiameter, d2=SmallerSideInnerDiameter, center = false);
        //make sure the taper is open on the inside
        translate (v = [0, 0, -1]) cylinder(h = TaperHeight+2, d=SmallerSideInnerDiameter, center = false);
    }
}

//the second (smaller) cylinder
translate (v = [0, 0, 30+TaperHeight])
{
    difference ()
    {
        cylinder(h = 30, d=SmallerSideOuterDiameter, center = false);
        cylinder(h = 30, d=SmallerSideInnerDiameter, center = false);
    }
}