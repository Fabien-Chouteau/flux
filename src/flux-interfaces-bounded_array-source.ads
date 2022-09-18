with System.Storage_Elements; use System.Storage_Elements;

with Flux.Interfaces.Source;

package Flux.Interfaces.Bounded_Array.Source
with Preelaborate
is

   type Instance (Len : Storage_Count)
   is new Flux.Interfaces.Source.Instance
   with private;

   overriding
   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean);

   overriding
   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count);
private

   type Instance (Len : Storage_Count)
   is new Flux.Interfaces.Source.Instance
   with record
      Data : Storage_Array (1 .. Len);
      Next : Storage_Offset := 1;
   end record;

end Flux.Interfaces.Bounded_Array.Source;
