// preview[view:south,tilt:top]

/* [Text Settings] */
first_name = "First Name";
last_name = "Last Name";
contact_text = "www.your.site.com";
contact_size = 100; // [50:100]
padding = 2; // [1:3]

/* [Card Size] */
card_width = 86; // [80:100]
card_height = 54; // [50:60]
card_thickness = 1; // [0.5:Thin,1:Normal,1.5:Thick]

/* [Millimeter Settings] */
millimeter_tick_length = 2.5; // [2.5:Normal,5:Long]
millimeter_tick_block = 10; // [5:5mm,10:10mm]

/* [Protractor Settings] */
protractor_tick_length = 2.5; // [2.5:Normal,5:Long]
protractor_tick_block = 10; // [10:10 Degrees,20:20 Degrees]


translate([0,0,card_thickness/2]) {
    fudge = 0.005; // for floating point errors
    padding = padding / 2;
    
    difference() {
        // The card base shape
        cardWidth = card_width;
        cardHeight = card_height;
        cardThickness = card_thickness;
        cube([cardWidth,cardHeight,cardThickness],true);
        
        // Card detail
        translate([0,0,cardThickness/2]) {
            
            // Millimiter measurements
            mmTickLength = millimeter_tick_length;
            mmTickBlock = millimeter_tick_block;
            mmNumberWidth = mmTickBlock-padding*2;
            mmNumberHeight = mmNumberWidth/len("10")*1.5; // Very approx
            mmNumberBottom = cardHeight/2-mmNumberHeight-mmTickLength;
            for (i = [0:1:cardWidth]) {
                canText = i + mmTickBlock < cardWidth;
                isLongTick = i%mmTickBlock == 0;
                tickLength = isLongTick ? mmTickLength*2: mmTickLength;
                tickPosition = i-cardWidth/2;
                tickOffset = cardHeight/2-tickLength/2;
                
                // Tickmark
                translate([tickPosition,tickOffset,0]) {
                    cube([.5,tickLength+fudge,cardThickness],true);
                }
                    
                // Numbers
                if(isLongTick && canText) {
                    mmBlock = i+mmTickBlock;
                    mmNumberText = mmBlock < 10 ? str("0", mmBlock) : str(mmBlock);
                    mmNumberLeft = tickPosition + padding;
                    translate([mmNumberLeft, mmNumberBottom, -cardThickness/2]) {
                        linear_extrude(height = cardThickness) {
                            resize([mmNumberWidth, 0], auto = true) {
                                text(mmNumberText,
                                    font = "Arial:style=Bold",
                                    size = 10,
                                    halign = "left",
                                    valign = "baseline"
                                );
                            }
                        }
                    }
                }
            }

            // Contact text
            contactText = contact_text;
            contactWidth = (cardWidth-padding*4)*contact_size/100;
            contactHeight = contactWidth/len(contactText)*1.5; // Very approx
            contactLimit = cardHeight/4;
            contactTall = contactHeight > contactLimit;
            contactBounds = contactTall ? [0,contactLimit] : [contactWidth,0];
            contactTop = -cardHeight/2+min(contactLimit,contactHeight)+padding;
            translate([0,contactTop,-cardThickness/2]) {
                linear_extrude(height = cardThickness) {
                    resize(contactBounds, auto=true) {
                        text(contactText,
                            font = "Arial:style=Bold",
                            size = 10,
                            halign = "center",
                            valign = "top"
                        );
                    }
                }
            }
            
            // Center detail           
            centerSize = mmNumberBottom-contactTop-padding*4;
            centerBottom = contactTop+padding*2;
            translate([0,centerBottom,0]) {
                
                // Protractor detail
                for (i = [0:2:180]) {
                    angle = 90-i;
                    isLongTick = abs(angle)%protractor_tick_block == 0;
                    tickLength = isLongTick ? protractor_tick_length*2 : protractor_tick_length;
                    tickTop = centerSize-protractor_tick_length*2+tickLength/2;
                    
                    // Tickmark
                    rotate(a=[0,0,angle]) {
                        translate([0,tickTop,0]) {
                            cube([.5,tickLength,cardThickness],true);
                        }
                    }
                }
                
                // Protractor cutout
                proCutOutter = centerSize-protractor_tick_length*2;
                proCutInner = proCutOutter-2;
                proCutHeight = cardThickness*2;
                translate([0,0,-cardThickness/2]) {
                    
                    // Ring cutout
                    difference() {
                        cylinder(h=proCutHeight,r=proCutOutter,center=true,$fn=90);
                        cylinder(h=proCutHeight,r=proCutInner,center=true,$fn=90);
                        translate([0,-cardHeight/2-1,0]) {
                            cube([cardWidth,cardHeight,proCutHeight],true);
                        }
                    }
                    
                    // Origin cutout
                    cylinder(h=proCutHeight,r=1.5,center=true,$fn=45);
                }
            
                // Name details
                nameBounds = proCutInner*2*sin(45)-padding*2;
                nameLimit = nameBounds/4-padding*2;
                
                // First Name
                fnameTall = nameBounds/len(first_name)*1.5 > nameLimit;
                fnameBounds = fnameTall ? [0,nameLimit] : [nameBounds,0];
                translate([0,nameBounds/2+padding,-cardThickness/2]) {
                    linear_extrude(height = cardThickness) {
                        resize(fnameBounds, auto=true) {
                            text(first_name,
                                font = "Arial:style=Bold",
                                size = 10,
                                halign = "center",
                                valign = "top"
                            );
                        }
                    }
                }
                
                // Last Name
                lnameTall = nameBounds/len(last_name)*1.5 > nameLimit;
                lnameBounds = lnameTall ? [0,nameLimit] : [nameBounds,0];
                translate([0,nameBounds/4+padding,-cardThickness/2]) {
                    linear_extrude(height = cardThickness) {
                        resize(lnameBounds, auto=true) {
                            text(last_name,
                                font = "Arial:style=Bold",
                                size = 10,
                                halign = "center",
                                valign = "top"
                            );
                        }
                    }
                }
                
            }
        }
    }
}
