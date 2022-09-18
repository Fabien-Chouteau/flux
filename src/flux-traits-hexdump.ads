with Flux.Traits.Sink;
with Flux.Traits.Source;

package Flux.Traits.Hexdump
with Preelaborate
is

   generic
      with package Source is new Flux.Traits.Source (<>);
      with package Sink is new Flux.Traits.Sink (<>);
   procedure Encode (Src        : in out Source.Instance;
                     Dst        : in out Sink.Instance;
                     Success    :    out Boolean)
     with Inline;

end Flux.Traits.Hexdump;
