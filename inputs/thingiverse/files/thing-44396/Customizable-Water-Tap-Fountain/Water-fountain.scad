 /* ----------------------------------------------------------------------------
	Public Variables
---------------------------------------------------------------------------- */
//Less is more powerful:
Fountain_Diameter = 10; // [5:60]

//Your tap diameter:
Tube_Diameter = 30; // [5:60]

// Want elegance?
Fountain_Size = 40;	 // [30:100]

//It's a pure design opinion:
Tube_Size = 30; // [20:70]

//More, it'll be easier to print:
Wall = 4;//	// [1:10]

/* ----------------------------------------------------------------------------
	Piece Creation
---------------------------------------------------------------------------- */
difference() {
union() { cylinder(Tube_Size,(Tube_Diameter/2)+Wall,(Tube_Diameter/2)+Wall); rotate([45,0,0]) cylinder(Fountain_Size,(Fountain_Diameter/2)+Wall,(Fountain_Diameter/2)+Wall);}
union() {  translate([0,0,-WheightTube/2])cylinder(Tube_Size*2,Tube_Diameter/2,Tube_Diameter/2); rotate([45,0,0]) cylinder(Fountain_Size+(Tube_Size/2),Fountain_Diameter/2,Fountain_Diameter/2);}
translate([-Tube_Size,-Tube_Size,-(Tube_Size*2)]) cube([Tube_Size*2,Tube_Size*2,Tube_Size*2]);
}