with Flux.Interfaces.Sink;
with Flux.Traits.Sink;

with System.Storage_Elements; use System.Storage_Elements;

generic

   type Instance (<>)
   is new Flux.Interfaces.Sink.Instance with private;

package Flux.Interfaces.As_Traits.Sink
with Preelaborate
is

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
     with Inline;

   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
     with Inline;

   package Traits is new Flux.Traits.Sink (Instance, Write, Write);

end Flux.Interfaces.As_Traits.Sink;
