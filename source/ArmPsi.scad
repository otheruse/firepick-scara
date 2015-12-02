include <MCAD/polyholes.scad>
include <MCAD/teardrop.scad>

include <configuration.scad>

module nutHole(size) {
    cylinder(d=nutDia(size), h= nutHeight(size));
}

module Fastener_stack()
{
	difference(){
		cylinder(r=15, h=40);
		translate([0,0,-1])
			//linear_extrude(height = 42)
				nutHole(8);//, proj = 1);

		translate([0,0,6])
			polyhole(42, 7.9);
			//cylinder(r=7.5, h=42, $fn=6);

		translate([0,0,34])
			//linear_extrude(height = 42)
				nutHole(8);//, proj = 1);

	}
}


module Bearing_recess (){		// Single recess
	intersection(){
		union(){
		
			//polyhole(12,22);
		//}
		//translate([0,0,-4])
			polyhole(9,22);
			cylinder(r1=12, r2=10, h=4);	
		}	
		cylinder (r1 = 20, r2=8, h=10);
	}
}

module Bearing_group (){			// Top and bottom
	translate([0,0,-1])
		union(){
			Bearing_recess();
			//cylinder(r=9,h=50);
			polyhole(50,20);
		}	
		translate([0,0,41])
			rotate([0,180,0])
				Bearing_recess();

}

module Bearing_stack()
{
	difference(){
		cylinder(r=15, h=40);	
		Bearing_group();
	}
}

module BeamProfile(){
	beamr = 13;
	intersection(){	
		translate([beamr-beamr*.4,0,0])
			//circle(r=beamr);
			projection()
				rotate([0,90,0])
					teardrop(beamr, 1, 90);

		translate([0,-beamr,0])
			square([beamr*2,beamr*2]);
	}
}


module BeamCross(){

	rotate([0,0,180]){
		difference(){
			BeamProfile();
			translate([2.5,0,0])	
				scale(.8)	
					BeamProfile();	
		}
	}
}

module Beam(StackRadius = 13, BeamLength = 150){
	difference(){
		union(){
			rotate([0,90,0])
				linear_extrude(height = BeamLength)
					BeamCross();
			translate([BeamLength/2,8,13])
				rotate([180,0,0])
					teardrop(3.5, BeamLength, 90);
			translate([BeamLength/2,10,9.5])
				rotate([180,0,0])
					teardrop(2.5, BeamLength, 90);


			translate([BeamLength/2,-8,13])
				rotate([180,0,0])
					teardrop(3.5, BeamLength, 90);
			translate([BeamLength/2,-10,9.5])
				rotate([180,0,0])
					teardrop(2.5, BeamLength, 90);

		}

		cylinder(r=StackRadius, h=40);
		translate([BeamLength,0,0])
			cylinder(r=StackRadius, h=40);
		translate([20,0,0])
			cylinder(r=4,h=40);
		translate([BeamLength-20,0,0])
			cylinder(r=4,h=40);
	}
}


module ArmPsiA(){
	
	Beam();

	difference(){
		Bearing_stack();
		rotate([0,45,0])
					cube([1,30,1],center=true);
	}	

	translate([150,0,0])
		difference(){
			Fastener_stack();
			rotate([0,45,0])
					cube([1,30,1],center=true);
		}

}

module ArmPsiB(){
	difference(){
		union(){
			Beam(StackRadius = 29/2);

			translate([150,0,0])
				Fastener_stack();

			// Flat area for 90deg calibration - Set square
			translate([150*.75, 12.5, 5])
				cube([75,5,10], center=true);

			
			
		}
	
		translate([-3,8,13])
			rotate([0,90,0])
				cylinder(r=1.5, h=45);

		translate([-3,-8,13])
			rotate([0,90,0])
				cylinder(r=1.5, h=45);
		translate([150,0,0])
			rotate([0,45,0])
					cube([1,30,1],center=true);

		translate([0,0,22])
			cylinder(r=20, h=10);
	}
	
}


//ArmPsiB();
