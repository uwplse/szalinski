ringid = 39;
ringod = 60;
ringh = 7.5;

//ring walls
walls = 1.5;
iwalls = walls*2; //inner wall
bwalls = 1; //bottom wall

//id of blower
bloweridx = 17.5;//13;
bloweridy = 12.5;//17.5;
blowerh = 7.5;
blowerwall = 1.2;

blowerodx = bloweridx + blowerwall*2;
blowerody = bloweridy + blowerwall*2;

towertransxu = 0;
towertransyu = 0;

boolmirror = 0;

towertransx = max(towertransxu,0) + ringid/2 + iwalls-blowerwall*2;
towertrans = [towertransx, -(blowerody)/2 + towertransyu,0];


connectingx = max(0,towertransx -ringid/2 - iwalls);

//cooling pipe targets
pipedrop = 10;
piper = 2/2;
piper2 = 3.5/2;
pipenum = 23;



echo(towertransx);
echo((ringod/2 + blowerwall * 2));
bool_extend = 
    (towertransx > (ringod/2 - 1 - walls - blowerwall * 2)) ? 
        true : false;

echo(bool_extend);

$fn = 60;


module ringbody() {
	difference() {
		cylinder(h = ringh, r = ringod/2);
		cylinder(h = ringh+1, r = ringid/2);
	}
}


module ringcut() {
	translate([0, 0, bwalls])
	difference() {
		cylinder(h = ringh - walls- bwalls, r = ringod/2 - walls);
		cylinder(h = ringh+1, r = ringid/2 + iwalls);
	}	

    height = sqrt(pow((ringid + ringod)/4,2) + pow(pipedrop + bwalls+ piper2,2));
	//pipes
	for (i = [0:360/pipenum:360]) {
		rotate([0, 0, i])

		translate([0,0,-pipedrop + piper - bwalls])
		rotate([0, atan((ringid/2 +iwalls)/(pipedrop + piper + bwalls)), 0])
        
        
        //rad = piper*(cos(i)+1)/2 + piper2*(-cos(i)+1)/2;
		#translate([0,0,0])cylinder(h = height, 
        //r = piper
        r = piper*(cos(i)+1)/2 + piper2*(-cos(i)+1)/2
        );
	
	}
	

}

module towerbody() {
	//vert
	cube([blowerodx, blowerody, blowerh]);
	translate([blowerwall, blowerwall,0])
		cube([bloweridx, bloweridy , blowerh + 5]);
    
    if (bool_extend)
    {
        //horiz connectiom
        translate([-connectingx, 0,0])
            cube([connectingx,blowerody, ringh]);
    }

}

module towercut() {
	//vert
	translate([blowerwall*2, blowerwall*2,bwalls])
		cube([bloweridx - blowerwall * 2, bloweridy - blowerwall * 2, blowerh + 5]);	

    if (bool_extend)
    {
        //horiz
        translate([-connectingx, blowerwall*2, bwalls])
            cube([connectingx+1 + blowerwall * 2,bloweridy - blowerwall*2, ringh - bwalls-walls]);
    }
}


module towerfinal() {
	translate(towertrans)
	{
		difference() {	
			towerbody();
			towercut();
			translate(-towertrans)
			ringcut();
		}
        
        if (!bool_extend){
            //supports
            translate([blowerwall*2,blowerwall*2,0])
            {
                translate([0, bloweridy - blowerwall*2, 0])
                cylinder(h = ringh,  r = 0.7);
                cylinder(h = ringh,  r = 0.7);
            }
        }
	}
}


if(boolmirror != 0)
{
	mirror([1, 0, 0])
	towerfinal();

}

towerfinal();

difference() {
	ringbody();
	ringcut();
	
	translate(towertrans)
		towercut();

	if(boolmirror != 0)
	{

		mirror([1, 0, 0])
		translate(towertrans)
			towercut();
	}
    
    //cutout for viewing
    //translate([-60,-60,5])cube([120,120,10]);
}

//towerbody();
