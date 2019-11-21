// Size of one pentomino unit square (in mm)
length=10;

// Number of rows
tray_rows=6;

// Number of columns
tray_cols=10;

// Thickness of walls and floor (in mm)
wall=4;


module tray() {
	difference() {
		cube([tray_cols*length + 2*wall, tray_rows*length + 2*wall, length/2+wall]);
		translate([wall, wall, wall])
			cube([tray_cols*length, tray_rows*length, length/2+1]);
	}
}

tray();