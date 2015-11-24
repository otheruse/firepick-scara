include <configuration.scad>
include <MCAD/teardrop.scad>
include <BedArm.scad>

module Bed_stabil_bracket(bsize = 16){
	difference(){
		union(){
			translate([(rodspacing)/2,0,0])
				Bed_stabil_clasp(bsize);
			translate([(rodspacing)/-2,0,0])
				mirror(){
					Bed_stabil_clasp(bsize);
				}
			difference(){
			  union(){
				translate([0,-14.5,25]){
					cube([rodspacing,3,50],center=true);
						
				}
			
				//translate([rodspacing/2,-12,0])
				//	rotate([0,0,-160])
				//		#cube([rodspacing/2, 3, 50]);
				//mirror()
				//	translate([rodspacing/2,-12,0])
				//		rotate([0,0,-160])
				//			cube([rodspacing/2, 3, 50]);

				translate([0,-25.5,1.5]){
					intersection(){
						cube ([rodspacing+20, 25, 3],center=true);
						translate([0,rodspacing*1.5-6,-2])	
							cylinder(r=rodspacing*1.5, h=5, $fn = 50);

					}			
				}
			  }
		
			  translate([rodspacing/2,0,0])
					cylinder(r=bsize*0.8, h=50);
			  translate([rodspacing/-2,0,0])
					cylinder(r=bsize*0.8, h=50);	
			}		

	
			cylinder(r=22,h=50);

			// Lead screw add section
			if (THREADLESS){

			}
			else{
				translate([0,-40,0])
				cylinder(r=11,h=50,$fn=6);

			translate([0,-20,5])
				cube([22,40,10],center=true);
			}
		}

		cylinder(r=19,h=50);
		translate([-25,-13,0])
		cube([50,50,50]);

		translate([45,-30,22])
			rotate([0,0,90])
				teardrop(16, 50, 90);
				
		translate([-45,-30,22])
			rotate([0,0,90])
				teardrop(16, 50, 90);
				
		// Lead screw subtraction section
		if (THREADLESS){

		}
		else {
			translate([0,-40,0])
				cylinder(r=8,h=6,$fn=6);
			translate([0,-40,9])
				cylinder(r=8,h=41,$fn=6);
			translate([0,-40,6.5])
				cylinder(r=4.5, h=10);
		}	

		// Magnet hole
		translate([rodspacing/-2+LMxUU/1.5, LMxUU*-1.756, 0])
			cylinder(d=5, h=3);
	
	}
}

module Bed_stabil_clasp(bsize=16){
	difference(){
		
		cylinder(r=bsize/2+8, h=50);
		translate([0,0,2])
			BedArmRight(bsize);
		cylinder(r=bsize/1.9,h=50);
		translate([0,bsize*.75,25])
			cube([bsize*3,bsize*1.5,52],center=true);
	}
}


Bed_stabil_bracket(16);

