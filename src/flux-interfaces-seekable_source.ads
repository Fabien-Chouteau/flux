with System.Storage_Elements; use System.Storage_Elements;

package Flux.Interfaces.Seekable_Source
with Preelaborate
is

   type Instance is limited interface;

   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Element;
                            Success :    out Boolean)
   is abstract;

   procedure Seek_Relative (This    : in out Instance;
                            Offset  :        Storage_Count;
                            Data    :    out Storage_Array;
                            Last    :    out Storage_Count)
   is abstract;

   procedure Consume (This   : in out Instance;
                      Count  :        Storage_Count)
   is abstract;

end Flux.Interfaces.Seekable_Source;
