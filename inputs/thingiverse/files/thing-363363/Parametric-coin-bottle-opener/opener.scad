/**
 * Coin bottle opener
 * Designed by Niek Blankers <niek@niekproductions.com>
 * 
 * Set fill to 90-100% for best results.
 * Insert coin during printing!
 * 
 */

/**
 * 5 cent euro coin:
 * Diameter: 21.3
 * Thickness: 1.7
 *
 * 10 cent euro coin:
 * Diameter: 19.8 
 * Thickness: 2.0
 *
 * 20 cent euro coin:
 * Diameter: 22.3
 * Thickness: 2.2
 *
 * 50 cent euro coin:
 * Diameter: 24.3
 * Thickness: 2.4
 * 
 * US penny:
 * Diameter: 19.1
 * Thickness: 1.6
 *
 * US nickel:
 * Diameter: 21.2
 * Thickness: 2.0
 *
 * US dime:
 * Diameter: 17.9
 * Thickness: 1.4
 *
 * US quarter:
 * Diameter: 24.3
 * Thickness: 1.8
 *
 * US 50 cent:
 * Diameter: 30.6
 * Thickness: 2.2
 */

// Coin diameter
coinDiameter = 21.3; // [21.3:0.05 euro, 19.8:0.10 euro, 22.3:0.20 euro, 24.3:0.50 euro, 19.1:US penny, 21.2:US nickel, 17.9:US dime, 24.3:US quarter, 30.6:US 50 cent]

// Coin thickness
coinThickness = 1.7; // [1.7:0.05 euro, 2.0:0.10 euro, 2.2:0.20 euro, 2.4:0.50 euro, 1.6:US penny, 2.0:US nickel, 1.4:US dime, 1.8:US quarter, 2.2:US 50 cent]

// Coin clearance
coinClearance = 0.4;

// Coin offset from center
coinOffset = 5; // [0:10]

// Coin angle
coinAngle = 0; // [0:15]

// Opener width
width=45; // [40:100]

// Opener length
length=85; // [65:100]

// Opener height
height=7; // [5:20]

// Front opener width
frontWidth=45; // [45:105]

// Back opener width
backWidth = 15; // [10:100]

// Edge width
edgeWidth=5; // [2:20]

// Edge round radius
roundRadius=5; // [0:10]

// Logo cube size (WxLxH)
cubeSize = [4,4,1.5];

// Logo cube spacing
cubeSpacing = 6; // [1:10]

// For the Bitmap
bits=[
	[1,0,0],
	[1,0,0],
	[1,1,1],
	[1,0,1],
	[1,1,1]
];

openingWidth=width-(edgeWidth*2);
openingLength=16-coinOffset+coinDiameter/2;
openingHeight=height;
frontOpeningWidth=openingWidth+3;

frontLength = openingLength+edgeWidth*2;

chainHole = backWidth-4; //Keychain hole diameter

module handle(){
		hull(){
				translate([-(frontWidth-width)/2,0,0]) roundedRect([frontWidth,frontLength/2,height], roundRadius);
				translate([0,frontLength/2,0]) roundedRect([width,frontLength/2,height], roundRadius);
				translate([width/2,length-backWidth,height/2]) cylinder(h=height, r=backWidth/2, center=true);
		}
}

module opener(){
	difference(){
		union(){
			handle();
			translate([width/2 + (cubeSpacing*((len(bits[1])-1)/2)),frontLength + (length-frontLength)/((length-frontLength)/cubeSize[1]),height+cubeSize[2]/2]) rotate(a=[0,0,180]) drawBitmap(bits, cubeSpacing, cubeSize);
		}

		translate([(width/2)-(openingWidth/2),edgeWidth,-1]) hull(){
			translate([-(frontOpeningWidth-openingWidth)/2,0,0]) roundedRect([frontOpeningWidth,openingLength/2,openingHeight+2], roundRadius);
			translate([0,openingLength/2,0]) roundedRect([openingWidth,openingLength/2,openingHeight+2], roundRadius);
		}

		translate([width/2,edgeWidth+openingLength+coinOffset,height/2]) rotate(a=-coinAngle,v=[1,0,0]){
			cylinder(h = coinThickness+coinClearance*2, r = (coinDiameter+coinClearance)/2, center = true);
		}

		translate([width/2,length-backWidth,height/2]) scale([1.0,0.8,1.0]) cylinder(h=height+1, r=chainHole/2, center=true);

	}	

}

opener();


module roundedRect(size, radius) { // from http://www.thingiverse.com/thing:9347/#comments
	x = size[0];
	y = size[1];
	z = size[2];
	
	linear_extrude(height=z)
		hull() {
			translate([radius, radius, 0])
			circle(r=radius);
	
			translate([x - radius, radius, 0])
			circle(r=radius);
	
			translate([x - radius, y - radius, 0])
			circle(r=radius);
	
			translate([radius, y - radius, 0])
			circle(r=radius);
	}
}

/**
 * drawBitmap module
 * By Niek Blankers <niek@niekproductions.com>
 *
 * @param	array		bits			Bitmap array
 * @param	decimal	cubeSpacing	
 * @param	decimal	cubeSize
 *
 * Example:
 *
	bits=[
	[1,0,0,1,0,1,0,1,1,1,0,1,0,0,1],
	[1,1,0,1,0,1,0,1,0,0,0,1,0,1,0],
	[1,0,1,1,0,1,0,1,1,0,0,1,1,0,0],
	[1,0,0,1,0,1,0,1,0,0,0,1,0,1,0],
	[1,0,0,1,0,1,0,1,1,1,0,1,0,0,1]
	];
	cubeSize = 4;
	cubeSpacing = 5;

	drawBitmap(bits, cubeSpacing, cubeSize);
 *
 */

module drawBitmap(bits, cubeSpacing, cubeSize){
	rotate(a=180, v=[1,0,0]){
		for(i=[0:len(bits)-1]){
			translate([0,i*cubeSpacing,0]){
				for(x=[0:len(bits[i])-1]){
					translate([x*cubeSpacing,0,0]) cube(size = bits[i][x]*cubeSize, center = true);
				}
			}
		}
	}
}