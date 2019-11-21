// 9 Volt Battery Tray

InnerWallThickness = 3;
OuterWallThickness = 4;
BottomThickness = 3;
TrayHeight = 20; // Overall height, includes BottomThickness

BatteryWidth = 26.5;
BatteryDepth = 17.5;
BatteryHeight = 48.5;
BatteryMargin = .5;

Rows    = 3; // in the BatteryDepth direction
Columns = 2; // In the BatteryWidth direction

module batteryHole() {
	cube(size=[BatteryWidth+BatteryMargin,
	           BatteryDepth+BatteryMargin,
	           BatteryHeight+BatteryMargin]);
}

module Base() {
	cube(size=[(BatteryWidth+BatteryMargin)*Columns + OuterWallThickness*2 + InnerWallThickness*(Columns-1),
               (BatteryDepth+BatteryMargin)*Rows    + OuterWallThickness*2 + InnerWallThickness*(Rows   -1),
	           TrayHeight]);
}

module BatteryTray() {
	// Subtract the batteries
	difference() {
		Base();
		for (row = [0:Rows-1])
			for (col = [0:Columns-1])
				translate(v=[OuterWallThickness + (BatteryWidth+BatteryMargin+InnerWallThickness)*col,
				             OuterWallThickness + (BatteryDepth+BatteryMargin+InnerWallThickness)*row,
				             BottomThickness])
					batteryHole();
	}
}

BatteryTray();
