with System.Storage_Elements; use System.Storage_Elements;
with Flux.Traits.Sink;
with GNAT.OS_Lib;

package Flux.Traits.File_IO.Sink
with Preelaborate
is
   procedure Write (This    : in out GNAT.OS_Lib.File_Descriptor;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
     with Inline;

   procedure Write (This : in out GNAT.OS_Lib.File_Descriptor;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
     with Inline;

   package Traits is new Flux.Traits.Sink
     (GNAT.OS_Lib.File_Descriptor, Write, Write);

end Flux.Traits.File_IO.Sink;
