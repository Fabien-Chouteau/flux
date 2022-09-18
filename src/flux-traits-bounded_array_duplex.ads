with System.Storage_Elements; use System.Storage_Elements;

with Flux.Traits.Sink;
with Flux.Traits.Source;
with Flux.Traits.Seekable_Source;

package Flux.Traits.Bounded_Array_Duplex
with Preelaborate
is

   type Instance (Len : Storage_Count) is record
      Data : Storage_Array (1 .. Len);
      Next_In : Storage_Count := 1;
      Next_Out: Storage_Count := 1;
   end record;

   procedure Reset (This : in out Instance)
     with Inline;

   type Acc is access all Instance;

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
     with Inline;

   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
     with Inline;

   package Sink_Traits is new Flux.Traits.Sink (Instance, Write, Write);

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
     with Inline;

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
     with Inline;

   package Source_Traits is new Flux.Traits.Source (Instance, Read, Read);

   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Element;
                            Success :    out Boolean)
     with Inline;

   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Array;
                            Last    :    out Storage_Count)
     with Inline;

   procedure Consume (This  : in out Instance;
                      Count :        Storage_Count)
     with Inline;

   package Seekable_Traits is new Flux.Traits.Seekable_Source
     (Source_Traits, Seek_Relative, Seek_Relative, Consume);

end Flux.Traits.Bounded_Array_Duplex;
