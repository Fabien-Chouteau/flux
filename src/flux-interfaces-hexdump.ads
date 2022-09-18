with Flux.Interfaces.Sink;
with Flux.Interfaces.Source;

package Flux.Interfaces.Hexdump
with Preelaborate
is

   procedure Encode (Src     : in out Source.Instance'Class;
                     Dst     : in out Sink.Instance'Class;
                     Success :    out Boolean);

end Flux.Interfaces.Hexdump;
