with Flux.Interfaces.Source;
with Flux.Traits.Source;

with Flux.Interfaces.Sink;
with Flux.Traits.Sink;

with System.Storage_Elements; use System.Storage_Elements;

generic

   type Instance (<>)
   is new Flux.Interfaces.Source.Instance
      and Flux.Interfaces.Sink.Instance
   with private;

package Flux.Interfaces.As_Traits.Duplex
with Preelaborate
is

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
     with Inline;

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
     with Inline;

   package Source_Traits is new Flux.Traits.Source (Instance, Read, Read);

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
     with Inline;

   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
     with Inline;

   package Sink_Traits is new Flux.Traits.Sink (Instance, Write, Write);


end Flux.Interfaces.As_Traits.Duplex;
