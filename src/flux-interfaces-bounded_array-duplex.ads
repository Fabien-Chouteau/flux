with System.Storage_Elements; use System.Storage_Elements;

with Flux.Interfaces.Sink;
with Flux.Interfaces.Source;
with Flux.Interfaces.Seekable_Source;

package Flux.Interfaces.Bounded_Array.Duplex
with Preelaborate
is

   type Instance (Len : Storage_Count)
   is new Flux.Interfaces.Sink.Instance
      and Flux.Interfaces.Source.Instance
      and Flux.Interfaces.Seekable_Source.Instance
   with private;

   type Acc is access all Instance;

   procedure Reset (This : in out Instance);

   overriding
   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean);

   overriding
   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count);

   overriding
   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean);

   overriding
   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count);

   overriding
   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Element;
                            Success :    out Boolean);

   overriding
   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Array;
                            Last    :    out Storage_Count);

   overriding
   procedure Consume (This   : in out Instance;
                      Count  :        Storage_Count);

private

   type Instance (Len : Storage_Count)
   is new Flux.Interfaces.Sink.Instance
      and Flux.Interfaces.Source.Instance
      and Flux.Interfaces.Seekable_Source.Instance
   with record
      Data : Storage_Array (1 .. Len);
      Next_In : Storage_Count := 1;
      Next_Out : Storage_Count := 1;
   end record;

end Flux.Interfaces.Bounded_Array.Duplex;
