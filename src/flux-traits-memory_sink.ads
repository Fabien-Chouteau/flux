with System.Storage_Elements; use System.Storage_Elements;
with System;

with Flux.Traits.Sink;

package Flux.Traits.Memory_Sink
with Preelaborate
is

   type Instance is record
      Base : System.Address;
      Len : Storage_Count;
      Next : Storage_Count := 1;
   end record;

   type Acc is access all Instance;

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
     with Inline;

   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
     with Inline;

   package Traits is new Flux.Traits.Sink (Instance, Write, Write);

end Flux.Traits.Memory_Sink;
