# ======================
# Makefile para simulación y síntesis de Verilog
# ======================

#Detectar mas archivos .v
FILES_MK := $(wildcard *.v)
SOURCES := $(filter-out %_tb.v, $(FILES_MK))

# Objetivos principales
help: help-sim help-syn
clean: clean-syn clean-sim clean-sim2

# Nombre del módulo principal del diseño (puede pasarse como argumento: make top=nombregenerico)
top ?= top

# Nombre del testbench (depende del nombre del módulo)
tb ?= $(top)_tb.v

# Macros adicionales para simulación y síntesis
MACROS_SIM=
MACROS_SYN=

# Archivos fuente adicionales para simulación (si los hay)
MORE_SRC2SIM?=

# Archivo principal del diseño en Verilog
DESIGN=$(top).v

# Carpeta para archivos generados
DIR_BUILD=build
DIR_SIM=sim

# Puerto serie para cargar bitstream en la FPGA
DEVSERIAL=/dev/ttyACM0

# Archivos generados durante la síntesis
JSON?=$(DIR_BUILD)/$(top).json
ASC?=$(DIR_BUILD)/$(top).asc
BISTREAM?=$(DIR_BUILD)/$(top).bin

# Archivo de restricciones físicas
PCF?=$(top).pcf


# ======================
# Reglas de simulación
# ======================

help-sim:
	@echo "\n## SIMULACIÓN Y RTL ##"
	@echo "\tmake top=<nombre> sim    -> Simular diseño y generar formas de onda"
	@echo "\tmake top=<nombre> wave   -> Ver formas de onda en GTKWave"

#Imprimir valor top
pt-top:
	@echo "El valor de top es:$(top)"


# Realizar simulación completa
sim: clean-sim iverilog-compile vpp-simulate wave

# Compilar diseño con Icarus Verilog
iverilog-compile:
	mkdir -p $(DIR_SIM)
	iverilog $(MACROS_SIM) -o $(DIR_SIM)/$(top)_tb.vvp $(DESIGN) $(tb)

# Ejecutar la simulación con vvp
vpp-simulate:
	cd $(DIR_SIM) && vvp $(top)_tb.vvp -vcd

# Ver formas de onda en GTKWave
wave:
	gtkwave $(DIR_SIM)/$(top)_tb.vcd

# Limpiar archivos generados por simulación
clean-sim:
	rm -rf $(DIR_SIM)

# ======================
# Reglas de rtl
# ======================

rtl: rtl-from-json view-svg

rtl-from-json: json-sim 
	netlistsvg $(DIR_SIM)/$(top).json -o $(DIR_SIM)/$(top).svg
	sed -i '/<svg/ a <rect width="100%" height="100%" fill="white"/>' $(DIR_SIM)/$(top).svg

view-svg:
	eog $(DIR_SIM)/$(top).svg

json-sim:
	mkdir -p $(DIR_SIM)
	yosys $(MACROS_SIM) -p 'prep -top $(top); hierarchy -check; proc; write_json $(DIR_SIM)/$(top).json' $(DESIGN)
	
# ======================
# Reglas de síntesis
# ======================

help-syn:
	@echo "\n## SÍNTESIS Y CONFIGURACIÓN ##"
	@echo "\tmake top=<nombre> syn    -> Sintetizar diseño"
	@echo "\tmake top=<nombre> config -> Configurar FPGA"

# Síntesis completa
syn: json asc bitstream

json:$(JSON)
asc:$(ASC)
bitstream:$(BISTREAM)

# Generar archivo JSON mediante Yosys
$(JSON): $(DESIGN)
	mkdir -p $(DIR_BUILD)
	yosys $(MACRO_SYN) -p "synth_ice40 -top $(top) -json $(JSON)" $(SOURCES)


# Place & Route con nextpnr
$(ASC):
	nextpnr-ice40 --hx4k --package tq144 --json $(JSON) --pcf $(PCF) --asc $(ASC)

# Generar bitstream final con icepack
$(BISTREAM): $(ASC)
	icepack $(ASC) $(BISTREAM)

# ======================
# Reglas de Configuracion
# ======================

# Configurar FPGA
config:
	stty -F $(DEVSERIAL) raw
	cat $(BISTREAM) > $(DEVSERIAL)

# Limpiar archivos generados por síntesis
clean-syn:
	rm -rf $(DIR_BUILD)

# ======================
# Reglas usos generales
# ======================

pereza: clean syn config

pt_minicom: 
	minicom "-D $(DEVSERIAL) -b 9600"

sim2: clean-sim2
	mkdir -p sim2
	iverilog -o sim2/$(top).vvp $(top).v
	vvp sim2/$(top).vvp 


clean-sim2:
	rm -rf sim2

