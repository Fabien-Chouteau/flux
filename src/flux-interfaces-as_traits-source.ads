with Flux.Interfaces.Source;
with Flux.Traits.Source;

with System.Storage_Elements; use System.Storage_Elements;

generic

   type Instance (<>)
   is new Flux.Interfaces.Source.Instance with private;

package Flux.Interfaces.As_Traits.Source
with Preelaborate
is

   procedure Read (This    : in out Instance;
                   Data    :    out Storage_Element;
                   Success :    out Boolean)
     with Inline;

   procedure Read (This : in out Instance;
                   Data :    out Storage_Array;
                   Last :    out Storage_Count)
     with Inline;

   package Traits is new Flux.Traits.Source (Instance, Read, Read);

end Flux.Interfaces.As_Traits.Source;
