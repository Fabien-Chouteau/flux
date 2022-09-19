
with System.Storage_Elements; use System.Storage_Elements;

with Flux.Interfaces.Sink;

with GNAT.OS_Lib;

package Flux.Interfaces.File_IO.Sink
with Preelaborate
is

   type Instance
   is limited new Flux.Interfaces.Sink.Instance
   with private;

   function Create (Path : String) return Instance;

   function Create (FD : GNAT.OS_Lib.File_Descriptor) return Instance;

   function Open (This : Instance) return Boolean;

   procedure Close (This : Instance);

   overriding
   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean);

   overriding
   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count);

private

   type Instance
   is limited new Flux.Interfaces.Sink.Instance
   with record
      FD : GNAT.OS_Lib.File_Descriptor := GNAT.OS_Lib.Invalid_FD;
   end record;

end Flux.Interfaces.File_IO.Sink;
