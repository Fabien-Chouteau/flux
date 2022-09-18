with System.Storage_Elements; use System.Storage_Elements;

package Flux.Interfaces.Source
with Preelaborate
is

   type Instance is limited interface;

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
   is abstract;

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
   is abstract;

end Flux.Interfaces.Source;
