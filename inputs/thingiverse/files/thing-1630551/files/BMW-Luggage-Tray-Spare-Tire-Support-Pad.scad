// model: BMW Luggage Tray Spare Tire Support Pad (BMW Part No. 51471930956 (28mm), 51471960706	(19.5mm)
// author: fiveangle@gmail.com
// date: 2015jun10
// ver: 1.0.0
// notes: default parameters create BMW Part No. 51471930956 (28mm), customizer options for BMW Part No. 51471960706 (19.5mm)
// history:
//     -1.0.0 - Released
//

// adjust to increase/decrease polygon count at expense of processing time
$fn = 200;

// Pad Diameter (stock is 65mm but 80mm adds additional support)
padDiameter=65; // [65:Stock (65mm), 80:Improved (80mm)]

// Pad Height (stock is either 28mm: 51471930956 or 18.5mm: 51471960706)
padHeight=28; // [28:Part No. 51471930956 (28mm), 19.5:Part No. 51471960706 (19.5mm)]

// Threaded support diameter
threadedSupportDiameter=14; // [14:Stock (14mm), 16:Improved (16mm), 18:Hulk Smash (18mm)]

// Threaded support end diameter
threadedSupportEndDiamter=12; // [12:Stock Wingnut (12mm), 14:Improved (14mm) - may interfere with wingnut, 16:Regular Nut (16mm) - likely won't fit with wingnut]

// Threaded Support Length (can make longer than stock 14mm, depending on threaded rod length above tightened wingnut)
threadedSupportLength=14; //  [14:28]

// Pad Thickness
padThickness=4; // [4:Stock (4mm), 6:Improved (6mm), 8:Hulk Smash (8mm)]

// Threaded Rod Diameter
threadedRodDiameter=7.64;

rotate_extrude() {
    polygon(
        points=[
            [0,0],
            [(padDiameter/2),0],
            [(padDiameter/2),padThickness],
            [(threadedSupportDiameter/2),padHeight-padThickness],
            [(threadedSupportEndDiamter/2),threadedSupportLength+padHeight-padThickness],
            [(threadedRodDiameter/2),threadedSupportLength+padHeight-padThickness],
            [(threadedRodDiameter/2),padHeight-padThickness],
            [0,padHeight-padThickness],
        ]
    );
}
