
with System.Storage_Elements; use System.Storage_Elements;

with Flux.Traits.Source;

generic
   with package Source is new Flux.Traits.Source (<>);

   pragma Warnings (Off, "not referenced");

   with procedure Seek_Relative (This    : in out Source.Instance;
                                 Offset  :        Storage_Count;
                                 Data    :    out Storage_Element;
                                 Success :    out Boolean);

   with procedure Seek_Relative (This    : in out Source.Instance;
                                 Offset  :        Storage_Count;
                                 Data    :    out Storage_Array;
                                 Last    :    out Storage_Count);

   with procedure Consume (This   : in out Source.Instance;
                           Count  :        Storage_Count);

   pragma Warnings (On, "not referenced");

package Flux.Traits.Seekable_Source
with Preelaborate
is

   subtype Instance is Source.Source_Type;
   type Acc is access all Instance;

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
                   renames Source.Read;

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
                   renames Source.Read;

end Flux.Traits.Seekable_Source;
