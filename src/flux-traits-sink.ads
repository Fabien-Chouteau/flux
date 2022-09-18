with System.Storage_Elements; use System.Storage_Elements;

generic
   type Sink_Type (<>) is limited private;

   pragma Warnings (Off, "not referenced");

   with procedure Write (This    : in out Sink_Type;
                         Data    :        Storage_Element;
                         Success :    out Boolean);

   with procedure Write (This : in out Sink_Type;
                         Data :        Storage_Array;
                         Last :    out Storage_Count);

   pragma Warnings (On, "not referenced");

package Flux.Traits.Sink
with Preelaborate
is

   subtype Instance is Sink_Type;
   type Acc is access all Instance;

end Flux.Traits.Sink;
