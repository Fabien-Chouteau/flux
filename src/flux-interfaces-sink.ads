with System.Storage_Elements; use System.Storage_Elements;

package Flux.Interfaces.Sink
with Preelaborate
is

   type Instance is limited interface;

   procedure Write (This    : in out Instance;
                    Data    :        Storage_Element;
                    Success :    out Boolean)
   is abstract;

   procedure Write (This : in out Instance;
                    Data :        Storage_Array;
                    Last :    out Storage_Count)
   is abstract;

end Flux.Interfaces.Sink;
