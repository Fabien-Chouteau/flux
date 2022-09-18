with System;
with System.Storage_Elements; use System.Storage_Elements;

with Flux.Traits.Sink;
with Flux.Traits.Source;

package Flux.Traits.Memory_Duplex
with Preelaborate
is

   type Instance is record
      Base : System.Address;
      Len : Storage_Count;
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

end Flux.Traits.Memory_Duplex;
