include <MCAD/polyholes.scad>
include <ArmPsi.scad>
include <configuration.scad>

module SupBeamProfile(){
	beamr = 13;
	translate([3.5,0,0])
		square([7,beamr*2-7],center=true);
	translate([3.5,9,0])
		circle(r=3.5,$fn=20);
	translate([3.5,-9,0])
		circle(r=3.5,$fn=20);
}


module SupBeamCross(){

	rotate([0,0,180])
		SupBeamProfile();
}


module SupBeam(){
	difference(){
		rotate([0,90,0])
			linear_extrude(height = 150)
				SupBeamCross();
		cylinder(r=13, h=40);
		translate([150,0,0])
			cylinder(r=13, h=40);
	}
}	




module ArmThetaA(){

	intersection(){
		union(){
			

			difference(){
				union(){
					SupBeam();
					cylinder(r=30/2, h=7, $fn = 50);
				}
				//cylinder(r=22/2, h=7, $fn = 50);
				translate([0,0,-1])
					polyhole(10,22);
				rotate([0,45,0])
					cube([1,30,1],center=true);
			}			

			//translate([150,0,0])
			//	Fastener_stack();
		}
		translate([-50,-25,0])
			cube([250,50,7]);
	}
	translate([150,0,0])
		difference(){
			cylinder(r=30/2, h=30, $fn = 50);
			translate([0,0,-1])
				polyhole(32, Drive_pipe_OD);
			//cylinder(r=22/2, h=30, $fn = 50);
			translate([0,0,20])
				rotate([90,0,0])
					cylinder(r=2,h=40, center=true);
			rotate([0,45,0])
					cube([1,30,1],center=true);
		}	
		
}

module ArmThetaB(){

	intersection(){
		union(){
			

			difference(){
				union(){
					SupBeam();
					cylinder(r=45/2, h=7, $fn = 50);
				}
				cylinder(r=37/2, h=7, $fn = 50);
				rotate([0,45,0])
					cube([1,50,1],center=true);
			}			

			translate([150,0,0])
				difference(){
					Fastener_stack();
					rotate([0,45,0])
						cube([1,30,1],center=true);
				}
		}
		translate([-50,-25,0])
			cube([250,50,7]);
	}

	difference(){
				cylinder(r=45/2, h=10, $fn = 50);
				translate([0,0,8])
					cylinder(r1=37/2, r2=35/2, h=1, $fn=50);
				cylinder(r=35/2,h=10, $fn=50);
				cylinder(r=37/2, h=8, $fn = 50);
				rotate([0,45,0])
					cube([1,50,1],center=true);
	}	
}

//ArmThetaB();