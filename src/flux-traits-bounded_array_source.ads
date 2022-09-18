with System.Storage_Elements; use System.Storage_Elements;

with Flux.Traits.Source;
with Flux.Traits.Seekable_Source;

package Flux.Traits.Bounded_Array_Source
with Preelaborate
is

   type Instance (Len : Storage_Count) is record
      Data : Storage_Array (1 .. Len);
      Next : Storage_Count := 1;
   end record;

   type Acc is access all Instance;

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
     with Inline;

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
     with Inline;

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

   package Traits is new Flux.Traits.Source (Instance, Read, Read);

   package Seekable_Traits is new Flux.Traits.Seekable_Source
     (Traits, Seek_Relative, Seek_Relative, Consume);

end Flux.Traits.Bounded_Array_Source;
