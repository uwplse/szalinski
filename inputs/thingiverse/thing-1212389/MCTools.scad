//Minecraft Tools
//Developed by Rich Pereira
//rich@pereira.com
//--------------------------
//More to come!
//--------------------------


//CUSTOMIZER VARIABLES

//	Select tool
tool = 8;	//	[1:Spade, 2:Pickaxe, 3:Axe, 4:Hoe, 5:Sword, 6:Egg, 7:Bow, 8: BowAndArrow]

//	Scale (tenths of mm per cube)
cube_size = 30;	//	[1:50]

//  Whether to add a hanger hole ath -1, -1
hanghole = 1;  // [0:No, 1: Yes]

//CUSTOMIZER VARIABLES END

scale([cube_size/10,cube_size/10,cube_size/10]) {
    if (tool==1) spade();
    if (tool==2) pick();
    if (tool==3) axe();
    if (tool==4) hoe();
    if (tool==5) sword();
    if (tool==6) egg();
    if (tool==7) bow();
    if (tool==8) bow_and_arrow();
        
    if (hanghole == 1) {
        translate([-2,0,0]) cube([3,1,1]);
        translate([-2,-2,0]) cube([3,1,1]);
        translate([-2,-1,0]) cube([1,1,1]);
        translate([0,-1,0]) cube([1,1,1]);
    }
}



module bow_and_arrow() {
    // move the model so the hanger hole is in a good place
    translate([16,14,0]) mirror([1,1,0]) {
    // body
    translate([10,14,0]) cube([4,1,1]);
    translate([7,13,0]) cube([8,1,1]);
    translate([5,12,0]) cube([9,1,1]);
    translate([4,11,0]) cube([6,1,1]);
    translate([3,10,0]) cube([4,1,1]);
    translate([2,9,0]) cube([3,1,1]);
    translate([2,8,0]) cube([3,1,1]);
    translate([1,7,0]) cube([3,1,1]);
    translate([1,6,0]) cube([3,1,1]);
    translate([1,5,0]) cube([3,1,1]);
    translate([0,4,0]) cube([3,1,1]);
    translate([0,3,0]) cube([3,1,1]);
    translate([0,2,0]) cube([3,1,1]);
    translate([0,1,0]) cube([3,1,1]);
    translate([1,0,0]) cube([1,1,1]);
    // string
    stringcube=1.1;
    translate([3,1,0]) cube([stringcube,stringcube,1]);
    translate([4,2,0]) cube([2*stringcube,stringcube,1]);
    translate([6,3,0]) cube([stringcube,stringcube,1]);
    translate([7,4,0]) cube([2*stringcube,stringcube,1]);
    translate([9,5,0]) cube([stringcube,stringcube,1]);
    translate([10,6,0]) cube([stringcube,2*stringcube,1]);
    translate([11,8,0]) cube([stringcube,stringcube,1]);
    translate([12,9,0]) cube([stringcube,2*stringcube,1]);
    translate([13,11,0]) cube([stringcube,stringcube,1]);
    
    // arrow
    translate([8,6,0]) cube([2,1,1]);
    translate([7,7,0]) cube([2,1,1]);
    translate([6,8,0]) cube([2,1,1]);
    translate([5,9,0]) cube([2,1,1]);
    translate([4,10,0]) cube([2,1,1]);
    translate([3,11,0]) cube([2,1,1]);
    translate([2,12,0]) cube([2,1,1]);
    translate([1,13,0]) cube([2,1,1]);
    translate([0,14,0]) cube([2,1,1]);
}
};

module bow() {
    // body
    translate([10,14,0]) cube([4,1,1]);
    translate([7,13,0]) cube([8,1,1]);
    translate([5,12,0]) cube([9,1,1]);
    translate([4,11,0]) cube([6,1,1]);
    translate([3,10,0]) cube([4,1,1]);
    translate([2,9,0]) cube([3,1,1]);
    translate([2,8,0]) cube([3,1,1]);
    translate([1,7,0]) cube([3,1,1]);
    translate([1,6,0]) cube([3,1,1]);
    translate([1,5,0]) cube([3,1,1]);
    translate([0,4,0]) cube([3,1,1]);
    translate([0,3,0]) cube([3,1,1]);
    translate([0,2,0]) cube([3,1,1]);
    translate([0,1,0]) cube([3,1,1]);
    translate([1,0,0]) cube([1,1,1]);
    // string
    stringcube=1.05;
    translate([3,2,0]) cube([stringcube,stringcube,1]);
    translate([4,3,0]) cube([stringcube,stringcube,1]);
    translate([5,4,0]) cube([stringcube,stringcube,1]);
    translate([6,5,0]) cube([stringcube,stringcube,1]);
    translate([7,6,0]) cube([stringcube,stringcube,1]);
    translate([8,7,0]) cube([stringcube,stringcube,1]);
    translate([9,8,0]) cube([stringcube,stringcube,1]);
    translate([10,9,0]) cube([stringcube,stringcube,1]);
    translate([11,10,0]) cube([stringcube,stringcube,1]);
    translate([12,11,0]) cube([stringcube,stringcube,1]);
};

module spade() {
    translate([9,12,0]) cube([3,1,1]);
    translate([8,11,0]) cube([5,1,1]);
    translate([7,10,0]) cube([6,1,1]);
    translate([6,9,0]) cube([7,1,1]);
    translate([7,8,0]) cube([5,1,1]);
    translate([6,7,0]) cube([5,1,1]);
    translate([5,6,0]) cube([3,1,1]);
    translate([4,5,0]) cube([3,1,1]);
    translate([3,4,0]) cube([3,1,1]);
    translate([2,3,0]) cube([3,1,1]);
    translate([0,2,0]) cube([4,1,1]);
    translate([0,1,0]) cube([3,1,1]);
    translate([1,0,0]) cube([2,1,1]);
    translate([9,6,0]) cube([1,1,1]);
};

module pick() {
    translate([4,12,0]) cube([5,1,1]);
    translate([3,11,0]) cube([9,1,1]);
    translate([4,10,0]) cube([8,1,1]);
    translate([8,9,0]) cube([4,1,1]);
    translate([7,8,0]) cube([6,1,1]);
    translate([6,7,0]) cube([3,1,1]);
    translate([5,6,0]) cube([3,1,1]);
    translate([4,5,0]) cube([3,1,1]);
    translate([3,4,0]) cube([3,1,1]);
    translate([2,3,0]) cube([3,1,1]);
    translate([1,2,0]) cube([3,1,1]);
    translate([0,1,0]) cube([3,1,1]);
    translate([0,0,0]) cube([2,1,1]);
    translate([10,7,0]) cube([3,1,1]);
    translate([10,6,0]) cube([3,1,1]);
    translate([10,5,0]) cube([3,1,1]);
    translate([10,4,0]) cube([3,1,1]);
    translate([11,3,0]) cube([1,1,1]);
};

module axe() {
    translate([8,14,0]) cube([2,1,1]);
    translate([7,13,0]) cube([4,1,1]);
    translate([6,12,0]) cube([5,1,1]);
    translate([5,11,0]) cube([7,1,1]);
    translate([5,10,0]) cube([7,1,1]);
    translate([6,9,0]) cube([7,1,1]);
    translate([7,8,0]) cube([6,1,1]);
    translate([6,7,0]) cube([3,1,1]);
    translate([5,6,0]) cube([3,1,1]);
    translate([4,5,0]) cube([3,1,1]);
    translate([3,4,0]) cube([3,1,1]);
    translate([2,3,0]) cube([3,1,1]);
    translate([1,2,0]) cube([3,1,1]);
    translate([0,1,0]) cube([3,1,1]);
    translate([0,0,0]) cube([2,1,1]);
    translate([10,7,0]) cube([2,1,1]);
};

module hoe() {
    translate([5,13,0]) cube([3,1,1]);
    translate([4,12,0]) cube([5,1,1]);
    translate([5,11,0]) cube([7,1,1]);
    translate([7,10,0]) cube([5,1,1]);
    translate([8,9,0]) cube([4,1,1]);
    translate([7,8,0]) cube([4,1,1]);
    translate([6,7,0]) cube([3,1,1]);
    translate([5,6,0]) cube([3,1,1]);
    translate([4,5,0]) cube([3,1,1]);
    translate([3,4,0]) cube([3,1,1]);
    translate([2,3,0]) cube([3,1,1]);
    translate([1,2,0]) cube([3,1,1]);
    translate([0,1,0]) cube([3,1,1]);
    translate([0,0,0]) cube([2,1,1]);
};

module egg() {
    translate([4,12,0]) cube([4,1,1]);
    translate([3,11,0]) cube([6,1,1]);
    translate([2,10,0]) cube([8,1,1]);
    translate([1,9,0]) cube([9,1,1]);
    translate([1,8,0]) cube([10,1,1]);
    translate([0,7,0]) cube([11,1,1]);
    translate([0,6,0]) cube([12,1,1]);
    translate([0,5,0]) cube([12,1,1]);
    translate([0,4,0]) cube([12,1,1]);
    translate([1,3,0]) cube([10,1,1]);
    translate([1,2,0]) cube([10,1,1]);
    translate([2,1,0]) cube([8,1,1]);
    translate([3,0,0]) cube([6,1,1]);
};

module sword() {
    translate([13,15,0]) cube ([3,1,1]);
    translate([12,14,0]) cube ([4,1,1]);
    translate([11,13,0]) cube ([5,1,1]);
    translate([10,12,0]) cube ([5,1,1]);
    translate([9,11,0]) cube ([5,1,1]);
    translate([8,10,0]) cube ([5,1,1]);
    translate([2,9,0]) cube ([2,1,1]);
    translate([2,8,0]) cube ([3,1,1]);
    translate([3,7,0]) cube ([7,1,1]);
    translate([3,6,0]) cube ([6,1,1]);
    translate([4,5,0]) cube ([4,1,1]);
    translate([3,4,0]) cube ([6,1,1]);
    translate([2,3,0]) cube ([3,1,1]);
    translate([0,2,0]) cube ([4,1,1]);
    translate([0,1,0]) cube ([3,1,1]);
    translate([0,0,0]) cube ([3,1,1]);
    translate([7,9,0]) cube ([5,1,1]);
    translate([6,8,0]) cube ([5,1,1]);
    translate([6,3,0]) cube ([4,1,1]);
    translate([8,2,0]) cube ([2,1,1]);
};

