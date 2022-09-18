with System.Storage_Elements; use System.Storage_Elements;

with Flux.Interfaces.Source;

private with GNAT.OS_Lib;

package Flux.Interfaces.File_IO.Source
with Preelaborate
is

   type Instance
   is limited new Flux.Interfaces.Source.Instance
   with private;

   function Create (Path : String) return Instance;

   function Open (This : Instance) return Boolean;

   procedure Close (This : Instance);

   overriding
   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean);

   overriding
   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count);

private

   type Instance
   is limited new Flux.Interfaces.Source.Instance
   with record
      FD : GNAT.OS_Lib.File_Descriptor := GNAT.OS_Lib.Invalid_FD;
   end record;

end Flux.Interfaces.File_IO.Source;
