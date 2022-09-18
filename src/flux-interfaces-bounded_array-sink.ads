with System.Storage_Elements; use System.Storage_Elements;

with Flux.Interfaces.Sink;

package Flux.Interfaces.Bounded_Array.Sink
with Preelaborate
is

   type Instance (Len : Storage_Count)
   is new Flux.Interfaces.Sink.Instance
   with private;

   overriding
   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean);

   overriding
   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count);

private

   type Instance (Len : Storage_Count)
   is new Flux.Interfaces.Sink.Instance
   with record
      Data : Storage_Array (1 .. Len);
      Next : Storage_Offset := 1;
   end record;

end Flux.Interfaces.Bounded_Array.Sink;
