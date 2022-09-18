with System.Storage_Elements; use System.Storage_Elements;

generic
   type Source_Type (<>) is limited private;

   pragma Warnings (Off, "not referenced");

   with procedure Read (This    : in out Source_Type;
                        Data    :    out Storage_Element;
                        Success :    out Boolean);

   with procedure Read (This : in out Source_Type;
                        Data :    out Storage_Array;
                        Last :    out Storage_Count);

   pragma Warnings (On, "not referenced");

package Flux.Traits.Source
with Preelaborate
is

   subtype Instance is Source_Type;
   type Acc is access all Instance;

end Flux.Traits.Source;
