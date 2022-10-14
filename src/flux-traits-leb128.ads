with Flux.Traits.Sink;
with Flux.Traits.Source;
with Flux.Traits.Seekable_Source;

package Flux.Traits.LEB128
with Preelaborate
is

   generic
      type T is mod <>;
      with package Sink is new Flux.Traits.Sink (<>);
   procedure Encode (S       : in out Sink.Instance;
                     Value   :        T;
                     Success :    out Boolean)
     with Inline;

   generic
      type T is mod <>;
      with package Source is new Flux.Traits.Source (<>);
   procedure Decode (S       : in out Source.Instance;
                     Value   : out T;
                     Success : out Boolean)
     with Inline;

   generic
      type T is mod <>;
      with package Source is new Flux.Traits.Seekable_Source (<>);
   procedure Decode_Seek (S       : in out Source.Instance;
                          Value   : out T;
                          Success : out Boolean)
     with Inline;

end Flux.Traits.LEB128;
