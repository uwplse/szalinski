$fn=10*1;  //More polygons

//Defines whether a pre-defined song or the NoteString shall be used.
SongPicker = "Star-Spangled Banner"; // [Note-String,Star-Spangled Banner]

//Defines where to set the holes for the notes. You have the notes c1 to c3. The first two characters define the note (c1,d1,e1...b1,c2,...c3), the last two characters define the beat. You have 50 beats to use. After every note-definition place a |. One c1 on the third beat would result in this NoteString: "c103|". Don't forget the | at the end!
NoteString = "c101|d102|e103|f104|g105|a106|b107|c208|d209|e210|f211|g212|a213|b214|c315|";

//The layer-thickness must not be more then 0.4mm. Otherwise it won't fit into the music box! Also try to print at least two layers - so slice it with a layer height of 0.2mm.
LayerThickness = 0.4;

//Defines the width of the stripe (in mm).
StripeWidth = 42; // [30:50]

//Defines the length of the stripe. 15 beats need a length around 60mm. The full 50 beats would need 200mm.
StripeLength = 90;// [10:200]

//For fine-tuning only: defines how far the c1 is away from the left stripe-border (in mm).
MarginLeft = 5; // [2:10]

//For fine-tuning only: defines the distance between the beats.
BeatDistance = 3.5;

//For fine-tuning only: defines the distance between the beats.
ToneDistance = 2;

Start( );

module Start()
{
NoteString_AmericanAnthem = "a101|f103|d104|f106|d106|a108|e108|d210|d110|f113|f214|f114|e215|f115|d216|f116|f118|d118|g120|d120|a122|c122|";

if( SongPicker == "Star-Spangled Banner")
	BuildStripe(NoteString_AmericanAnthem);
else if (SongPicker == "Note-String")
	BuildStripe(NoteString);
}

module BuildStripe(NoteStringLocal){
	takte=search("|",NoteStringLocal,1000)[0];
	difference()
	{
		BuildBase();
		for(i=[0:len(takte)-1])
		{
			printNote(str(NoteStringLocal[takte[i]-2],NoteStringLocal[takte[i]-1]), str(NoteStringLocal[takte[i]-4],NoteStringLocal[takte[i]-3]));
		}
	}
}

module printNote(takt,note)
{
	//I did not find a way to convert the string "01" into the number 1.
	//So there is this ugly convertion, I'm sorry. ;)
	if (takt == "01")
		printNote2(1,note);
	else if (takt == "02")
		printNote2(2,note);
	else if (takt == "03")
		printNote2(3,note);
	else if (takt == "04")
		printNote2(4,note);
	else if (takt == "05")
		printNote2(5,note);
	else if (takt == "06")
		printNote2(6,note);
	else if (takt == "07")
		printNote2(7,note);
	else if (takt == "08")
		printNote2(8,note);
	else if (takt == "09")
		printNote2(9,note);
	else if (takt == "10")
		printNote2(10,note);
	else if (takt == "11")
		printNote2(11,note);
	else if (takt == "12")
		printNote2(12,note);
	else if (takt == "13")
		printNote2(13,note);
	else if (takt == "14")
		printNote2(14,note);
	else if (takt == "15")
		printNote2(15,note);
	else if (takt == "16")
		printNote2(16,note);
	else if (takt == "17")
		printNote2(17,note);
	else if (takt == "18")
		printNote2(18,note);
	else if (takt == "19")
		printNote2(19,note);
	else if (takt == "20")
		printNote2(20,note);
	else if (takt == "21")
		printNote2(21,note);
	else if (takt == "22")
		printNote2(22,note);
	else if (takt == "23")
		printNote2(23,note);
	else if (takt == "24")
		printNote2(24,note);
	else if (takt == "25")
		printNote2(25,note);
	else if (takt == "26")
		printNote2(26,note);
	else if (takt == "27")
		printNote2(27,note);
	else if (takt == "28")
		printNote2(28,note);
	else if (takt == "29")
		printNote2(29,note);
	else if (takt == "30")
		printNote2(30,note);
	else if (takt == "31")
		printNote2(31,note);
	else if (takt == "32")
		printNote2(32,note);
	else if (takt == "33")
		printNote2(33,note);
	else if (takt == "34")
		printNote2(34,note);
	else if (takt == "35")
		printNote2(35,note);
	else if (takt == "36")
		printNote2(36,note);
	else if (takt == "37")
		printNote2(37,note);
	else if (takt == "38")
		printNote2(38,note);
	else if (takt == "39")
		printNote2(39,note);
	else if (takt == "40")
		printNote2(40,note);
	else if (takt == "41")
		printNote2(41,note);
	else if (takt == "42")
		printNote2(42,note);
	else if (takt == "43")
		printNote2(43,note);
	else if (takt == "44")
		printNote2(44,note);
	else if (takt == "45")
		printNote2(45,note);
	else if (takt == "46")
		printNote2(46,note);
	else if (takt == "47")
		printNote2(47,note);
	else if (takt == "48")
		printNote2(48,note);
	else if (takt == "49")
		printNote2(49,note);
	else if (takt == "50")
		printNote2(50,note);
	else
		printNote2(10,note);
}

module printNote2(takt,note)
{
	if (note == "c1")
		MakeHole(takt,1);
	else if (note == "d1")
		MakeHole(takt,2);
	else if (note == "e1")
		MakeHole(takt,3);
	else if (note == "f1")
		MakeHole(takt,4);
	else if (note == "g1")
		MakeHole(takt,5);
	else if (note == "a1")
		MakeHole(takt,6);
	else if (note == "b1") //h
		MakeHole(takt,7);
	else if (note == "c2")
		MakeHole(takt,8);
	else if (note == "d2")
		MakeHole(takt,9);
	else if (note == "e2")
		MakeHole(takt,10);
	else if (note == "f2")
		MakeHole(takt,11);
	else if (note == "g2")
		MakeHole(takt,12);
	else if (note == "a2")
		MakeHole(takt,13);
	else if (note == "b2") //h
		MakeHole(takt,14);
	else if (note == "c3")
		MakeHole(takt,15);
}

module BuildBase(){
	cube([StripeWidth,StripeLength,LayerThickness]);
}

module MakeHole(beatNumber,pitchNumber){
	Y = MarginLeft + (beatNumber * BeatDistance);
	X = StripeWidth - MarginLeft - (pitchNumber * ToneDistance) + 1;

	translate([X,Y,-1]) cylinder(h=LayerThickness*20,r=1);
}