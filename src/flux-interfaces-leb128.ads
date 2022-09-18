with Flux.Interfaces.Sink;
with Flux.Interfaces.Seekable_Source;

package Flux.Interfaces.LEB128
with Preelaborate
is
    generic
      type T is mod <>;
   procedure Encode (S       : in out Sink.Instance'Class;
                     Value   :        T;
                     Success :    out Boolean)
     with Inline;

   generic
      type T is mod <>;
   procedure Decode (S       : in out Seekable_Source.Instance'Class;
                     Value   : out T;
                     Success : out Boolean)
     with Inline;

end Flux.Interfaces.LEB128;
