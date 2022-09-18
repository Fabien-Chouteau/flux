with System.Storage_Elements; use System.Storage_Elements;

generic
   type Duplex_Type (<>) is limited private;

   pragma Warnings (Off, "not referenced");

   with procedure Write (This    : in out Duplex_Type;
                         Data    :        Storage_Element;
                         Success :    out Boolean);

   with procedure Write (This : in out Duplex_Type;
                         Data :        Storage_Array;
                         Last :    out Storage_Count);

   with procedure Read (This    : in out Duplex_Type;
                        Data    :    out Storage_Element;
                        Success :    out Boolean);

   with procedure Read (This : in out Duplex_Type;
                        Data :    out Storage_Array;
                        Last :    out Storage_Count);

   pragma Warnings (On, "not referenced");

package Flux.Traits.Duplex
with Preelaborate
is

   subtype Instance is Duplex_Type;
   type Acc is access all Instance;

end Flux.Traits.Duplex;
