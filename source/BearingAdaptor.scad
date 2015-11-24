include <configuration.scad>

module BearingAdaptor() {
    PipeFactor = 40/39.2;			// Multiplication factor for inner diameter 

	difference(){
		union(){
			cylinder(r=12.5,h=27);
			cylinder(r=14.5,h=20);


		}
		translate([0,0,-1])
			cylinder(h=32, d=22*PipeFactor);

	}
}



