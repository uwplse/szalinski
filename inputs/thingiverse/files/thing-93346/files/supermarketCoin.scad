//Height of the thing. Should be about the same height as the coins.
height = 2.3;
//Diameter of the coin the supermarket carts accept (If they accept two sizes, it's probably a good idea to pick something in between)
coindiameter = 23.5;
//Length of the holderthingy in the back. measured from the senter of the coin
holderlength = 45;
//Optional dxf file if you want to have some logo on your thing. Won't work in customizer, so simply leave it empty.
//dxffile = "teardrop.dxf";
dxffile = "";

module SupermarketCoin(height, coindiameter, holderlength, dxffile = "")  {
	difference() {
		union() {
			cylinder(h=height, r=coindiameter/2, $fn=50);
			
			difference() {
				translate([-coindiameter*0.35, 0, 0])
				cube([coindiameter*0.7, holderlength, height]);
				translate([0, holderlength - 5, 0])
				cylinder(h=height, r=2, $fn=50);
			}
		}
		if (dxffile != "") {
			translate([0,0,height-0.5])
			rotate([0, 0, 180])
			linear_extrude(height=0.5)
			import(dxffile);
		}
	}
}

SupermarketCoin(height, coindiameter, holderlength, dxffile);