with System.Storage_Elements; use System.Storage_Elements;
with System;

with Flux.Traits.Source;

package Flux.Traits.Memory_Source
with Preelaborate
is

   type Instance is record
      Base : System.Address;
      Len : Storage_Count;
      Next : Storage_Count := 1;
   end record;

   type Acc is access all Instance;

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
     with Inline;

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
     with Inline;

   package Traits is new Flux.Traits.Source (Instance, Read, Read);

end Flux.Traits.Memory_Source;
