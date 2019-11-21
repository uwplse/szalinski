// Top connector type
Conector1Type = 2; // [2:2 Tabs, 3:3 Tabs]

// Bottom connector type
Conector2Type = 3; // [2:2 Tabs, 3:3 Tabs]
Length = 10; 
OffsetRotation = 0;
NutDiameter = 8;

/* [Hidden] */
$fn = 90;
_slotSize = 3;
_width = _slotSize * 5;
_holeDiameter = 5;
_delta = 1;

module createAdaptor(){
    
    union(){
        createBeam();
        translate([0, 0, Length/2 + _slotSize]){
            rotate([0, -90, 90 + OffsetRotation]){
                createConnector(Conector1Type, Conector1Type == 3);
            }
        }
        
        translate([0,0,-Length/2 - _slotSize]){
            rotate([0,90,90]){
                createConnector(Conector2Type, Conector2Type == 3);
            }
        }
    }
}

module createBeam(){
    hull(){
        rotate([0, 0, OffsetRotation]){
            translate([0, 0, Length / 2]){
                length = (Conector1Type * 2 - 1) * _slotSize;
                translate([-_width / 2, -length / 2]) cube([_width, length, _slotSize]);
            }
        }
        
        translate([0, 0, (-Length / 2 - _slotSize)]){
            length = (Conector2Type * 2 - 1) * _slotSize;
            translate([-_width / 2, -length / 2]) cube([_width, length, _slotSize]);
        }
    }
}

module createConnector(tabs, nutHolder){
    
    translate([0, 0, -_slotSize * (tabs * 2 - 1) / 2]){
        difference(){
            union(){
                // Tabs
                for (i = [0:tabs-1]){
                    translate([0, 0, _slotSize * i * 2])createTab();
                }
                
                // Nut holder
                if(nutHolder){
                    createNutHolder();
                }
            }
            translate([_width / 2 + 1, 0, -_delta/2]) cylinder(h = (tabs * 2 - 1) * _slotSize + _delta, d = _holeDiameter);
        }
    }
}

module createTab(){
    
    translate([_width / 2 + 1, 0, 0]){
        hull(){
            cylinder(h = _slotSize, d = _width);
            translate([-_width / 2 - 1, -_width / 2, 0]) cube([1, _width, _slotSize]);
        }
    }
}

module createNutHolder(){
    $fn = 6;
    d1 = 10.5;
    d2 = 14.5;
    translate([_width / 2 + 1, 0, -_slotSize]){
        difference(){
            cylinder(h = _slotSize, d1 = d1, d2 = d2);
            translate([0,0,-_delta/2]) cylinder(h = _slotSize + _delta, d = NutDiameter);
        }
    }
}

createAdaptor();