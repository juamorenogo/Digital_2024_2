
Se obtiene los logs de sintetizado del modulo. Se obtuvo los siguientes resultados relevantes:

``` verilog
3.49. Printing statistics.

=== LCD ===

   Number of wires:                150
   Number of wire bits:            297
   Number of public wires:         150
   Number of public wire bits:     297
   Number of ports:                 11
   Number of port bits:             11
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                241
     $scopeinfo                      1
     SB_CARRY                       44
     SB_DFF                         18
     SB_DFFE                        47
     SB_DFFESR                      21
     SB_DFFESS                       4
     SB_LUT4                       106
```

No se genero ningún warning, todo el proceso de sintetizado se realizo de manera adecuada. Se adjunta en la carpeta de codigo fuente los resultados obtenidos.

Sin embargo, el test bench usado no fue del todo adecuado ya que genera la siguiente salida:

```verilog
rm -rf sim
mkdir -p sim
iverilog  -o sim/LCD_tb.vvp LCD.v ticks_generator.v LCD_tb.v
cd sim && vvp LCD_tb.vvp -vcd
Time=0 RS=x E=x D=xxxxxxxx
Time=5000 RS=x E=0 D=xxxxxxxx
LCD_tb.v:34: $finish called at 1000000 (1ps)
gtkwave sim/LCD_tb.vcd

(process:17372): Gtk-WARNING **: 20:50:08.147: Locale not supported by C library.
        Using the fallback 'C' locale.

GTKWave Analyzer v3.3.120 (w)1999-2024 BSI

Error opening  .vcd file 'sim/LCD_tb.vcd'.
Why: No such file or directory
make: * [Makefile:73: wave] Error 255
```

Esto quiere decir que se genero un error en el archivo para gtk wave debido a que no se genero una correcta simulación. En otras palabras, aunque el modulo sintetiza y genera resultados, tiene diferentes problemas en su funcionamiento lógico. En particular solo genera 2 salidas con valores "Dont care".

