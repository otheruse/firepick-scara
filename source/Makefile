OPENSCAD:=$(shell which openscad)
TARGET=../stl

OPENSCAD_SETTINGS=$$fa=2;$$fs=0.2;

EXTRAS=configuration.scad shapes.scad

FILES=driveWheelRod.stl driveWheelTube.stl motorMountShort.stl motorMountLong.stl limitSwitchMount.stl pipeSupportLong.stl pipeSupportShort.stl BearingAdaptor.stl ZMountBottom.stl ZMountTop.stl BedArm.stl ZMountBracket.stl BearingScrew.stl BearingScrewMount.stl

PARTS=$(join $(addsuffix $(TARGET)/, $(dir $(FILES))), $(notdir $(FILES))) 


TARGETS=$(PARTS)

parts : $(TARGET) $(TARGETS)

$(TARGET)/driveWheelRod.stl: driveWheel.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);beltWheelRod(wheel_radius = 75);' $<

$(TARGET)/driveWheelTube.stl: driveWheel.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);beltWheelTube(wheel_radius = 75);' $<

$(TARGET)/motorMountShort.stl: motorMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);MotorMount(Height=50);' $<

$(TARGET)/motorMountLong.stl: motorMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);mirror()MotorMount(Height=70);' $<

$(TARGET)/limitSwitchMount.stl: limitSwitchHolder.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);limitSwitchHolder(rod_dia = rod_diameter);' $<

$(TARGET)/pipeSupportLong.stl: pipeSupport.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);pipeSupportLong();' $<

$(TARGET)/pipeSupportShort.stl: pipeSupport.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);pipeSupportShort();' $<

$(TARGET)/BearingAdaptor.stl: BearingAdaptor.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BearingAdaptor();' $<

$(TARGET)/ZMountBottom.stl: ZMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ZMountBottom(rodspacing=rodspacing, rodsize = rod_diameter+0.2);' $<

$(TARGET)/ZMountTop.stl: ZMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ZMountTop(rodspacing=rodspacing, rodsize = rod_diameter+0.2);' $<

$(TARGET)/BedArm.stl: BedArm.scad BearingMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BedArm(bearing_diameter = bearing_diameter, bearing_length = bearing_length);' $<

$(TARGET)/ZMountBracket.stl: BedStabilizerBracket.scad BearingMount.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);ZMountBracket(bearing_diameter = bearing_diameter, bearing_length = bearing_length);' $<

$(TARGET)/BearingScrew.stl: BearingScrew.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BearingScrew(lead = 3.2);' $<

$(TARGET)/BearingScrewMount.stl: BearingScrew.scad $(EXTRAS)
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);BearingScrewMount();' $<

#assembly: $(TARGET) $(TARGET)/assembly.stl

all: parts assembly


$(TARGET) :
	mkdir -p $(TARGET)

#$(TARGET)/%.stl : %.scad $(EXTRAS)
#	@echo "Processing $@"
#	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);$(subst $(TARGET)/,,$(subst .stl,();,$@))' $<


clean :
	rm -f $(TARGETS) $(TARGET)/assembly.stl

